all: cv print academic academic print

cv:
	xelatex cv.tex
	find . -name \*.aux -exec bibtex {} \;
	xelatex cv.tex
	xelatex cv.tex

print:
	echo "\PassOptionsToClass{print}{friggeri-cv}\input{cv.tex}" > cv-print.tex
	xelatex cv-print.tex
	find . -name \*.aux -exec bibtex {} \;
	xelatex cv-print.tex
	xelatex cv-print.tex
	rm cv-print.tex

academic:
	echo "\PassOptionsToClass{academic}{friggeri-cv}\input{cv.tex}" > cv-academic.tex
	xelatex cv-academic.tex
	find . -name \*.aux -exec bibtex {} \;
	xelatex cv-academic.tex
	xelatex cv-academic.tex
	rm cv-academic.tex

academic-print:	
	echo "\PassOptionsToClass{academic,print}{friggeri-cv}\input{cv.tex}" > cv-academic-print.tex
	xelatex cv-academic-print.tex
	find . -name \*.aux -exec bibtex {} \;
	xelatex cv-academic-print.tex
	xelatex cv-academic-print.tex
	rm cv-academic-print.tex

clean:
	find . -name cv\*-blx\* -delete
	rm -rf *.aux *.bbl *.blg *.log *.out *.xml *~
