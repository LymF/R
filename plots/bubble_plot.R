library(ggplot2)
library(dplyr)
library(RColorBrewer)

# Read the data from the files
file_path_up <- 'C:\\Users\\Administrator\\Desktop\\Revigo\\Iw vs un upregulated revigo.tsv'
file_path_down <- 'C:\\Users\\Administrator\\Desktop\\Revigo\\Iw vs un Downregulated revigo.tsv'

# Read the data files
data_up <- read.delim(file_path_up, header = TRUE)
data_down <- read.delim(file_path_down, header = TRUE)

# Filter out unwanted pathways
data_filtered_up <- data_up %>%
  filter(!grepl("cellular process", Name, ignore.case = TRUE) & 
           !grepl("metabolic process", Name, ignore.case = TRUE)) %>%
  filter(Dispensability <= 0.01)

data_filtered_down <- data_down %>%
  filter(!grepl("cellular process", Name, ignore.case = TRUE) & 
           !grepl("metabolic process", Name, ignore.case = TRUE)) %>%
  filter(Dispensability <= 0.01)

# Create the bubble plot for upregulated pathways
ggplot(data_filtered_up, aes(x = Name, y = Uniqueness, size = log(Frequency, 2))) +
  geom_point(alpha = 0.5, color = "blue") +
  scale_size_continuous(range = c(1, 10)) +
  labs(x = "Pathways", y = "Uniqueness", size = "Frequency", title = "Upregulated Pathways") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Create the bubble plot for downregulated pathways
ggplot(data_filtered_down, aes(x = Name, y = Uniqueness, size = log(Frequency, 2))) +
  geom_point(alpha = 0.5, color = "red") +
  scale_size_continuous(range = c(1, 10)) +
  labs(x = "Pathways", y = "Uniqueness", size = "Frequency", title = "Downregulated Pathways") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
