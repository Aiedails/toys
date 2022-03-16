#!/bin/bash

part_before_title="
\\\\documentclass{article}

\\\\usepackage{fancyhdr}
\\\\usepackage{extramarks}
\\\\usepackage{amsmath}
\\\\usepackage{amsthm}
\\\\usepackage{amsfonts}
\\\\usepackage{tikz}
\\\\usepackage[plain]{algorithm}
\\\\usepackage{algpseudocode}
\\\\usepackage{enumerate}
\\\\usepackage{tikz}

\\\\usetikzlibrary{automata,positioning}

%
% Basic Document Settings
%  

\\\\topmargin=-0.45in
\\\\evensidemargin=0in
\\\\oddsidemargin=0in
\\\\textwidth=6.5in
\\\\textheight=9.0in
\\\\headsep=0.25in

\\\\linespread{1.1}

\\\\pagestyle{fancy}
\\\\lhead{\\\\hmwkAuthorName}
\\\\chead{\\\\hmwkClass : \\\\hmwkTitle}
\\\\rhead{\\\\firstxmark}
\\\\lfoot{\\\\lastxmark}
\\\\cfoot{\\\\thepage}

\\\\renewcommand\\\\headrulewidth{0.4pt}
\\\\renewcommand\\\\footrulewidth{0.4pt}

\\\\setlength\\\\parindent{0pt}

%
% Create Problem Sections
%

