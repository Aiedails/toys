# 
# Only work for number of images < 10

BEGIN {
  has_number = 0; # if the number is found
  in_title = 0; # true if in "\begin{enumerate}"
  has_print_number = 0;
  count = 0;
  print part_before_title;
}
# get homewoke number / due date
has_number == 0 && /^Homework/ { number = $2; # = substr($2, 1, length($2)-1); 
  print part_before_hw_number number part_after_hw_number_before_due_date;
  has_number = 1;
}

# In case the spell is wrong...
/^Due data/ {print $3; print part_after_due_date; print part_before_t1}
/^Due date/ {print $3; print part_after_due_date; print part_before_t1}

# match \begin{enumerate}. could be title
in_title == 0 && /^\[[0-9]+ point[a-z]*\]/ {in_title = 1; print part_before_problem}

# if not begin with "\item", print the title
in_title == 1 && !/^Figure/{print;}

# if match Figure, out of title. prepare for the graph part.
# AND print the graph. Notice that graph has only one line.
in_title == 1 && /^Figure [0-9]+/ {
  count = count + 1;
  in_title = 0; print part_before_graph; 
  print "\\includegraphics[width=0.4\\textwidth]{media/output_image-00" count-1 ".png}";
  print part_after_graph; print part_after_problem
}

END {
  print part_after_document
}
