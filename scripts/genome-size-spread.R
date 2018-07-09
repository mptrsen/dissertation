library(tidyverse)
rm(list = ls())

vert <- read_tsv('/home/mpetersen/projects/dynamics-of-genome-size-evolution-in-insects/data/genome-sizes/vertebrates.csv')
arth <- read_tsv('/home/mpetersen/projects/dynamics-of-genome-size-evolution-in-insects/data/genome-sizes/genome_size_data_insecta+crustacea_norefs.csv')
chel <- read_tsv('/home/mpetersen/projects/dynamics-of-genome-size-evolution-in-insects/data/genome-sizes/chelicerata.csv')
moll <- read_tsv('/home/mpetersen/projects/dynamics-of-genome-size-evolution-in-insects/data/genome-sizes/mollusca.csv')
anne <- read_tsv('/home/mpetersen/projects/dynamics-of-genome-size-evolution-in-insects/data/genome-sizes/annelida.csv')
nema <- read_tsv('/home/mpetersen/projects/dynamics-of-genome-size-evolution-in-insects/data/genome-sizes/nematoda.csv')
plat <- read_tsv('/home/mpetersen/projects/dynamics-of-genome-size-evolution-in-insects/data/genome-sizes/platyhelminthes.csv')

# remove giant-genomed lungfish (Lepidosireniformes) and lose some vertebrate columns
vert <- vert %>% 
	filter(Order != 'Lepidosireniformes') %>% 
	select(-References, -`Std sp`, -`Common Name`) %>% 
	separate_rows(`Chrom num`) %>% 
	mutate(`Chrom num` = as.integer(`Chrom num`))

chel <- chel %>% select(-References, -`Std sp`, -`Common Name`)

# remove duplicate header and separate rows with C-value ranges
arth <- arth %>%
	filter(Phylum != 'Phylum') %>%
	separate_rows(`C-value`) %>% 
	separate_rows(`Chrom num`) %>% 
	mutate(`C-value` = as.double(`C-value`), `Chrom num` = as.integer(`Chrom num`))

moll <- moll %>% 
	mutate(Class = sub("Bivavlia", "Bivalvia", Class)) %>% 
	separate_rows(`C-value`) %>% 
	separate_rows(`Chrom num`) %>% 
	mutate(`C-value` = as.double(`C-value`), `Chrom num` = as.integer(`Chrom num`))

nema <- nema %>% 
	select(-References, -`Std sp`, -`Common Name`) %>% 
	separate_rows(`C-value`) %>% 
	separate_rows(`Chrom num`) %>% 
	mutate(`C-value` = as.double(`C-value`), `Chrom num` = as.integer(`Chrom num`))

anne <- anne %>% 
	select(-References, -`Std sp`, -`Common Name`) %>% 
	separate_rows(`C-value`) %>% 
	separate_rows(`Chrom num`) %>% 
	mutate(`C-value` = as.double(`C-value`), `Chrom num` = as.integer(`Chrom num`))

plat <- plat %>% 
	select(-References, -`Std sp`, -`Common Name`)

gs <- arth %>% bind_rows(vert, chel, moll, anne, nema, plat)

gs %>%
	group_by(Phylum, `Sub Phylum`,Class) %>% 
	summarise(n = n(), min = min(`C-value`), max = max(`C-value`), fold = round(max/min, digits=2)) %>% 
	filter(n > 20) %>% 
	write_tsv('tables/genome-size-spread.tsv')
