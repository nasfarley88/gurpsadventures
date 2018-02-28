SHELL=/bin/bash

all: main.pdf system51-player-guide.pdf

%.pdf: *.tex
	mkdir -p $(basename $@)_output
	ln -sf ${PWD}/images $(basename $@)_output/
	ln -sf ${PWD}/*.tex $(basename $@)_output/
	ln -sf ${PWD}/*.lua $(basename $@)_output/
	latexmk -interaction=nonstopmode -lualatex -cd $(basename $@)_output/$(basename $@).tex

clean:
	latexmk -CA
	rm -r *_output
