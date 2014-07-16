DOC_NAME=ChainAPI_Mobiquitous2014

default: $(DOC_NAME).pdf

%.pdf: %.tex Makefile refs.bib
	pdflatex $<
	bibtex $*
	pdflatex $<
	pdflatex $<
	rm $*.aux $*.log
