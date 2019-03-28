chapters := $(wildcard chapters/*.tex)
figures  := $(wildcard figures/*.pdf)
name     := dissertation
finalname := dissertation.final

$(name).pdf: $(name).tex $(chapters) $(figures) references.bib Dissertate.cls frontmatter/personalize.tex frontmatter/abstract.tex frontmatter/thanks.tex frontmatter/dedication.tex endmatter/colophon.tex endmatter/declaration.tex endmatter/cv.tex
	bash scripts/build $(name)

draft: $(name).pdf

final: $(finalname).pdf

$(finalname).pdf: $(finalname).tex
	bash scripts/build $(finalname)

$(finalname).tex:
	sed -e 's/^\\documentclass\[draft\]/\\documentclass/' $(name).tex > $(finalname).tex

clean:
	$(RM) $(name).aux $(name).bbl $(name).blg $(name).out $(name).toc $(name).lof $(name).lot $(name).bcf $(name).log
	$(RM) $(finalname).aux $(finalname).bbl $(finalname).blg $(finalname).out $(finalname).toc $(finalname).lof $(finalname).lot $(finalname).bcf $(finalname).log
	$(RM) chapters/*.{aux,bbl,blg}
	$(RM) .logged

mrproper: clean
	$(RM) $(name).pdf $(finalname).pdf $(finalname).tex
