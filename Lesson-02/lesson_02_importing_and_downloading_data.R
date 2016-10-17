# ==========================================================
#
#      Lesson 2 -- Importing and downloading data
#      •   Importing data from Excel
#      •   Downloading from UCSC
#      •   Downloading from ENSEMBL
#      •   Downloading from ENCODE
#
# ==========================================================

# Getting data from Excel
	# Get the excel file from this paper: "Gene expression profiling of breast cell lines identifies potential new basal markers". Supplementary table 1
	# Go into excel and save it as "Tab Delimited Text (.txt)"


filename <- "Lesson-02/micro_array_results_table1.txt"

my_data <- read.csv(filename, sep="\t", header=TRUE)
head(my_data)



# Where to find publicly available big data
# UCSC -- RefSeq genes from table browser
# Ensembl -- Mouse regulatory features MultiCell
# ENCODE -- HMM: wgEncodeBroadHmmGm12878HMM.bed


genes <- read.csv("Lesson-02/RefSeq_Genes", sep="\t", header=TRUE)
head(genes)
dim(genes)



regulatory_features <- read.csv("Lesson-02/RegulatoryFeatures_MultiCell.gff", sep="\t", header=FALSE)
head(regulatory_features)
dim(regulatory_features)



chromHMM <- read.csv("Lesson-02/wgEncodeBroadHmmGm12878HMM.bed", sep="\t", header=FALSE)
head(chromHMM)
dim(chromHMM)




