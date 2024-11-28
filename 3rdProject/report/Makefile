TEX_MAIN = optimization3.tex

all: optimization3

optimization3: $(TEX_MAIN)
	latexmk -pdf $(TEX_MAIN) 

clean:
	latexmk -C $(TEX_MAIN)
	rm -f *.bbl 