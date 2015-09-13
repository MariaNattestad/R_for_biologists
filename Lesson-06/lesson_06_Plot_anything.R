# ==========================================================
#
#                         In Progress
#
# ==========================================================

library(ggplot2)
theme_set(theme_gray(base_size = 24))

# Loading the data
filename <- "Lesson-06/variants_from_assembly.bed"

my_data <- read.csv(filename, sep="\t", quote='', stringsAsFactors=TRUE,header=FALSE)

head(my_data)

names(my_data)

names(my_data) <- c("chrom","start","stop","name","size","strand","type","ref.dist","query.dist")

head(my_data)

# Filtering and polishing data
my_data <- my_data[my_data$chrom %in% c(seq(1,22),"X","Y","MT"),]

    # ordering chromosomes
my_data$chrom <- factor(gsub("chr", "", my_data$chrom, fixed=TRUE), levels=c(seq(1,22),"X","Y","MT"))
    # ordering types
my_data$type <- factor(my_data$type, levels=c("Insertion","Deletion","Expansion","Contraction"))


# Creating a bar plot
ggplot(my_data, aes(x=chrom,fill=type)) + geom_bar()


# Creating a histogram
ggplot(my_data, aes(x=size,fill=type)) + geom_bar()
ggplot(my_data, aes(x=size,fill=type)) + geom_bar() + xlim(0,500)
ggplot(my_data, aes(x=size,fill=type)) + geom_bar(binwidth=5) + xlim(0,500)

# Creating scatter plot
ggplot(my_data, aes(x=ref.dist,y=query.dist)) + geom_point()
    # color by type (categorical)
ggplot(my_data, aes(x=ref.dist,y=query.dist,color=type)) + geom_point()
ggplot(my_data, aes(x=ref.dist,y=query.dist,color=type)) + geom_point() + xlim(-500,500) + ylim(-500,500)
    # color by size (numerical)
ggplot(my_data, aes(x=ref.dist,y=query.dist,color=size)) + geom_point() + xlim(-500,500) + ylim(-500,500)
ggplot(my_data, aes(x=ref.dist,y=query.dist,color=size)) + geom_point() + xlim(-500,500) + ylim(-500,500) + scale_colour_gradient(limits=c(0,500))

# Creating box plots
ggplot(my_data, aes(x=type,y=size)) + geom_boxplot()
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_boxplot()
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_boxplot() + coord_flip()

# Creating violin plots
ggplot(my_data, aes(x=type,y=size)) + geom_violin()
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_violin() + ylim(0,1000) + guides(fill=FALSE)
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_violin(adjust=0.5) + ylim(0,1000) 
    # default adjust is 1, lower means finer resolution

# You can log-scale any numerical axis on any plot
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_violin() + scale_y_log10()

# Creating dot plots





