# Carregar pacotes necessários
if (!require("readxl")) install.packages("readxl", dependencies=TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies=TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies=TRUE)
if (!require("scales")) install.packages("scales", dependencies=TRUE)
if (!require("viridis")) install.packages("viridis", dependencies=TRUE)

library(readxl)
library(ggplot2)
library(dplyr)
library(scales)
library(viridis)

# Definir caminho do arquivo
file_path <- "/Users/Administrator/Desktop/dali/donut-quant-oldpipe.xlsx"

# Ler o arquivo Excel (assumindo que os dados estão na primeira aba e têm cabeçalho)
dados <- read_excel(file_path)

# Verificar estrutura dos dados
print(head(dados))

# Verificar se os dados possuem as colunas esperadas
if (!all(c("miRNAs", "TPM", "percent") %in% colnames(dados))) {
  stop("O arquivo deve conter colunas chamadas 'miRNAs', 'TPM' e 'percent'.")
}

# Ordenar dados pela abundância (TPM) de forma decrescente
dados <- dados %>% arrange(desc(TPM))

# Criar labels com porcentagem
dados <- dados %>% 
  mutate(Label = paste0(round(percent, 2), "%"))

# Criar o donut plot
ggplot(dados, aes(x = 3, y = TPM, fill = reorder(miRNAs, -TPM))) +
  geom_bar(stat = "identity", width = 0.3, color = "white") +  # Donut mais fino
  coord_polar(theta = "y", start = 0) +
  theme_void() +
  theme(legend.position = "right", legend.title = element_text(face = "bold")) +
  geom_text(aes(x = 3.5, label = Label), position = position_stack(vjust = 0.5), size = 5, color = "black") +
  scale_fill_viridis_d() +  # Paleta Viridis
  xlim(1, 4) 
