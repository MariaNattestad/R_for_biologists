# ==========================================================
#
#      Lesson 1 -- Hit the ground running
#      •   Reading in data
#      •   Creating a quick plot
#      •   Saving publication-quality plots in multiple 
#          file formats (.png, .jpg, .pdf, and .tiff)
#
# ==========================================================


# Go to the packages tab in the bottom right part of Rstudio, click "Install" at the top, type in ggplot2, and hit Install
# Go to the Files tab in the bottom right part of Rstudio, navigate to where you can see the Lesson-01 folder. 
# then click "More" and choose "Set As Working Directory"

library(ggplot2)

filename <- "Lesson-01/Encode_HMM_data.txt"

# Select a file and read the data into a data-frame
my_data <- read.csv(filename, sep="\t", header=FALSE)
# if this gives an error, make sure you have followed the steps above to set your working directory to the folder that contains the file you are trying to open

head(my_data)

# Rename the columns so we can plot things more easily without looking up which column is which
names(my_data)[1:4] <- c("chrom","start","stop","type")

# At any time, you can see what your data looks like using the head() function:
head(my_data)

# Now we can make an initial plot and see how it looks
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()


# Save the plot to a file

# Different file formats:
png("Lesson-01/plot.png")
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()
dev.off()

tiff("Lesson-01/plot.tiff")
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()
dev.off()

jpeg("Lesson-01/plot.jpg")
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()
dev.off()

pdf("Lesson-01/plot.pdf")
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()
dev.off()

# High-resolution:
png("Lesson-01/plot_hi_res.png",1000,1000)
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()
dev.off()




