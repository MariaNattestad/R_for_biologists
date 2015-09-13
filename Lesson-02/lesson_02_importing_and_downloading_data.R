
# Getting data from Excel
	# Get the excel file from this paper: "Gene expression profiling of breast cell lines identifies potential new basal markers". Supplementary table 1
	# Go into excel and save it as "Tab Delimited Text (.txt)"


filename <- "Lesson-02/micro_array_results_with_gene_names.Gene_expression_profiling_of_breast_cell_lines_identifies_potential_new_basal_markers.supplementary_table1.txt"

my_data <- read.csv(filename, sep="\t", header=TRUE)
head(my_data)



# Where to find publicly available big data
# UCSC -- RefSeq genes from table browser
# Ensembl -- Mouse regulatory features MultiCell
# ENCODE -- HMM: wgEncodeBroadHmmGm12878HMM.bed

# Here I save them to a folder on the Desktop called "data"

# View large files using "less -S" to see whether they have a header
genes <- read.csv("~/Desktop/data/RefSeq_Genes", sep="\t", header=TRUE)
head(genes)
dim(genes)



regulatory_features <- read.csv("~/Desktop/data/RegulatoryFeatures_MultiCell.gff", sep="\t", header=FALSE)
head(regulatory_features)
dim(regulatory_features)



chromHMM <- read.csv("~/Desktop/data/wgEncodeBroadHmmK562HMM.bed", sep="\t", header=FALSE)
head(chromHMM)
dim(chromHMM)




