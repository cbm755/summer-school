LOC=${HOME}/work/texinputs/

pandoc --template=${LOC}/pandoc_template_xofy.tex lec05_timestepping.md -o lec05_timestepping.pdf

pandoc --template=${LOC}/pandoc_template_xofy.tex lec06_pdes.md -o lec06_pdes.pdf

pandoc --template=${LOC}/pandoc_template_xofy.tex lec07_2d.md -o lec07_2d.pdf
