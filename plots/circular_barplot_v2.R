# IMPORTAR databases
library(dplyr)

allClass <- read.csv("../quantification_tables/allClass.csv", header = TRUE)

# Listas com IDs de proteínas, 1 por linha
unknown <- read.table("protIDs/unknown_ids.txt", header = FALSE)
# Coluna com as classes dos IDs
unknown$V2 <- rep("unknown",743)
TNL <- read.table("protIDs/TNL_ids.txt", header = FALSE)
TNL$V2 <- rep("TNL",18)
TN <-  read.table("protIDs/TN_ids.txt", header = FALSE)
TN$V2 <- rep("TN",3)
T_class <- read.table("protIDs/T_ids.txt", header = FALSE)
T_class$V2 <- rep("T",4)
RPW8NL <- read.table("protIDs/RPW8NL_ids.txt", header = FALSE)
RPW8NL$V2 <- rep("RPW8NL",3)
# vazio RLP <- read.table("protIDs/RLP_ids.txt", header = FALSE)
RLKGNK2 <- read.table("protIDs/RLKGNK2_ids.txt", header = FALSE)
RLKGNK2$V2 <- rep("RLKGNK2",31)
RLK <- read.table("protIDs/RLK_ids.txt", header = FALSE)
RLK$V2 <- rep("RLK",102)
NL <- read.table("protIDs/NL_ids.txt", header = FALSE)
NL$V2 <- rep("NL",40)
N <- read.table("protIDs/N_ids.txt", header = FALSE)
N$V2 <- rep("N",11)
MLO <- read.table("protIDs/MLO_ids.txt", header = FALSE)
MLO$V2 <- rep("MLO",28)
CNL <- read.table("protIDs/CNL_ids.txt", header = FALSE)
CNL$V2 <- rep("CNL",173)
CN <- read.table("protIDs/CN_ids.txt", header = FALSE)
CN$V2 <- rep("CN",18) 

##### JOIN #########

classes <- rbind(CN,CNL,MLO,N,NL,RLK,RLKGNK2,RPW8NL,T_class,TN,TNL,unknown)

df <- left_join(allClass, classes, by = c("V1" = "V1"))
colnames(df)[51] <- "index"
allClass <- df


####################

colnames(allClass)

A_leaf <- allClass[,c(4:8,51)]
row_sum <- rowSums(A_leaf[,c(1:9)])
A_leaf <- A_leaf[row_sum > 20, ]
A_leaf <- A_leaf %>% filter(index != 'unknown')

C_leaf <- allClass[,c(9:12,51)]
row_sum <- rowSums(C_leaf[,c(1:9)])
C_leaf <- C_leaf[row_sum > 20, ]
C_leaf <- C_leaf %>% filter(index != 'unknown')


E_leaf <- allClass[,c(13:27,51)]
row_sum <- rowSums(E_leaf[,c(1:15)])
E_leaf <- E_leaf[row_sum > 30, ]
E_leaf <- E_leaf %>% filter(index != 'unknown')

stem <- allClass[,c(28:32,51)]
row_sum <- rowSums(stem[,c(1:5)])
stem <- stem[row_sum > 15, ]
stem <- stem %>% filter(index != 'unknown')

bud <- allClass[,c(33:36,51)]
row_sum <- rowSums(bud[,c(1:4)])
bud <- bud[row_sum > 15, ]
bud <- bud %>% filter(index != 'unknown')

root <- allClass[,c(37:40,51)]
row_sum <- rowSums(root[,c(1:4)])
root <- root[row_sum > 15, ]
root <- root %>% filter(index != 'unknown')

apex <- allClass[,c(41:45,51)]
row_sum <- rowSums(apex[,c(1:5)])
apex <- apex[row_sum > 15, ]
apex <- apex %>% filter(index != 'unknown')


