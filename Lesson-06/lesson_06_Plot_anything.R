# ==========================================================
#
#               New data set for plotting: variants
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

# Creating a density plot
ggplot(my_data, aes(x=size,fill=type)) + geom_density() + xlim(0,500)
    # similar to this histogram:
ggplot(my_data, aes(x=size,fill=type)) + geom_bar(binwidth=5) + xlim(0,500)

ggplot(my_data, aes(x=size,fill=type)) + geom_density(position="stack") + xlim(0,500)
ggplot(my_data, aes(x=size,fill=type)) + geom_density(alpha=0.5) + xlim(0,500)

# Sneak peak at Lesson 7: multifaceted plots:
ggplot(my_data, aes(x=size,fill=type)) + geom_density(alpha=0.5) + xlim(0,500) + facet_grid(type ~ .)


# Creating dot plots
ggplot(my_data, aes(x=size,fill=type)) + geom_dotplot()
    # makes more sense with fewer observations where each individual item matters, 
    # so let's grab the largest events and see what chromosomes they fall on
large_data <- my_data[my_data$size>5000,]
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
ggplot(time_course, aes(x=seconds,y=value,colour=sample)) + geom_line(size=3) + coord_polar()
ggplot(my_data, aes(x=type,y=size,fill=type)) + geom_violin(adjust=0.5) + ylim(0,1000) + coord_polar()
ggplot(my_data, aes(x=size,fill=type)) + geom_bar(binwidth=5) + xlim(0,500) + coord_polar()



# Pie charts

# While ggplot doesn't come with pie charts, we can hack one together:
# This function makes it happen:
pie_with_ggplot <- function(my_data,type) {
    # inspired by mathematicalcoffee.blogspot.com/2014/06/ggpie-pie-graphs-in-ggplot2.html
    
    counts <- summary(my_data[,type])
    
    ggplot(my_data, aes(x=factor(1),fill=type)) + geom_bar(width=1) + coord_polar(theta="y") + 
        # special theme for pie charts
        theme(axis.title = element_blank(), 
              axis.text.y = element_blank(), 
              axis.ticks=element_blank(), 
              panel.grid.major = element_blank(), 
              panel.grid.minor = element_blank(), 
              panel.background=element_blank(),
              axis.text.x = element_text(color="black")
              #               plot.margin = unit(rep(-2,4),"lines")
        ) + 
        # labels
        scale_y_continuous(breaks=cumsum(counts)-counts/2, labels=names(counts)) + 
        # remove legend
        guides(fill=FALSE)
}

# but it's really simple to just run that function
png(file="Lesson-06/pie.png",width=800,height=800)
pie_with_ggplot(my_data,"type")
dev.off()




# Gene lists for Venn Diagram
listA <- read.csv("Lesson-06/genes_list_A.txt",header=FALSE)
A <- listA$V1

listB <- read.csv("Lesson-06/genes_list_B.txt",header=FALSE)
B <- listB$V1

listC <- read.csv("Lesson-06/genes_list_C.txt",header=FALSE)
C <- listC$V1

listD <- read.csv("Lesson-06/genes_list_D.txt",header=FALSE)
D <- listD$V1



# install package VennDiagram
library(VennDiagram)
# This function only works by saving directly to a file
venn.diagram(list("list C"=C, "list D"=D), fill = c("yellow","cyan"), cex = 1.5, filename="Lesson-06/Venn_diagram_genes_2.png")

venn.diagram(list(A = A, C = C, D = D), fill = c("yellow","red","cyan"), cex = 1.5,filename="Lesson-06/Venn_diagram_genes_3.png")

venn.diagram(list(A = A, B = B, C = C, D = D), fill = c("yellow","red","cyan","forestgreen"), cex = 1.5,filename="Lesson-06/Venn_diagram_genes_4.png")


