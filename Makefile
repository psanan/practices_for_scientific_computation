# Note that you can override things from the command line, for example
#  make LATEXMK=

PDFS = practices_for_scientific_computation.pdf

PDFLATEX = pdflatex --halt-on-error
BIBTEX   = bibtex
LATEXMK  = latexmk

all   : $(PDFS)

# Main compile with latexmk, if available, otherwise with brute force
ifndef LATEXMK
LATEXMK=
endif
ifeq (${LATEXMK},)
%.pdf : %.tex $(BIBFILES)
	$(PDFLATEX) $<
	$(BIBTEX) $(<:.tex=)
	$(PDFLATEX) $<
	$(PDFLATEX) $<
else
%.pdf : %.tex
	$(LATEXMK) $<
endif

# Clean everything (excluding final pdfs)
clean :
	rm -f *.aux *.log *.bbl *.blg *-blx.bib *.nav *.snm *.toc *.vrb *.run.xml *.out *.spl *.fls *.fdb_latexmk

.PHONY : all clean
