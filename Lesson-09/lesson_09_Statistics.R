# ==========================================================
#
#                         In Progress
#
# ==========================================================



# example of a basic t-test
set1 <- my_data[my_data$type=="Insertion","size"]

set2 <- my_data[my_data$type=="Deletion","size"]

t.test(set1,set2)


