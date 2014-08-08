DOC_NAME=ChainAPI_Mobiquitous2014
DRAFT_NAME=$(DOC_NAME)_draft
FIGURES=tidmarsh_arch.tex
WORDCOUNT=$(shell pdftotext $(DOC_NAME).pdf - | wc | awk '{print $$2}')
PAGECOUNT=$(shell pdfinfo $(DOC_NAME).pdf | grep Pages: | awk '{print $$2}')

default: $(DOC_NAME).pdf

watch:
	while true; do make --no-print-directory; make --no-print-directory stats; sleep 2; done

stats:
	@echo $(WORDCOUNT) words, $(PAGECOUNT) pages

publish: $(DRAFT_NAME).pdf

$(DRAFT_NAME).pdf: $(DOC_NAME).pdf
	cp $(DOC_NAME).pdf $(DOC_NAME)_draft.pdf

# include .git/logs/HEAD so that make will rebuild after a commit, which updates the git hash
%.pdf: %.tex Makefile refs.bib $(FIGURES) .git/logs/HEAD vc.sh
	# stick git version info into vc.tex
	./vc.sh > vc.tex

	pdflatex -shell-escape $<
	bibtex $*
	pdflatex -shell-escape $<
	pdflatex -shell-escape $<
	rm $*.aux $*.log
