all:lect1.pdf

extensions = +grid_tables+fenced_code_blocks+fenced_code_attributes+tex_math_dollars
extensions = 

lect1.pdf:lect1.md
	pandoc -f markdown$(extensions) -t beamer lect1.md -V theme:Warsaw --template template.beamer -o lect1.pdf


