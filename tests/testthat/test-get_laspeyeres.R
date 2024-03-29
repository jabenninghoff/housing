# WARNING - Generated by {fusen} from dev/save_data.Rmd: do not edit by hand


test_that("Wrong data", {

  expect_error(
    get_laspeyeres(mtcars)
  )

})

test_that("Empty data", {

  expect_error(
  # this subsetting results in an empty dataset
    get_laspeyeres(subset(mtcars, am == 2))
  )

})

test_that("get_laspeyeres() produces correct results", {

  input_df <- expand.grid(
    list("year" = c(2010, 2011),
         "locality" = c("Bascharage", "Luxembourg"))
  )

  input_df$n_offers <- c(123, 101, 1230, 1010)
  input_df$average_price_nominal_euros <- c(234, 345, 560, 670)
  input_df$average_price_m2_nominal_euros <- c(23, 34, 56, 67)

  expected_df <- input_df

  # p0 should be always equal to the value in the first year
  expected_df$p0 <- c(234, 234, 560, 560)
  expected_df$p0_m2 <- c(23, 23, 56, 56)

  # pl should be equal to the price divided by p0
  expected_df$pl <- expected_df$average_price_nominal_euros / expected_df$p0 * 100
  expected_df$pl_m2 <- expected_df$average_price_m2_nominal_euros / expected_df$p0_m2 * 100

  expect_equivalent(
    expected_df, get_laspeyeres(input_df)
  )

})
