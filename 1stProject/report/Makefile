TEX_MAIN = optimization1.tex

all: optimization1

report: $(TEX_MAIN)
	latexmk -pdf  $(TEX_MAIN) 

clean:
	latexmk -C $(TEX_MAIN)
	rm -f *.bbl 