# Contagem de classes em cada tecido ########################
# Apex
apex_counts <- table(apex$index)
apex_counts <- as.data.frame(apex_counts)
colnames(apex_counts) <- c("group", "value")
apex_counts$individual <- rep("Apex",11)
# Bud
bud_counts <- table(bud$index)
bud_counts <- as.data.frame(bud_counts)
colnames(bud_counts) <- c("group", "value")
bud_counts$individual <- rep("Bud",11)
# Mature Leaves
matlev_counts <- table(E_leaf$index)
matlev_counts <- as.data.frame(matlev_counts)
colnames(matlev_counts) <- c("group", "value")
matlev_counts$individual <- rep("E-leaff",11)
# Root
root_counts <- table(root$index)
root_counts <- as.data.frame(root_counts)
colnames(root_counts) <- c("group", "value")
root_counts$individual <- rep("Root",11)
# Stem
stem_counts <- table(stem$index)
stem_counts <- as.data.frame(stem_counts)
colnames(stem_counts) <- c("group", "value")
stem_counts$individual <- rep("Stem",11)
# Young Leaves
Ayounglev_counts <- table(A_leaf$index)
Ayounglev_counts <- as.data.frame(Ayounglev_counts)
colnames(Ayounglev_counts) <- c("group", "value")
Ayounglev_counts$individual <- rep("A-leaf",11)

Cyounglev_counts <- table(C_leaf$index)
Cyounglev_counts <- as.data.frame(Cyounglev_counts)
colnames(Cyounglev_counts) <- c("group", "value")
Cyounglev_counts$individual <- rep("C-leaf",11)

# Create data
data <- bind_rows(apex_counts,bud_counts,matlev_counts,Ayounglev_counts,Cyounglev_counts,stem_counts,root_counts)

# PLOT ###########################

library(tidyverse)
library(ggplot2)

# Create dataset
#data <- data.frame(
  #individual=paste( "Mister ", seq(1,60), sep=""),
  #group=c( rep('A', 10), rep('B', 30), rep('C', 14), rep('D', 6)) ,
  #value=sample( seq(10,100), 60, replace=T)
#)

# Set a number of 'empty bar' to add at the end of each group
empty_bar <- 3
to_add <- data.frame( matrix(NA, empty_bar*nlevels(data$group), ncol(data)) )
colnames(to_add) <- colnames(data)
to_add$group <- rep(levels(data$group), each=empty_bar)
data <- rbind(data, to_add)
data <- data %>% arrange(group)
data$id <- seq(1, nrow(data))

# Get the name and the y position of each label
label_data <- data
number_of_bar <- nrow(label_data)
angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust <- ifelse( angle < -90, 1, 0)
label_data$angle <- ifelse(angle < -90, angle+180, angle)

# prepare a data frame for base lines
base_data <- data %>% 
  group_by(group) %>% 
  summarize(start=min(id), end=max(id) - empty_bar) %>% 
  rowwise() %>% 
  mutate(title=mean(c(start, end)))

# prepare a data frame for grid (scales)
grid_data <- base_data
grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
grid_data$start <- grid_data$start - 1
grid_data <- grid_data[-1,]

# Make the plot
p <- ggplot(data, aes(x=as.factor(id), y=value, fill=group)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar(aes(x=as.factor(id), y=value, fill=group), stat="identity", alpha=0.5) +
  
  # Add a val=100/75/50/25 lines. I do it at the beginning to make sur barplots are OVER it.
  geom_segment(data=grid_data, aes(x = end, y = 80, xend = start, yend = 80), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  geom_segment(data=grid_data, aes(x = end, y = 60, xend = start, yend = 60), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  geom_segment(data=grid_data, aes(x = end, y = 40, xend = start, yend = 40), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  geom_segment(data=grid_data, aes(x = end, y = 20, xend = start, yend = 20), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  
  # Add text showing the value of each 100/75/50/25 lines
  annotate("text", x = rep(max(data$id),4), y = c(20, 40, 60, 80), label = c("20", "40", "60", "80") , color="grey", size=3 , angle=0, fontface="bold", hjust=1) +
  
  geom_bar(aes(x=as.factor(id), y=value, fill=group), stat="identity", alpha=0.5) +
  ylim(-100,120) +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  coord_polar() + 
  geom_text(data=label_data, aes(x=id, y=value+10, label=individual, hjust=hjust), color="black", fontface="bold",alpha=0.6, size=2.5, angle= label_data$angle, inherit.aes = FALSE ) + 
  
  # Add base line information
  geom_segment(data=base_data, aes(x = start, y = -5, xend = end, yend = -5), colour = "black", alpha=0.8, size=0.6 , inherit.aes = FALSE )  +
  geom_text(data=base_data, aes(x = title, y = -40, label=group), #hjust=c(1,1,0,0)
            , colour = "black", alpha=0.8, size=3, fontface="bold", inherit.aes = FALSE)

p

