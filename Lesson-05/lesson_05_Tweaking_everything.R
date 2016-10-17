# ==========================================================
#
#      Lesson 5 -- Tweaking everything in your plots
#      •   Text, axis labels
#      •   Legends
#      •   Color palettes
#      •   Sizes, fonts, line-widths, tick-marks, 
#          grid-lines, and background-colors
#
# ==========================================================


# Loading, filtering, etc. from Lessons 1-4:
#            (shortened version)

library(ggplot2)

filename <- "Lesson-05/Encode_HMM_data.txt"
my_data <- read.csv(filename, sep="\t", header=FALSE)
names(my_data)[1:4] <- c("chrom","start","stop","type")

# Reorder chromosomes and cut their names down
my_data$chrom <- factor(gsub("chr", "", my_data$chrom, fixed=TRUE), levels=c(seq(1,22),"X","Y"))

# Filter to just a few types I'm interested in
my_data <- my_data[my_data$type %in% c("1_Active_Promoter","4_Strong_Enhancer","8_Insulator"),]

# Rename the types
library(plyr) # this library has a useful revalue() function
my_data$type <- revalue(my_data$type, c("1_Active_Promoter"="Promoter", "4_Strong_Enhancer"="Enhancer","8_Insulator"="Insulator"))

# Check the plot again
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

# ==========================================================

# The basics
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

# Add a plot title
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar() + labs(title="Regulatory features by chromosome")

# Change axis and legend labels
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar() + labs(x = "Chromosome",y="Count",fill="Feature")


# Save the plot to easily try new things:
basic <- ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar() + labs(x = "Chromosome",y="Count",fill="Feature")
# Now when we run "basic" it makes the plot
basic

# Add theme with modifications to the basic plot, for instance with bigger text
basic + theme_gray(base_size = 20)
# But it only affects that plot, so the next plot we make is back to normal
basic

# You can also set a theme that will affect all the plots you make from now on
theme_set(theme_gray(base_size = 20))
basic

# To recover the default theme:
theme_set(theme_gray())
basic

# I prefer larger text myself
theme_set(theme_gray(base_size = 16))
basic

#==============================================================================
# Color palettes:

library(RColorBrewer)
display.brewer.all()

basic + scale_fill_brewer(palette="Set1")
basic + scale_fill_brewer(palette="Pastel1")
basic + scale_fill_brewer(palette="YlOrRd")

basic + scale_fill_manual(values = c("green","blue","red"))

colors()

# What happens if we need a lot of colors?
chrom_plot <- ggplot(my_data,aes(x=type,fill=chrom)) + geom_bar()
chrom_plot

# rainbow is confusing, but color palettes are too short:
chrom_plot + scale_fill_brewer(type="qual",palette=1)


# to get the colors from a palette:
palette1 <- brewer.pal(9,"Set1")
palette1

palette2 <- brewer.pal(8,"Set2")
palette2

palette3 <- brewer.pal(9,"Set3")
palette3

# We can use a quick pie chart to see the colors:
pie(rep(1,length(palette1)),col=palette1)
pie(rep(1,length(palette2)),col=palette2)
pie(rep(1,length(palette3)),col=palette3)

# We can just stick a few color palettes together
big_palette <- c(palette1,palette2,palette3)
big_palette

# Pie chart of all the colors together:
pie(rep(1,length(big_palette)),col=big_palette)


chrom_plot + scale_fill_manual(values = big_palette)

# To shuffle the colors:
chrom_plot + scale_fill_manual(values = sample(big_palette))


# if you want to keep the colors the same every time you plot, 
# use set.seed()
set.seed(5)
# use different numbers until you find your favorite colors
chrom_plot + scale_fill_manual(values = sample(big_palette))

# This is possible, because:
# Fun fact: "Random" numbers from a computer aren't really random


# Color-blind safe palettes:
display.brewer.all(colorblindFriendly=TRUE)
# Mixing them might remove the color-friendly-ness so be careful
# Finding a set of 23 colors that a color-blind person can distinguish is a challenge

basic + scale_fill_brewer(palette="Set2")


# Done with colors
#======================================================================

# Default:
theme_set(theme_gray())


# Basic, normal plot:
basic

# Two basic themes:
basic + theme_gray() # the default
basic + theme_bw() # black and white

# Fonts and font sizes for everything at once
basic + theme_gray(base_size = 24, base_family = "Times New Roman")


# Font size for labels, tick labels, and legend separately ##############################
basic + theme(axis.text=element_text(size=20)) # numbers on axes
basic + theme(axis.title=element_text(size=20)) # titles on axes
basic + theme(legend.title=element_text(size=20)) # legend title
basic + theme(legend.text=element_text(size=20,family="Times New Roman"))
    # legend category labels

basic + theme(
    legend.text=element_text(size=20,family="Times New Roman"),
    axis.title=element_text(size=30),
    axis.text=element_text(size=20)
    ) # Mix and match


# Change background color
basic + theme(panel.background = element_rect(fill="pink"))
basic + theme(panel.background = element_rect(fill="white"))

# Change grid-lines
basic + theme(panel.grid.major = element_line(colour = "blue"), panel.grid.minor = element_line(colour = "red"))

    # Remove all gridlines:
basic + theme(panel.grid.major = element_line(NA), 
              panel.grid.minor = element_line(NA))

    # Thin black major gridlines on y-axis, the others are removed
basic + theme(panel.grid.major.y = element_line(colour = "black",size=0.2), 
              panel.grid.major.x = element_line(NA),
              panel.grid.minor = element_line(NA))



# Change tick-marks
basic # normal ticks
basic + theme(axis.ticks = element_line(size=2))
basic + theme(axis.ticks = element_line(NA))
basic + theme(axis.ticks = element_line(color="blue",size=2))
basic + theme(axis.ticks = element_line(size=2), # affects both x and y
              axis.ticks.x = element_line(color="blue"), # x only
              axis.ticks.y = element_line(color="red"))  # y only

# Place legend in different locations
basic + theme(legend.position="top")
basic + theme(legend.position="bottom")
basic + theme(legend.position=c(0,0)) # bottom left
basic + theme(legend.position=c(1,1)) # top right
basic + theme(legend.position=c(0.8,0.8)) # near the top right

# Remove legend title
basic + labs(fill="")
basic + labs(fill="") + theme(legend.position=c(0.8,0.8))

# Remove legend completely
basic + guides(fill=FALSE)


# clear background, axis lines but no box, no grid lines, basic colors, no legend
publication_style <- basic + guides(fill=FALSE) +  theme(axis.line = element_line(size=0.5),panel.background = element_rect(fill=NA,size=rel(20)), panel.grid.minor = element_line(colour = NA), axis.text = element_text(size=16), axis.title = element_text(size=18)) 

publication_style

publication_style + scale_y_continuous(expand=c(0,0)) # to stop the bars from floating above the x-axis


# You can set the theme with all these changes and have it apply to all the future plots
theme_set(theme_gray()+theme(axis.line = element_line(size=0.5),panel.background = element_rect(fill=NA,size=rel(20)), panel.grid.minor = element_line(colour = NA), axis.text = element_text(size=16), axis.title = element_text(size=18)))

basic

# These tweaks aren't part of the theme, so you will still have to add them separately to each plot
basic + scale_y_continuous(expand=c(0,0)) + guides(fill=FALSE)


# and you can always reset to defaults with:
theme_set(theme_gray())
basic