\\\\newcommand{\\\\enterProblemHeader}[1]{
    \\\\nobreak\\\\extramarks{}{Problem \\\\arabic{#1} continued on next page\\\\ldots}\\\\nobreak{}
    \\\\nobreak\\\\extramarks{Problem \\\\arabic{#1} (continued)}{Problem \\\\arabic{#1} continued on next page\\\\ldots}\\\\nobreak{}
}

\\\\newcommand{\\\\exitProblemHeader}[1]{
    \\\\nobreak\\\\extramarks{Problem \\\\arabic{#1} (continued)}{Problem \\\\arabic{#1} continued on next page\\\\ldots}\\\\nobreak{}
    \\\\stepcounter{#1}
    \\\\nobreak\\\\extramarks{Problem \\\\arabic{#1}}{}\\\\nobreak{}
}

\\\\newcommand*\\\\circled[1]{\\\\tikz[baseline=(char.base)]{
		\\\\node[shape=circle,draw,inner sep=2pt] (char) {#1};}}


\\\\setcounter{secnumdepth}{0}
\\\\newcounter{partCounter}
\\\\newcounter{homeworkProblemCounter}
\\\\setcounter{homeworkProblemCounter}{1}
\\\\nobreak\\\\extramarks{Problem \\\\arabic{homeworkProblemCounter}}{}\\\\nobreak{}

%
% Homework Problem Environment
%
% This environment takes an optional argument. When given, it will adjust the
% problem counter. This is useful for when the problems given for your
% assignment aren't sequential. See the last 3 problems of this template for an
% example.
%

\\\\newenvironment{homeworkProblem}[1][-1]{
    \\\\ifnum#1>0
        \\\\setcounter{homeworkProblemCounter}{#1}
    \\\\fi
    \\\\section{Problem \\\\arabic{homeworkProblemCounter}}
    \\\\setcounter{partCounter}{1}
    \\\\enterProblemHeader{homeworkProblemCounter}
}{
    \\\\exitProblemHeader{homeworkProblemCounter}
}

%
% Homework Details
%   - Title
%   - Due date
%   - Class
%   - Instructor
%   - Class number
%   - Name
%   - Student ID
"

part_before_hw_number="
\\\\newcommand{\\\\hmwkTitle}{Homework\\\\ \\\\#"
part_after_hw_number_before_due_date="}
\\\\newcommand{\\\\hmwkDueDate}{"
part_after_due_date="}"
part_before_t1="
\\\\newcommand{\\\\hmwkClass}{Your Course}
\\\\newcommand{\\\\hmwkClassInstructor}{Your Pofes}

\\\\newcommand{\\\\hmwkClassID}{\\\\circled{1}}

\\\\newcommand{\\\\hmwkAuthorName}{Your Name}
\\\\newcommand{\\\\hmwkAuthorID}{Your Id}


%
% Title Page
%

\\\\title{
    \\\\vspace{2in}
    \\\\textmd{\\\\textbf{\\\\hmwkClass:\\\\\\\\  \\\\hmwkTitle}}\\\\\\\\
    \\\\normalsize\\\\vspace{0.1in}\\\\small{Due\\\\ date:\\\\ \\\\hmwkDueDate}\\\\\\\\
   % \\\\vspace{2in}\\\\Huge{\\\\hmwkClassID}\\\\\\\\
   \\\\vspace{3.7in}
}

\\\\author{
	Name: \\\\textbf{\\\\hmwkAuthorName} \\\\\\\\
	Student ID: \\\\hmwkAuthorID}
\\\\date{}

\\\\renewcommand{\\\\part}[1]{\\\\textbf{\\\\large Part \\\\Alph{partCounter}}\\\\stepcounter{partCounter}\\\\\\\\}

%
% Various Helper Commands
%

% Useful for algorithms
\\\\newcommand{\\\\alg}[1]{\\\\textsc{\\\\bfseries \\\\footnotesize #1}}
% For derivatives
\\\\newcommand{\\\\deriv}[1]{\\\\frac{\\\\mathrm{d}}{\\\\mathrm{d}x} (#1)}
% For partial derivatives
\\\\newcommand{\\\\pderiv}[2]{\\\\frac{\\\\partial}{\\\\partial #1} (#2)}
% Integral dx
\\\\newcommand{\\\\dx}{\\\\mathrm{d}x}
% Alias for the Solution section header
\\\\newcommand{\\\\solution}{\\\\textbf{\\\\large Solution}}
% Probability commands: Expectation, Variance, Covariance, Bias
\\\\newcommand{\\\\s}{\\\\textbf{\\\\textit{Solution:\\\\\\\\}}}

\\\\begin{document}

\\\\maketitle

\\\\pagebreak

"
part_before_problem="
\\\\begin{homeworkProblem}
"
part_before_graph="
\\\\begin{center}
"
part_after_graph="
\\\\end{center}
\\\\s
"
part_after_problem="
\\\\end{homeworkProblem}
"
part_after_document="
\\\\end{document}
"


dir="$1"
cd $dir 

echo "processing..."

# if docx
if (test -f *.docx); then
  echo "detect docx"
  # Let the file name become 1 letter
  if_need_process_file_name=$(fd ".docx" . | awk '{print (NF >= 2)}')
  if [ "$if_need_process_file_name" -eq "1" ]; then
    target=$(fd ".docx" . | awk 'NF >= 2 {gsub(/ /, ""); print}')
    mv *.docx $target
  else
    target=$(fd ".docx" .)
  fi

  # Now $target is the file we want to convert
  
  output_name="${dir}_test" # change after test.
  if [ ! -d "./media/" ] ; then
    mkdir media/
  fi
  echo "using pandoc..."
  pandoc --extract-media . $target -f pdf -o "${output_name}.tex"
  
  echo "using awk..."
  awk -v part_before_title="$part_before_title" \
    -v part_before_hw_number="$part_before_hw_number" \
    -v part_after_hw_number_before_due_date="$part_after_hw_number_before_due_date" \
    -v part_after_due_date="$part_after_due_date" \
    -v part_before_t1="$part_before_t1" \
    -v part_before_problem="$part_before_problem" \
    -v part_before_graph="$part_before_graph" \
    -v part_after_graph="$part_after_graph" \
    -v part_after_problem="$part_after_problem" \
    -v part_after_document="$part_after_document" \
    -f ../docx_convert.awk "${output_name}.tex" \
    > ./${output_name}_converted.tex

# if pdf
elif (test -f *.pdf); then
  echo "detect pdf"
  # Let the file name become 1 letter
  if_need_process_file_name=$(fd ".pdf" . | awk '{print (NF >= 2)}')
  if [ "$if_need_process_file_name" -eq "1" ]; then
    target=$(fd ".docx" . | awk 'NF >= 2 {gsub(/ /, ""); print}')
    mv *.pdf $target
  else
    target=$(fd ".pdf" .)
  fi

  output_name="${dir}_test" # change after test.

  echo "using pdftotext..."
  pdftotext $target ${target}.txt
  echo "using pdfimages..."
  pdfimages -png $target output_image
  if [ ! -d "./media/" ] ; then
    mkdir media/
  fi
  mv output_image* media/

  echo "using awk..."
  awk -v part_before_title="$part_before_title" \
    -v part_before_hw_number="$part_before_hw_number" \
    -v part_after_hw_number_before_due_date="$part_after_hw_number_before_due_date" \
    -v part_after_due_date="$part_after_due_date" \
    -v part_before_t1="$part_before_t1" \
    -v part_before_problem="$part_before_problem" \
    -v part_before_graph="$part_before_graph" \
    -v part_after_graph="$part_after_graph" \
    -v part_after_problem="$part_after_problem" \
    -v part_after_document="$part_after_document" \
    -f ../pdf_convert.awk "${target}.txt" \
    > ./${output_name}_converted.tex

  echo "remove txt file"
  rm ${target}.txt
fi
