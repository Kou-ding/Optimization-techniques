TEX_MAIN = optimization2.tex

all: optimization2

optimization2: $(TEX_MAIN)
	latexmk -pdf $(TEX_MAIN) 

clean:
	latexmk -C $(TEX_MAIN)
	rm -f *.bbl 