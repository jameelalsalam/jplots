# library(tidyverse)
# 
# d <- tibble(
#   id =  c("a", "a", "a", "b", "b"),
#   x  =  c(0, 1, 2, 0, 2),
#   val = c(0, 1, 2, .5, 1.2)
# )
# 
# #debugonce(interpolate_data)
# 
# d_int <- d %>% interpolate_data(
#   x_var = x, y_var = val, 
#   by_vars = c("id")
# )
# 
# # plain approx seems simple enough:
# d %>%
#   complete(id, x) %>%
#   group_by(id) %>%
#   mutate(val = approx(x, val, x)$y) %>%
#   ungroup() %>%
#   all.equal(d_int)
#   
# 
# # d_int2 <- d %>% interpolate_data(
# #   x_var = x, y_var = val, 
# #   #result_var = "val2", interp_var = "x2",
# #   by_vars = c("id")
# # ) 
# 
# test_that("interpolate_data", {
#   expect_equal(nrow(d_int), 6)
#   expect_equal(d_int$val, c(0, 1, 2, .5, .85, 1.2))
# })
# 
# 
