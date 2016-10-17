# ==========================================================
#
#      Lesson 7 -- Multifaceted figures
#      •   Grids of plots by chromosome, variant type, etc. 
#      •   Make a figure as an inset in another figure 
#          automatically -- without Photoshop or Illustrator
#
# ==========================================================

library(ggplot2)
# reset theme
theme_set(theme_gray())

# Loading the data
filename <- "Lesson-07/variants_from_assembly.bed"
my_data <- read.csv(filename, sep="\t", quote='', stringsAsFactors=TRUE,header=FALSE)
names(my_data) <- c("chrom","start","stop","name","size","strand","type","ref.dist","query.dist")

head(my_data)

# Filtering and polishing data
my_data <- my_data[my_data$chrom %in% c(seq(1,22),"X","Y","MT"),]

    # ordering chromosomes
my_data$chrom <- factor(gsub("chr", "", my_data$chrom), levels=c(seq(1,22),"X","Y","MT"))

    # ordering types
my_data$type <- factor(my_data$type, levels=c("Insertion","Deletion","Expansion","Contraction"))

############# Multifacetting figures ############

ggplot(my_data, aes(x=size,fill=type)) + geom_density(alpha=0.5) + xlim(0,500) 

ggplot(my_data, aes(x=size,fill=type)) + geom_density() + xlim(0,500)  + facet_grid(type ~ .)

ggplot(my_data, aes(x=size,fill=type)) + geom_density() + xlim(0,500)  + facet_grid(. ~ type)

# plot + facet_grid(rows ~ columns)

# Facet on type and chrom
ggplot(my_data, aes(x=size,fill=type)) + geom_density() + xlim(0,500)  + facet_grid(chrom ~ type)

ggplot(my_data, aes(x=size,fill=type)) + geom_density() + xlim(0,500)  + facet_grid(type ~ chrom)

# Not always pretty, but it sure is fun
ggplot(my_data, aes(x=size,fill=type)) + geom_bar() + xlim(0,500)  + facet_grid(chrom ~ type)

ggplot(my_data, aes(x=type,y=size,color=type,fill=type)) + geom_boxplot() + facet_grid(chrom ~ .)

ggplot(my_data, aes(x=type,y=size,color=type,fill=type)) + geom_violin() + facet_grid(chrom ~ .)

ggplot(my_data, aes(x=ref.dist,y=query.dist,color=type,fill=type)) + xlim(0,500) + ylim(0,500) + geom_point() + facet_grid(chrom ~ type)


ggplot(my_data, aes(x=size,fill=type)) + geom_dotplot() + xlim(5000,10000) + facet_grid(chrom ~ type)




# Inset figures:

# Our special publication-style theme from Lesson 5 "Tweaking everything in your plots"
theme_set(theme_gray() + 
              theme(
                  axis.line = element_line(size=0.5),
                  panel.background = element_rect(fill=NA,size=rel(20)), 
                  panel.grid.minor = element_line(colour = NA), 
                  axis.text = element_text(size=16), 
                  axis.title = element_text(size=18)
                  )
          )

big_plot <-  ggplot(my_data, aes(x=size,fill=type)) + 
    geom_bar(binwidth=100) +  
    guides(fill=FALSE) + 
    scale_y_continuous(expand=c(0,0)) # Move bars down to X-axis

big_plot


small_plot <- ggplot(my_data, aes(x=size,fill=type)) + geom_bar(binwidth=5) + xlim(0,500) + theme(axis.title=element_blank()) +  scale_y_continuous(expand=c(0,0))
small_plot

# Where to put the smaller plot:
library(grid)
vp <- viewport(width = 0.8, height = 0.7, x = 0.65, y = 0.65)
                # width, height, x-position, y-position of the smaller plot

png("Lesson-07/inset_plot.png")
print(big_plot)
print(small_plot, vp = vp)
dev.off()

