# 9/30/15
# R code for creating heatmap of log(fold-change) values for pathological endpoints
# Heatmap also ranks the strains and endpoints by their mean values for all endpoints and strains, respectively
# Adapted from http://sebastianraschka.com/Articles/heatmaps_in_r.html

# Clearing the workspace
rm(list = ls())

# Installing and requiring R packages gplots and RColorBrewer
if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
  library(gplots)
}

if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
}

# Reading in Log data.csv from directory
data <- read.csv("Log data.csv")

# Storing row names (Endpoints) in variable rnames
rnames <- data[,1]

# Creating column names (Strain) in variable cnames
cnames <- c("129","AJ","AKR","C3H","C57","DBA","FVB","NOD","NZO","WSB")

# Creating matrix out of Log data.csv data
mat_data <- data.matrix(data[,2:ncol(data)])

# Assigning row and column names to mat_data matrix from variables rnames and cnames, respectively
rownames(mat_data) <- rnames
colnames(mat_data) <- cnames

# Customizing color palette for heat map using RColorBrewer
my_palette <- colorRampPalette(c("green", "yellow", "red"))

# Saving image as a tiff
tiff(filename = "expression.tiff",
     width = 5*300,
     height = 5*300,
     res = 300,
     pointsize = 10)

# Creating the heatmap, which will be saved as a .tif file in the working directory
# NOTE: With Rowv and Colv set to TRUE, a dendrogram is computed for both the rows and the columnns, ranking them based on their means.
heatmap.2(mat_data,
          notecol = "black",
          density.info = "none",
          trace = "none",
          margins = c(12,9),
          col = my_palette,
          dendrogram = "none",
          Rowv = TRUE,
          Colv = TRUE,
          # Changing the color key x-label
          key = TRUE,
          key.xlab = "Log(Fold-Change)")

# Closing tiff() plotting device
dev.off()
