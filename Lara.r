# Instalar e carregar os pacotes necessários
install.packages("FactoMineR")
install.packages("factoextra")
install.packages("readxl")
install.packages("ggrepel")
library(FactoMineR)
library(factoextra)
library(readxl)
library(ggrepel)

# Ler a tabela de dados do arquivo Excel
dados <- read_excel("C:/Users/Administrator/Desktop/Lara/dadoslara.xlsx")

# Converter a coluna 'maximo' para numérica
dados$maximo <- as.numeric(as.character(dados$maximo))

# Realizar a Análise de Correspondência Múltipla (MCA), incluindo 'maximo' como variável quantitativa suplementar
resultado_mca <- MCA(dados, quali.sup = 12, quanti.sup = 13, graph = FALSE)

# Destacar os genótipos "Matriz - VB1151" e "Matriz - CCN51" com cores diferentes
dados$highlight <- ifelse(dados$Genótipo == "Matriz - VB1151", "blue", 
                          ifelse(dados$Genótipo == "Matriz - CCN51", "red", NA))

# Visualizar os resultados, destacando os genótipos Matriz - VB1151 e Matriz - CCN51
fviz_mca_ind(resultado_mca, repel = TRUE, label = "none") +
  geom_point(aes(color = dados$highlight), size = 2.5, na.rm = TRUE) +
  geom_text_repel(aes(label = dados$Isolado, color = dados$highlight), size = 3, na.rm = TRUE) +
  scale_color_manual(name = "Genótipo", 
                     values = c("blue" = "blue", "red" = "red"),
                     labels = c("Matriz - CCN51", "Matriz - VB1151")) +
  theme(legend.position = "right")






library(FactoMineR)
library(factoextra)
library(readxl)
library(cluster)
library(dendextend)

# Ler a tabela de dados do arquivo Excel
dados <- read_excel("C:/Users/Administrator/Desktop/Lara/dadoslara.xlsx")

# Transformar as variáveis categóricas em fatores
dados[] <- lapply(dados, as.factor)

# Converter a coluna 'maximo' para numérica
dados$maximo <- as.numeric(as.character(dados$maximo))

# Calcular a matriz de distâncias usando o método Gower para dados mistos
dist_matrix <- daisy(dados, metric = "gower")

# Realizar a clusterização hierárquica
hc <- hclust(dist_matrix, method = "ward.D2")

# Converter para dendrograma e usar dendextend para personalização
dend <- as.dendrogram(hc)

# Definir as cores dos rótulos dos isolados com base nos genótipos
label_colors <- ifelse(dados$Genótipo == "Matriz - VB1151", "red", 
                       ifelse(dados$Genótipo == "Matriz - CCN51", "blue", "black"))
labels_colors <- setNames(label_colors, dados$Isolado)

# Aplicar cores aos rótulos usando dendextend
dend <- dend %>%
  set("labels", dados$Isolado) %>%
  set("labels_col", labels_colors)

# Plotar o dendrograma com os rótulos coloridos
plot(dend, main = "Dendrograma dos Isolados", xlab = "", sub = "", cex = 0.6)

# Adicionar legenda para os genótipos
legend("topright", legend = c("Matriz - CCN51", "Matriz - VB1151"), 
       col = c("blue", "red"), pch = 16, title = "Genótipo")


