chapters    := $(wildcard chapters/*.tex)
frontmatter := $(wildcard frontmatter/*.tex)
endmatter   := $(wildcard endmatter/*.tex)
figures     := $(wildcard figures/*.pdf)
files       := $(chapters) $(frontmatter) $(endmatter) $(figures)
name        := dissertation
finalname   := $(name).final
draftname   := $(name).draft

$(name).pdf: $(name).tex $(frontmatter) $(chapters) $(figures) $(endmatter) references.bib Dissertate.cls 
	bash scripts/build $(name)

%.pdf: %.tex
	bash scripts/build $^
	cp $@ $(name).pdf

draft: $(draftname).pdf
$(draftname).tex: $(files)
	sed -e 's/^\\documentclass.\+/\\documentclass[draft]{Dissertate}/' $(name).tex > $(draftname).tex

final: $(finalname).pdf
$(finalname).tex: $(files)
	sed -e 's/^\\documentclass.\+/\\documentclass{Dissertate}/' $(name).tex > $(finalname).tex

clean:
	$(RM) $(name).aux $(name).bbl $(name).blg $(name).out $(name).toc $(name).lof $(name).lot $(name).bcf $(name).log
	$(RM) $(finalname).aux $(finalname).bbl $(finalname).blg $(finalname).out $(finalname).toc $(finalname).lof $(finalname).lot $(finalname).bcf $(finalname).log
	$(RM) chapters/*.aux chapters/*.bbl chapters/*.blg
	$(RM) .logged

mrproper: clean
	$(RM) $(name).pdf $(finalname).pdf $(finalname).tex
