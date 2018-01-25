PROJECT_FOLDERS = $(wildcard */)
PROJECT_PDFS = $(patsubst %/,%/main.pdf,$(PROJECT_FOLDERS))
CIRCLE_PDFS = $(patsubst %/main.pdf,/tmp/circle-artifacts/%-main.pdf,$(PROJECT_PDFS))
SUB_FOLDER_PDFS = %/main.pdf

.PHONY: clean
.PRECIOUS: $(PROJECT_PDFS)

define clean_folder
	make -C $(1) clean
endef

all: $(PROJECT_PDFS)
	mkdir -p /tmp/circle-artifacts/gurpsadventures
	find . -name '*.pdf' -exec cp --parents \{\} /tmp/circle-artifacts/gurpsadventures \;
	@echo All projects made.

%/main.pdf: %/*.tex
	$(MAKE) -C $(shell dirname $<)

clean:
	for folder in $(PROJECT_FOLDERS); do cd $$folder; make clean; cd -; done
	rm -r /tmp/circle-artifacts
