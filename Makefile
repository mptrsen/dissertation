chapters := $(wildcard chapters/*.tex)
name := dissertation

$(name).pdf: $(name).tex $(chapters) references.bib Dissertate.cls
	bash scripts/build

clean:
	$(RM) $(name).aux $(name).bbl $(name).blg $(name).out $(name).toc $(name).lof $(name).lot
	$(RM) chapters/*.aux
	$(RM) .logged

mrproper: clean
	$(RM) $(name).pdf
