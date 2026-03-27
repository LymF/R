# Install and load necessary packages
install.packages("vegan")
install.packages("tidyverse")

library(vegan)
library(tidyverse)

# Read the TSV file
data <- read.csv("shannonsalmon.tsv", header = TRUE, row.names = 1, sep = "\t")

# Transpose the table to have samples as rows and species as columns
otu_table <- t(data)

# Calculate Shannon diversity index
shannon_diversity <- diversity(otu_table, index = "shannon")

# Convert to a data frame for easier handling and plotting
shannon_df <- data.frame(Library = rownames(otu_table), Shannon = shannon_diversity)

# Ensure Library column is treated as a factor in the desired order
shannon_df$Library <- factor(shannon_df$Library, levels = shannon_df$Library)

# Print the Shannon diversity index
print(shannon_df)

# Plotting with ggplot, maintaining the original order of Library
ggplot(shannon_df, aes(x = Library, y = Shannon)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Shannon Diversity Index", x = "Library", y = "Shannon Diversity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
