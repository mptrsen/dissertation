chapters := $(wildcard chapters/*.tex)
name := dissertation

$(name).pdf: $(name).tex $(chapters) references.bib
	bash scripts/build

clean:
	$(RM) $(name).aux $(name).bbl $(name).blg $(name).out $(name).toc
	$(RM) chapters/*.aux

mrproper: clean
	$(RM) $(name).pdf
