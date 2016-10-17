# ==========================================================
#
#      Lesson 8 -- Heatmaps
#      •   Dendrograms
#      •   To cluster or not to cluster
#      •   Flipping axes
#      •   Specifying distance calculation and clustering methods
#      •   Annotate sides of heatmap with associated data
#          (chromosomes, genders, samples)
#      •   Coloring branches in dendrograms
#
# ==========================================================
# The ComplexHeatmap package is downloaded from the bioconductor website, not from the packages tab like we did with the other packages
# https://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html

# Run the first time to install:
# source("https://bioconductor.org/biocLite.R")
# biocLite("ComplexHeatmap")

library(ComplexHeatmap)


# Heatmap from single-cell copy number data

# Select a data file
filename <- "Lesson-08/copy_number_data.txt"

# Read the data into a data.frame
my_data <- read.table(filename, sep="\t", quote="", stringsAsFactors=FALSE,header=TRUE)

head(my_data)

dim(my_data) # (rows columns)

nrow(my_data) # rows: locations (bins) in genome
ncol(my_data) # columns: cells

# Make the heatmap data into a matrix
my_matrix <- as.matrix(my_data[  ,c(4:100)]) # [all rows, columns 4-100]
# leave out the first 3 columns (chrom,start,end) since they don't belong in the heatmap itself

# We can check the classes:
class(my_data)
class(my_matrix)

head(my_matrix)

# Save chromosome column for annotating the heatmap later
chromosome_info <- data.frame(chrom = my_data$CHR)
chromosome_info



## Now we make our first heatmap 

# Default parameters
Heatmap(my_matrix)

# Flip rows and columns around
my_matrix <- t(my_matrix)  # "transpose"
Heatmap(my_matrix)

# Keep genome bins in order, not clustered
Heatmap(my_matrix, cluster_columns=FALSE)

fontsize <- 0.6

# Put cell labels on the left side
Heatmap(my_matrix, cluster_columns=FALSE,
        row_names_side = "left", 
        row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize))

# Make the dendrogram wider
Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize),
        row_hclust_width = unit(3, "cm"))

# Different distance calculation methods
# "euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski", "pearson", "spearman", "kendall"
# euclidean is the default

# Different clustering methods
# "ward.D", "ward.D2", "single", "complete", "average" (= UPGMA), "mcquitty" (= WPGMA), "median" (= WPGMC) or "centroid" (= UPGMC)

# Watch the dendrogram and heatmap change when we change the methods
Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize),
        row_hclust_width = unit(3, "cm"),
        clustering_distance_rows ="maximum",
        clustering_method_rows = "ward.D")


# Coloring clusters in dendrogram

# install dendextend
library(dendextend)
# Need to build dendrogram first so we can use it for the color_brances() function
# 1. calculate distances (method="maximum")
# 2. cluster (method="ward.D")
dend = hclust(dist(my_matrix,method="maximum"),method="ward.D")

Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize),
        row_hclust_width = unit(3, "cm"),
        cluster_rows = color_branches(dend, k = 3))


# We can split the heatmap into clusters

Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize),
        row_hclust_width = unit(3, "cm"),
        clustering_distance_rows ="maximum",
        clustering_method_rows = "ward.D",
        km=2) # number of clusters you want



# Split columns of plot up into chromosomes using extra_info
chromosome_info

chromosome.colors <- c(rep(c("black","white"),11),"red")
chromosome.colors

names(chromosome.colors) <- paste("chr",c(seq(1,22),"X"),sep="")
chromosome.colors


Heatmap(my_matrix, 
        cluster_columns=FALSE,
        row_names_side = "left", 
        row_hclust_side = "left",
        row_names_gp=gpar(cex=fontsize),
        row_hclust_width = unit(3, "cm"),
        clustering_distance_rows ="maximum",
        clustering_method_rows = "ward.D",
        km=2, # number of clusters you want
        bottom_annotation = HeatmapAnnotation(chromosome_info,col = list(chrom=chromosome.colors),show_legend=FALSE)
        )

