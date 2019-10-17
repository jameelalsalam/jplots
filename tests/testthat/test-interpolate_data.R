library(tidyverse)

d <- tibble(
  id =  c("a", "a", "a", "b", "b"),
  x  =  c(0, 1, 2, 0, 2),
  val = c(0, 1, 2, .5, 1.2)
)

d_int <- d %>% interpolate_data(
  x_var = x, y_var = val, 
  result_var = "val2", interp_var = "x2",
  by_vars = c("id")
)


test_that("interpolate_data", {
  expect_equal(nrow(d_int), 6)
  expect_equal(d_int$val2, c(0, 1, 2, .5, .85, 1.2))
})
