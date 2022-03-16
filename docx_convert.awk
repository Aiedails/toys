BEGIN {
  in_title = 0 # true if in "\begin{enumerate}"
  true_title = 0 # true if in "\item"
  has_print_number = 0
  print part_before_title
}
# get homewoke number / due date
/Homework/ { number = substr($2, 1, length($2)-1); 
  print part_before_hw_number number part_after_hw_number_before_due_date
}
/^Due date/ {print $3, $4, $5, $6; print part_after_due_date; print part_before_t1}

# match \begin{enumerate}. could be title
in_title == 0 && /^\\begin\{enumerate\}/ {in_title = 1; print part_before_problem}

in_title == 1 && /^\\item/ {true_title = 1;}

# if not begin with "\item", print the title
in_title == 1 && true_title == 1 && !/^\\item/{print;}

# if match \end{enumerate}, out of title. prepare for the graph part.
in_title == 1 && /^\\end\{enumerate\}/ {in_title = 0; true_title = 0; print part_before_graph}

# print the graph. Notice that graph has only one line.
in_title == 0 && /^\\includegraphics/ {print; print part_after_graph; print part_after_problem}

END {
  print part_after_document
}
