TEX_MAIN = optimization4.tex

all: optimization4

optimization4: $(TEX_MAIN)
	latexmk -pdf $(TEX_MAIN) 

clean:
	latexmk -C $(TEX_MAIN)
	rm -f *.bbl 