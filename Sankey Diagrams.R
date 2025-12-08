

library(networkD3)
library(dplyr)
library(tidyr)
library(tibble)
library(htmlwidgets)
library(webshot)

# Define the file path to the dataset
file_path <- "C:/Users/Victor Villa/OneDrive - CGIAR/FCM/Countries/Horn of Africa - IOM project/Village level analysis/paper/overleaf/graph/IOM_disp_graph_name.csv"

# Load dataset as a matrix, setting row names as origins
data_matrix <- as.matrix(read.csv(file_path, row.names=1, check.names=FALSE))

# Convert non-numeric values (if any) to numeric and replace NA values with 0
data_matrix[is.na(data_matrix)] <- 0

# Ensure the matrix only contains numerical values
data_matrix <- apply(data_matrix, 2, as.numeric)

# Convert matrix into a connection dataframe (links)
links <- data_matrix %>%
  as.data.frame() %>%
  rownames_to_column(var="source") %>%
  pivot_longer(cols = -source, names_to="target", values_to="value") %>%
  filter(value > 0)  # Remove zero-value flows

# Create a node data frame, ensuring sending countries are separated from receiving countries
nodes <- data.frame(name = unique(c(as.character(links$source), as.character(links$target))))

# Map sources and targets to numerical indices
links$IDsource <- match(links$source, nodes$name) - 1
links$IDtarget <- match(links$target, nodes$name) - 1

links <- links %>%
  mutate(source = recode(source,
                          "2" = "Ethiopia",
                          "1" = "DRC",
                          "3" = "South_Sudan",
                          "4" = "Uganda",
                         "5" = "Tanzania",
  ))

nodes <- nodes %>%
  mutate(name = recode(name,
                         "2" = "Ethiopia",
                         "1" = "DRC",
                         "3" = "South_Sudan",
                         "4" = "Uganda",
                         "5" = "Tanzania",
  ))

# Generate the Sankey diagram with correct left-to-right alignment
sankey <- sankeyNetwork(
  Links = links, Nodes = nodes,
  Source = "IDsource", Target = "IDtarget",
  Value = "value", NodeID = "name",
  fontSize = 14, nodeWidth = 30, nodePadding = 15,
  sinksRight = TRUE,  # Ensures correct left-right alignment
)



# Display the Sankey diagram in RStudio
sankey




# Define the file path to the dataset for not displaced
file_path <- "C:/Users/Victor Villa/OneDrive - CGIAR/FCM/Countries/Horn of Africa - IOM project/Village level analysis/paper/overleaf/graph/IOM_not_disp_graph_name.csv"

# Load dataset as a matrix, setting row names as origins
data_matrix <- as.matrix(read.csv(file_path, row.names=1, check.names=FALSE))

# Convert non-numeric values (if any) to numeric and replace NA values with 0
data_matrix[is.na(data_matrix)] <- 0

# Ensure the matrix only contains numerical values
data_matrix <- apply(data_matrix, 2, as.numeric)

# Convert matrix into a connection dataframe (links)
links <- data_matrix %>%
  as.data.frame() %>%
  rownames_to_column(var="source") %>%
  pivot_longer(cols = -source, names_to="target", values_to="value") %>%
  filter(value > 0)  # Remove zero-value flows

# Create a node data frame, ensuring sending countries are separated from receiving countries
nodes <- data.frame(name = unique(c(as.character(links$source), as.character(links$target))))

# Map sources and targets to numerical indices
links$IDsource <- match(links$source, nodes$name) - 1
links$IDtarget <- match(links$target, nodes$name) - 1

links <- links %>%
  mutate(source = recode(source,
                         "2" = "Ethiopia",
                         "1" = "DRC",
                         "3" = "South_Sudan",
                         "4" = "Uganda",
                         "5" = "Tanzania",
  ))

nodes <- nodes %>%
  mutate(name = recode(name,
                       "2" = "Ethiopia",
                       "1" = "DRC",
                       "3" = "South_Sudan",
                       "4" = "Uganda",
                       "5" = "Tanzania",
  ))

# Generate the Sankey diagram with correct left-to-right alignment
sankey <- sankeyNetwork(
  Links = links, Nodes = nodes,
  Source = "IDsource", Target = "IDtarget",
  Value = "value", NodeID = "name",
  fontSize = 14, nodeWidth = 30, nodePadding = 15,
  sinksRight = TRUE,  # Ensures correct left-right alignment
)



# Display the Sankey diagram in RStudio
sankey
