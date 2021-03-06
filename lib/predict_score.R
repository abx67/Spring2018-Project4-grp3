#############################################
############# Predict score #################
#############################################

# predict score for ms data
predict.score.ms <- function(train,
                             test,
                             weight,
                             par = list(threshold = 0.3,n = 60),
                             run.threshold = FALSE,
                             run.bestn = FALSE){
  threshold = par$threshhold
  n = par$n
  rownames(weight) <- rownames(train)
  train_c <- train - rowMeans(train, na.rm = T)
                
  item <- colnames(test)
  ind2 <- match(item, colnames(train))
                            
  mat <- matrix(0, ncol = ncol(test), nrow = nrow(test))
  for (a in 1:nrow(test)){
    nei <- select_neighbor(userid = rownames(test)[a],
                           weight_mat = weight, 
                           para = list(threshold = threshold,n = n),
                           run.bestn = run.bestn,
                           run.threshold = run.threshold)
    if (sum(is.na(nei)) != 0 || length(nei) == 0) {
      mat[a, ] <- rep(0,ncol(test))
      next
      }
    ind <- match(nei, rownames(weight))
    w <- weight[a, ind]
    k <- sum(w)
    v <- train_c[ind, ind2]
    mat[a, ] <- (1/k)*(w %*% v)
    }
  mat_final <- (rowMeans(train, na.rm =T)[1:665]) %*% t(rep(1, ncol(test))) + mat
  return(mat_final)
}


##########################################################################################

# predict score for movie data
predict.score.movie <- function(train, test, weight,
                                par = list(threshold = 0.3,n = 60),
                                run.threshold = FALSE,
                                run.bestn = FALSE){
  threshold = par$threshold
  n = par$n
  rownames(weight) <- rownames(train)
  avg <- rowMeans(train, na.rm = T)
  train_c <- train - avg
  train_c[is.na(train_c)] <- 0
  
  item <- colnames(test)
  ind2 <- match(item, colnames(train))
  
  mat <- matrix(0, ncol = ncol(test), nrow = nrow(test))
  for (a in 1:nrow(test)){
    nei <- select_neighbor(userid = rownames(test)[a], weight_mat = weight, 
                           para = list(threshold = threshold,n = n),
                           run.bestn = run.bestn, run.threshold = run.threshold)
    if (sum(is.na(nei)) != 0 || length(nei) == 0) {
      mat[a, ] <- rep(0,ncol(test))
      next
    }
    ind <- match(nei, rownames(weight))
    w <- weight[a, ind]
    k <- sum(w)
    v <- data.matrix(train_c[ind, ind2])
    mat[a, ] <- (1/k)*(w %*% v)
  }
  mat_final <- (avg[1:nrow(test)]) %*% t(rep(1, ncol(test))) + mat
  return(mat_final)
}

