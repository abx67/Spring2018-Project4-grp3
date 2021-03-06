ms_train <- read.csv("../data/data_sample/MS_sample/data_train.csv")
ind.c <- which(ms_train$V1 == "C")
test <- unique(ms_train[ind.c, 3])
ind.c <- c(ind.c, nrow(ms_train)+1)
num <- diff(ind.c)
ms_train$C <- rep(test, times = num)
ms_train1 <- ms_train[which(ms_train$V1 == "V"), -1]

test2 <- dcast(ms_train1[,-1], C~V2)
rownames(test2) <- test2$C
test3 <- ifelse(is.na(test2[,-1]) == T, 0, 1)
ms_train <- test3

save(ms_train, file = "../output/ms_train.RData")
# save(ms_train, file = "data/data_sample/MS_sample/data_train1.RData")
# write.csv(test3, file = "data/data_sample/MS_sample/data_train1.csv")

ms_test <- read.csv("../data/data_sample/MS_sample/data_test.csv")
ind.c <- which(ms_test$V1 == "C")
test <- unique(ms_test[ind.c, 3])
ind.c <- c(ind.c, nrow(ms_test)+1)
num <- diff(ind.c)
ms_test$C <- rep(test, times = num)
ms_test1 <- ms_test[which(ms_test$V1 == "V"), -1]

test2 <- dcast(ms_test1[,-1], C~V2)
rownames(test2) <- test2$C
test3 <- ifelse(is.na(test2[,-1]) == T, 0, 1)
ms_test <- test3
save(ms_test, file = "../output/ms_test.RData")

#save(ms_test, file = "data/data_sample/MS_sample/data_test1.RData")

# Movie preprocess
# Movie_mat <- dcast(movie_train,User~Movie)
# rownames(Movie_mat) <- Movie_mat$User
# Movie_mat[is.na(Movie_mat)]=0
# Movie_train <- Movie_mat
# 
# Movie_mat <- dcast(movie_test,User~Movie)
# rownames(Movie_mat) <- Movie_mat$User
# Movie_mat[is.na(Movie_mat
