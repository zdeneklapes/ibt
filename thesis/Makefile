# makefile pro preklad LaTeX verze Bc. prace
# makefile for compilation of the thesis
# (c) 2008 Michal Bidlo
# E-mail: bidlom AT fit vutbr cz
# Edited by: dytrych AT fit vutbr cz
#===========================================
# asi budete chtit prejmenovat / you will probably rename:
CO=xlapes02
CMD_PDFLATEX=pdflatex
CMD_BIBTEX=bibtex
OUT_DIR=./out
FLAGS=-synctex=1 -output-directory=$(OUT_DIR)
RM=rm -rfd

all: $(CO).pdf

pdf: $(CO).pdf

$(CO).ps: $(CO).dvi
	dvips $(CO)

$(CO).pdf: clean setup
	$(CMD_PDFLATEX) $(FLAGS) $(CO)
	-$(CMD_BIBTEX) $(OUT_DIR)/$(CO)
	$(CMD_PDFLATEX) $(FLAGS) $(CO)
	$(CMD_PDFLATEX) $(FLAGS) $(CO)

$(CO).dvi: $(CO).tex $(CO).bib
	latex $(CO)
	-bibtex $(CO)
	latex $(CO)
	latex $(CO)

clean:
	$(RM) $(OUT_DIR)
	find . -iname "*.log" -delete

setup:
	mkdir $(OUT_DIR)

pack:
	tar czvf $(CO).tar.gz *.tex *.bib *.bst ./template-fig/* ./bib-styles/* ./cls/* zadani.pdf $(CO).pdf Makefile Changelog

# Pozor, vlna neresi vse (viz popis.txt) / Warning - vlna is not solving all problems (see description.txt)
vlna:
	vlna -l $(CO)-*.tex

# Spocita normostrany / Count of standard pages
normostrany:
	echo "scale=2; `detex -n $(CO)-[01]*.tex | sed s/"^ *"/""/ | sed s/"^	*"/""/ | wc -c`/1800;" | bc
