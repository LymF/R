# Load necessary library
library(pheatmap)

# Load the data
Data <- read.csv("C:/Users/Administrator/Desktop/salmon/Supplementary file 3.csv", row.names = 1, header = TRUE, sep = ",")


# Transformação logarítmica para normalizar dados
numeric_columns <- sapply(Data, is.numeric)
Data[numeric_columns] <- log10(Data[numeric_columns] + 1)

# Criação do heatmap com a cor padrão do pheatmap
pheatmap(Data, 
         cutree_rows = 1, 
         angle_col = "90", 
         clustering_distance_rows = "euclidean",
         cluster_cols = FALSE, 
         clustering_method = "complete", 
         border_color = "black")'


# Segundo Heatmap
Data2 <- read.csv("C:\\Users\\Lucas Melo\\Desktop\\heatmapeve.tabular", sep="\t")
rownames(Data2) <- c("Eve1", "Eve2" , "Eve3")

# Transformação logarítmica para normalizar dados
numeric_columns2 <- sapply(Data2, is.numeric)
Data2[numeric_columns2] <- log10(Data2[numeric_columns2] + 1)

# Criação do heatmap com a cor padrão do pheatmap
pheatmap(Data2, 
         cutree_rows = 1, 
         angle_col = "90", 
         clustering_distance_rows = "euclidean",
         cluster_cols = FALSE, 
         clustering_method = "complete", 
         border_color = "gray60", 
         cellheight = 10)
