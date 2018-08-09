chapters := $(wildcard chapters/*.tex)
figures  := $(wildcard figures/*.pdf)
name     := dissertation

$(name).pdf: $(name).tex $(chapters) $(figures) references.bib Dissertate.cls frontmatter/personalize.tex frontmatter/abstract.tex endmatter/colophon.tex
	bash scripts/build

clean:
	$(RM) $(name).aux $(name).bbl $(name).blg $(name).out $(name).toc $(name).lof $(name).lot
	$(RM) chapters/*.aux
	$(RM) .logged

mrproper: clean
	$(RM) $(name).pdf
