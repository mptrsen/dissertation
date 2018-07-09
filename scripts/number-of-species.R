library(tidyverse)
library(cowplot)
library(scales)

dt <- tibble(
	group = c("protists", "insects", "bacteria and archaea", "fungi", "other animals", "plants"),
	n = c(55000, 750000, 5000, 67000, 280000, 270000 )
)

total <- sum(dt$n)

dt <- dt %>% mutate(perc = percent(dt$n/total), label = paste0(group, ' (', n, ')'))

blank_theme <- theme_minimal() +
	theme(axis.title = element_blank(), axis.title.y = element_blank(),
				axis.text.x = element_blank(), axis.text.y = element_blank(),
				panel.border = element_blank(), panel.grid = element_blank(),
				axis.ticks = element_blank()
				)

plt <- ggplot(dt, aes(1, n, fill = group)) + geom_bar(stat = 'identity', width = 1)
plt <- plt + scale_fill_brewer(palette = 'BrBG')
plt <- plt + coord_polar('y')
plt <- plt + blank_theme
plt <- plt + geom_text(aes(y = n, label = label))
print(plt)

# don't overwrite by accident!
#save_plot('figures/number-of-species.svg', plot = plt)
