library(cuda.ml)
library(dplyr)

clustering <- cuda_ml_kmeans(iris[, 1:4], k = 3, max_iters = 100)

table(clustering$labels, iris$Species)[,c(3,1,2)]
