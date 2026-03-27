library(readxl)
library(ggplot2)
library(dplyr)
library(forcats)
library(scales)
library(viridis) 


dados <- read_excel("/home/lucas/Documents/papers/bombus/dados.xlsx")

# Contar o número absoluto de EVEs por espécie e família viral
dados_contagem <- dados %>%
  group_by(Species,interprocdblast) %>%
  summarise(Count = n(), .groups = "drop")

# Calcular o número relativo de EVEs por espécie
dados_contagem <- dados_contagem %>%
  group_by(Species) %>%
  mutate(Relative = Count / sum(Count) * 100)

#dados_contagem <- dados_contagem[-55,]

# Gráfico de número absoluto de EVEs por espécie
grafico_absoluto <- ggplot(dados_contagem, aes(x = Count, y = fct_reorder(Species, Count), fill = interprocdblast)) +
  geom_bar(stat = "identity") +
  labs(x = "Número Absoluto de EVEs", y = "Espécie de Abelha", fill = "Família Viral") +
  scale_fill_viridis_d(option = "viridis") +  # Escolha entre "viridis", "magma", "plasma", "cividis"
  theme_minimal()

grafico_absoluto

# Gráfico de número relativo de EVEs por espécie
grafico_relativo <- ggplot(dados_contagem, aes(x = Relative, y = fct_reorder(Family, Count), fill = blastxprotein)) +
  geom_bar(stat = "identity") +
  labs(x = "Número Relativo de EVEs (%)", y = "Espécie de Abelha", fill = "Família Viral") +
  scale_x_continuous(labels = percent_format(scale = 1)) +
  scale_fill_viridis_d(option = "viridis") +
  theme_minimal()

grafico_relativo

