library(tidyverse)
g <- read_csv('/tmp/eukaryotes.csv')
g %>% 
	separate_rows(`Organism Groups`) %>%
	group_by(`Organism Groups`) %>%
	summarise(n = n()) %>%
	filter(!grepl("Animals|Eukaryota", `Organism Groups`)) %>%
	mutate(perc = n/sum(n)*100) %>% 
	summarise(s.n = sum(n), s.p = sum(perc))
