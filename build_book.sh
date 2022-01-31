export TEXINPUTS=".;;./buch/"
pdflatex ./buch/main.tex
# we need to compile twice for stuff like references and toc
pdflatex ./buch/main.tex