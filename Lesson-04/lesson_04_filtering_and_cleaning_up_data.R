
#############     We start this the same as in lesson 1     ###############

library(ggplot2)

filename <- "Lesson-04/Encode_HMM_data.txt"

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


#############     In Lesson 3 we decided on some issues to fix     #############

# 1)    Chromosomes in the wrong order
# 2)    Too many types
# 3)    Bad names for the types

summary(my_data$chrom)
summary(my_data$type)

#############     Now let's address those issues     ###############


# remove the "chr" prefix

my_data$chrom <- gsub("chr", "", my_data$chrom, fixed=TRUE)

ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

# reorder the chromosomes numerically

my_data$chrom <- factor(gsub("chr", "", my_data$chrom, fixed=TRUE), levels=c(seq(1,22),"X","Y"))

summary(my_data$chrom)

ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

# Much better!

# Now let's do something about those types.

summary(my_data$type)

# Filter to just a few types I'm interested in
my_data <- my_data[my_data$type %in% c("1_Active_Promoter","4_Strong_Enhancer","8_Insulator"),]

# Rename the types

library(plyr) # this library has a useful revalue() function
my_data$type <- revalue(my_data$type, c("1_Active_Promoter"="Promoter", "4_Strong_Enhancer"="Enhancer","8_Insulator"="Insulator"))

# Check the plot again
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

