LOC=${HOME}/work/texinputs/

pandoc --template=${LOC}/pandoc_template_xofy.tex lec03_diff.md -o lec03_diff.pdf


pandoc --template=${LOC}/pandoc_template_xofy.tex outline.md -o outline.pdf
