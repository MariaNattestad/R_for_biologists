# ==========================================================
#
#      Lesson 6 -- Plot anything
#      •   Bar plots
#      •   Histograms
#      •   Scatter plots
#      •   Box plots
#      •   Violin plots
#      •   Density plots
#      •   Dot-plots
#      •   Line-plots for time-course data
#      •   Pie charts
#      •   Venn diagrams (compare two or more lists of genes)
#
# ==========================================================


# ==========================================================
#
#      New data set for exploring plotting: variants
#
# ==========================================================

library(ggplot2)
theme_set(theme_gray(base_size = 18))

# Loading the data
filename <- "Lesson-06/variants_from_assembly.bed"

my_data <- read.csv(filename, sep="\t", quote='', stringsAsFactors=TRUE,header=FALSE)

head(my_data)

names(my_data)

names(my_data) <- c("chrom","start","stop","name","size","strand","type","ref.dist","query.dist")

head(my_data)
summary(my_data$chrom)

# Filtering and polishing data
my_data <- my_data[my_data$chrom %in% c(seq(1,22),"X","Y","MT"),]

    # ordering chromosomes
my_data$chrom <- factor(my_data$chrom, levels=c(seq(1,22),"X","Y","MT"))
    # ordering types
my_data$type <- factor(my_data$type, levels=c("Insertion","Deletion","Expansion","Contraction"))

####################################################################


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
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_violin(adjust=0.2) + ylim(0,1000) + guides(fill=FALSE)
    # default adjust is 1, lower means finer resolution

# You can log-scale any numerical axis on any plot
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_violin() + 
    scale_y_log10()

# Creating a density plot
ggplot(my_data, aes(x=size,fill=type)) + geom_density() + xlim(0,500)
    # similar to this histogram:
ggplot(my_data, aes(x=size,fill=type)) + geom_bar(binwidth=5) + xlim(0,500)

ggplot(my_data, aes(x=size,fill=type)) + geom_density(position="stack") + xlim(0,500)
ggplot(my_data, aes(x=size,fill=type)) + geom_density(alpha=0.5) + xlim(0,500)

# Sneak peak at Lesson 7: multifaceted plots:
ggplot(my_data, aes(x=size,fill=type)) + geom_density() + xlim(0,500) + facet_grid(type ~ .)


# Creating dot plots
ggplot(my_data, aes(x=size,fill=type)) + geom_dotplot()
    # a dot plot makes more sense with fewer observations where each individual item matters, 
    # so let's grab the largest events only
large_data <- my_data[my_data$size>5000,  ] # [rows,columns]
ggplot(large_data, aes(x=size,fill=type)) + geom_dotplot(method="histodot")
# careful, they don't stack automatically, so some of the dots are behind others
ggplot(large_data, aes(x=size,fill=type)) + geom_dotplot(method="histodot",stackgroups=TRUE)




# Time-course data for line plot
filename <- "Lesson-06/time_course_data.txt"
time_course <- read.csv(filename, sep=",", quote='', stringsAsFactors=TRUE,header=TRUE)
time_course

# line plot:
ggplot(time_course, aes(x=seconds,y=value,colour=sample)) + geom_line()
ggplot(time_course, aes(x=seconds,y=value,colour=sample)) + geom_line(size=3)



# For fun:
# Any plot can be made in polar coordinates:
    # line plot
ggplot(time_course, aes(x=seconds,y=value,colour=sample)) + geom_line(size=3) + coord_polar()

    # violin plot
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_violin(adjust=0.5) + ylim(0,1000) + coord_polar()
    # bar plot
ggplot(my_data, aes(x=size,fill=type)) + geom_bar(binwidth=5) + xlim(0,500) + coord_polar()


# Pie charts
type_counts = summary(my_data$type)
type_counts

pie(type_counts)
pie(type_counts,col=brewer.pal(length(type_counts),"Set1"))


# Gene lists for Venn Diagram
listA <- read.csv("Lesson-06/genes_list_A.txt",header=FALSE)
A <- listA$V1
A

listB <- read.csv("Lesson-06/genes_list_B.txt",header=FALSE)
B <- listB$V1
B

listC <- read.csv("Lesson-06/genes_list_C.txt",header=FALSE)
C <- listC$V1
C

listD <- read.csv("Lesson-06/genes_list_D.txt",header=FALSE)
D <- listD$V1
D

length(A)
length(B)
length(C)
length(D)

# install package VennDiagram
library(VennDiagram)

# This function only works by saving directly to a file

venn.diagram(list("list C"=C, "list D"=D), fill = c("yellow","cyan"), cex = 1.5, filename="Lesson-06/Venn_diagram_genes_2.png")

venn.diagram(list(A = A, C = C, D = D), fill = c("yellow","red","cyan"), cex = 1.5,filename="Lesson-06/Venn_diagram_genes_3.png")

venn.diagram(list(A = A, B = B, C = C, D = D), fill = c("yellow","red","cyan","forestgreen"), cex = 1.5,filename="Lesson-06/Venn_diagram_genes_4.png")

