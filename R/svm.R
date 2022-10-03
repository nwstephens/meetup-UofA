library(dplyr)
library(parsnip)
library(cuda.ml)
set.seed(11235)

train_inds <- iris %>%
  mutate(ind = row_number()) %>%
  group_by(Species) %>%
  slice_sample(prop = 0.7)

train_data <- iris[train_inds$ind, ]
test_data <- iris[-train_inds$ind, ]

model <- svm_rbf(mode = "classification", rbf_sigma = 10, cost = 50) %>%
  set_engine("cuda.ml") %>%
  fit(Species ~ ., data = train_data)

predict(model, test_data) %>%
  bind_cols(test_data %>% select(Species)) %>%
  yardstick::conf_mat(truth = Species, estimate = .pred_class)
