DOC_NAME=ChainAPI_Mobiquitous2014
FIGURES=tidmarsh_arch.tex
WORDCOUNT=$(shell pdftotext ChainAPI_Mobiquitous2014.pdf - | wc | awk '{print $$2}')
PAGECOUNT=$(shell pdfinfo ChainAPI_Mobiquitous2014.pdf | grep Pages: | awk '{print $$2}')

default: $(DOC_NAME).pdf

watch:
	while true; do make --no-print-directory; make --no-print-directory stats; sleep 1; done

stats:
	@echo $(WORDCOUNT) words, $(PAGECOUNT) pages

%.pdf: %.tex Makefile refs.bib $(FIGURES)
	pdflatex -shell-escape $<
	bibtex $*
	pdflatex -shell-escape $<
	pdflatex -shell-escape $<
	rm $*.aux $*.log
