install.packages('pheatmap')
install.packages('gplots')

library(pheatmap)
library(gplots)
library(viridis)

Data <- read.csv("/Users/Administrator/Desktop/merged_quant_data.csv", row.names = 1, header = T, sep = ",")



#rownames(Data) <- c("TtDV-1", "TtDV-2", "KVT-1", "KVT-2", "TtOV", "TtTV", "CVT", "TtNoV", "MVT-1", "ANT", "PVY", "CVA", "Dicistrovirus3",
                 #   "Bunya1 - GVT 2", "Phenuivirus GVT 3", "Acyrtro", "Bunyavirus2 GVT 4", "cal", "rps")


hr <- hclust(as.dist(1 - cor(t(Data), method = "pearson")), method = "complete")
hc <- hclust(as.dist(1-cor(Data, method="spearman")), method="complete")


numeric_columns <- sapply(Data, is.numeric)
Data[numeric_columns] <- log10(Data[numeric_columns] + 1)



#custom_colors <- colorRampPalette(c("black", "yellow"))(100)
#pheatmap(Data, cutree_rows = 1, angle_col = "90", clustering_distance_rows = "euclidean",
# cluster_cols = FALSE, clustering_method = "complete", color = custom_colors)

#gray_palette <- colorRampPalette(c("black", "red","purple"))(100)

viridis_color <- viridis(100)
pheatmap(Data, cutree_rows = 1,  angle_col = "90",  clustering_distance_rows = "euclidean",
         cluster_cols = FALSE,  clustering_method = "complete",border_color = "gray60", color = viridis_color)

pheatmap(Data, cutree_rows = 1,  angle_col = "90",  clustering_distance_rows = "euclidean",
         cluster_cols = FALSE,  clustering_method = "complete",border_color = "gray60")


Data2 <- read.csv("C:\\Users\\Lucas Melo\\Desktop\\heatmapeve.tabular",sep="\t")
rownames(Data2) <- c("Eve1", "Eve2" , "Eve3")

hr <- hclust(as.dist(1 - cor(t(Data2), method = "pearson")), method = "complete")
hc <- hclust(as.dist(1-cor(Data2, method="spearman")), method="complete")

numeric_columns2 <- sapply(Data2, is.numeric)
Data2[numeric_columns2] <- log10(Data2[numeric_columns2] + 1)

pheatmap(Data2, cutree_rows = 1,  angle_col = "90",  clustering_distance_rows = "euclidean",
         cluster_cols = FALSE ,  clustering_method = "complete",border_color = "gray60", cellheight = 10)


