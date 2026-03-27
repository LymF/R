# Install and load libraries (if not already installed)
if (!require("sunburstR")) install.packages("sunburstR")
library(sunburstR)
library(dplyr)  # Add dplyr for data manipulation

# Sample data (ensure your data has a column named "type")
#data <- data.frame(
 # type = c("ssRNA+", "ssRNA+", "ssRNA+", "ssRNA+", "dsRNA", "ssRNA-", "ssRNA-", "ssRNA-", "ssRNA-"),
 # family = c("Nodaviridae", "Iflaviridae", "Virgaviridae", "Negevirus", "Partitiviridae", "Phenuiviridae", "Rhabdoviridae", "Rhabdoviridae", "Rhabdoviridae")
#)

# Colors for the slices (optional)
library(viridis)
colors <- replicate(15, paste0("#", paste0(sample(0:255, 3, replace=TRUE), collapse="")))

# Assuming "jessicadonutplot.csv" has relevant data
  dados <- read.csv("/Users/Administrator/Desktop/Rogerio/prografico.csv", sep = ",", header = F)
  dados<- read_excel("/home/lucas/Documents/papers/bombus/sunburst.xlsx")

# Adjust column names if necessary
colnames(dados) <- c("a", "b", "c")

viruses <- dados %>%
  select(a, b,c) %>%
  mutate(
    path = paste(a, b, c, sep = "-")  # Combine columns for path
  ) %>%
  slice(1:808) %>%  # Select first 68 rows (adjust as needed)
  mutate(
    V2 = 1  # Add a value column (can be replaced with your actual value)
  )

library(htmlwidgets)
# Create the sunburst chart with labels
sund2b(
  data = data.frame(xtabs(V2 ~ path, viruses)),  # Use the formatted data
  showLabels = TRUE,
  rootLabel = "Characterized virome",
  valueField = "size"# Specify the entire path for labels
)


# Create the sunburst chart
sb <- sund2b(
  data = data.frame(xtabs(V2 ~ path, viruses)),
  showLabels = TRUE,
  valueField = "size"
)



# Save the chart to an HTML file
saveWidget(sb, "sunburst_chart.html")
if (!require("webshot2")) install.packages("webshot2")
library(webshot2)

# Install/Check PhantomJS
webshot::install_phantomjs()


# Save the chart to an HTML file
saveWidget(sb, "sunburst_chart.html", selfcontained = TRUE)

# Convert the HTML file to a PDF
webshot2::webshot("sunburst_chart.html", "sunburst_chart.pdf", vwidth = 1200, vheight = 800, delay = 2)


