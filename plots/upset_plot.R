# Instale e carregue os pacotes necessários
if (!requireNamespace("UpSetR", quietly = TRUE)) {
  install.packages("UpSetR")
}
library(UpSetR)

# Leia os dados do arquivo CSV
dados <- read.csv("C:/Users/Administrator/Dropbox/Artigo Tetranychus truncatus virome/Microbiome/Viascomparacao.csv", header = TRUE, sep = ",")

# Crie o gráfico UpSet vertical
upset(dados, sets = 6, order.by = "freq")
