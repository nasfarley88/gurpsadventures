PROJECT_FOLDERS = $(wildcard */)
PROJECT_PDFS = $(patsubst %/,%/main.pdf,$(PROJECT_FOLDERS))
MAIN_PDFS = $(patsubst %/main.pdf,%-main.pdf,$(PROJECT_PDFS))
SUB_FOLDER_PDFS = %/main.pdf

.PHONY: clean
.PRECIOUS: $(PROJECT_PDFS)

define clean_folder
	make -C $(1) clean
endef

all: $(MAIN_PDFS)
	if [[ -v CIRCLE_ARTIFACTS ]]; then \
		cp *.pdf ${$CIRCLE_ARTIFACTS}/;\
	else \
		echo Not in Circle CI\; no files copied.;\
	fi;
	@echo All projects made.

%-main.pdf: %/main.pdf
	cp $< $@

%/main.pdf: %/*.tex
	$(MAKE) -C $(shell dirname $<) -j$(nproc)

clean:
	for folder in $(PROJECT_FOLDERS); do cd $$folder; make clean; cd -; done
	rm $(MAIN_PDFS)
