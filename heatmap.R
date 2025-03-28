# Carregue as bibliotecas necessárias
library(pheatmap)

# Carregue os dados
Data <- read.csv("C:/Users/Administrator/Desktop/Anderson/salmon.tsv", row.names = 1, header = T, sep = "\t")

# Remova os valores NA e substitua por 0
Data[is.na(Data)] <- 0

# Calcule o agrupamento hierárquico
hr <- hclust(as.dist(1 - cor(t(Data), method = "pearson")), method = "complete")
hc <- hclust(as.dist(1 - cor(Data, method = "spearman")), method = "complete")

# Converta as colunas numéricas para log10
numeric_columns <- sapply(Data, is.numeric)
#Data[numeric_columns] <- log10(Data[numeric_columns] + 1)

# Defina a paleta de cores personalizada
my_palette <- colorRampPalette(c("blue", "white", "red", "yellow", "orange", "grey"))(100)

# Ajuste a paleta para que o valor 0 seja branco
my_palette[51] <- "white"

# Inverta a paleta de cores para que o valor mais alto corresponda à cor mais clara
my_palette <- rev(my_palette)

# Crie o heatmap com a paleta de cores personalizada
pheatmap(Data, cutree_rows = 1, angle_col = 90, clustering_distance_rows = "euclidean",
         cluster_cols = FALSE, clustering_method = "complete", border_color = "gray60",
         color = my_palette)
