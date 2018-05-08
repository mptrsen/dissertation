chapters := $(wildcard chapters/*.tex)
name := dissertation

$(name).pdf: $(name).tex $(chapters)
	bash scripts/build

clean:
	$(RM) $(name).aux $(name).bbl $(name).blg $(name).out $(name).toc
	$(RM) chapters/*.aux

mrproper: clean
	$(RM) $(name).pdf
