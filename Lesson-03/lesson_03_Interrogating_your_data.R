# ==========================================================
#
#      Lesson 3 -- Interrogating your data
#      •   Counting categorical variables
#      •   Mean, median, standard deviation
#      •   Finding issues
#
# ==========================================================

#############     We start this the same as in lesson 1     ###############

library(ggplot2)

filename <- "Lesson-03/Encode_HMM_data.txt"

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


#############     Now let's take a closer look at our data     ###############

# We can see how big our data is:
dim(my_data)

# We can ask our data some questions:
summary(my_data)

# We can break these down by column to see more:
summary(my_data$chrom)

summary(my_data$type)

summary(my_data$start)
summary(my_data$stop)


# We can even make a new column by doing math on the other columns
my_data$size = my_data$stop - my_data$start

# So now there's a new column
head(my_data)

# Basic statistics:
summary(my_data$size)

mean(my_data$size)
sd(my_data$size)

median(my_data$size)
max(my_data$size)
min(my_data$size)


# Let's think about the issues and in the next lesson we will learn how to deal with them
ggplot(my_data,aes(x=chrom,fill=type)) + geom_bar()

# 1)    Chromosomes in the wrong order, and the "chr" prefixes don't fit on the x-axis
# 2)    Too many types
# 3)    Bad names for the types

