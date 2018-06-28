library(tidyverse)
library(cowplot)

rm(list = ls())

df <- read_tsv('tables/human-genome.tsv')

df$type <- factor(df$type, ordered = T, levels = df$type)

df$ypos <- 100 - cumsum(df$perc) + 1.3

plt <- ggplot(df, aes('', perc, fill = type)) 
plt <- plt + geom_bar(stat = 'identity') 
plt <- plt + geom_text(aes(x = 1, y = ypos, label = type))
plt <- plt + scale_fill_brewer(palette = 'BrBG')
plt <- plt + theme(axis.line.y = element_line(), axis.ticks.y = element_line())
plt <- plt + theme(axis.line.x = element_blank(), axis.ticks.x = element_blank(), axis.text.x = element_blank())
plt <- plt + xlab("") + ylab("Percent of human genome")
plt

save_plot("figures/human.svg", plot = plt, base_height = 19, units = 'cm')
