
TEX_NAME=H4404_Prolog

TEX_BUILD_FLAGS= -interaction=nonstopmode -file-line-error

CLEAN_CMD=rm -f
CLEAN_CMD+= *.backup *.aux *.toc *.ind *.idx *.ilg *.blg *.log *.out *.bbl *.dvi
CLEAN_CMD+= *.nav *.pyg *.snm *.lof *.glg *.glo *.gls *.acn *.acr *.alg *.ist
CLEAN_CMD+= 2> /dev/null

.PHONY: build clean

build: $(TEX_NAME).pdf

clean:
	@$(CLEAN_CMD)
	@rm -f $(TEX_NAME).pdf
	@echo "# cleaned" ;

%.pdf: %.tex $(wildcard *.tex)
	@$(CLEAN_CMD)
	@echo "# build stage 1" ;												\
	pdflatex $(TEX_BUILD_FLAGS) "$<" ;										\
	OK=$$? ;																\
	if [ $$OK -eq 0 ]; then													\
		echo "# build stage 2" ;											\
		pdflatex $(TEX_BUILD_FLAGS) "$<" ;									\
		OK=$$? ;															\
	fi;																		\
	if [ $$OK -eq 0 ]; then													\
		echo "# build stage 3" ;											\
		pdflatex $(TEX_BUILD_FLAGS) "$<" ;									\
		OK=$$? ;															\
	fi;																		\
	if [ $$OK -eq 0 ]; then													\
		echo "# build <$@> finished" ;										\
	fi;
	@$(CLEAN_CMD)
