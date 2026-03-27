library(tidyverse)
library(ggalluvial)

# Seus dados
data_bar <- data.frame(
  stringsAsFactors = FALSE,
  Viral_family = c("Tombusviridae", "Virgaviridae", "Potyviridae", "Dicistroviridae", 
                   "Narnaviridae", "Nodaviridae", "Kitaviridae", "Endornaviridae", "Pircornavirales",
                   "Rhabdoviridae","Phenuiviridae", "Birnaviridae", "Qinviridae", "Reovirales"),
  ssassRNApos = c(1,1,1,1,1,1,1,1,6,0,0,0,0,0),
  sscssRNAneg = c(0,0,0,0,0,0,0,0,0,2,1,0,0,0),
  ssbdsRNA = c(0,0,0,0,0,0,0,0,0,0,0,2,1,1)
)

# Melt dos dados para ter uma coluna para a amostra e uma coluna para a porcentagem
data_bar_melted <- data_bar %>%
  pivot_longer(cols = starts_with("ss"), names_to = "Sample", values_to = "Percentage") %>%
  mutate(perc = Percentage * 100 / sum(Percentage))

# Plot
data_bar_melted %>%
  ggplot(aes(y = perc, x = Sample, fill = as.character(Viral_family))) +
  geom_flow(aes(alluvium = Viral_family), alpha = .5, color = "white",
            curve_type = "linear", 
            width = .5) +
  geom_col(width = .5, color = "white") +
  scale_fill_brewer(palette = "RdBu")+
  scale_y_continuous(NULL, expand = c(0,0)) +
  cowplot::theme_minimal_hgrid() +
  theme(panel.grid.major = element_blank(), 
        axis.text.y = element_blank(), 
        axis.ticks.y = element_blank())
