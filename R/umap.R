library(cuda.ml)
library(ggplot2)
library(magrittr)

# load mnist
source("data-raw/load-mnist.R")

# flatten each image to a 1d array, combine into a matrix with 1 row per image
flatten <- function(img) {dim(img) <- NULL; img}
flattened_mnist_images <- mnist_images %>%
  asplit(3) %>%
  lapply(flatten) %>%
  do.call(rbind, .)
dim(flattened_mnist_images)

# embed
embedding <- cuda_ml_umap(
  flattened_mnist_images,
  n_components = 2,
  n_neighbors = 50,
  local_connectivity = 15,
  repulsion_strength = 10
)
dim(embedding$transformed_data)

# visualize
embedding$transformed_data %>%
  as.data.frame() %>%
  dplyr::mutate(Label = factor(mnist_labels)) %>%
  ggplot(aes(x = V1, y = V2, color = Label)) +
  geom_point(alpha = .5, size = .5) +
  labs(title = "UMAP: Uniform Manifold Approximation and Projection",
       subtitle = "Two Dimensional Embedding of MNIST")
