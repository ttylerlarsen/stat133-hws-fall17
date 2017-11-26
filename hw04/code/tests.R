###################################
# title: "HW04 Tests"
# subtitle: "Stat 133, Fall 2017"
# author: "Tyler Larsen"
###################################

library(testthat)

x <- c(1, 3, 4, 2, 7, 6, NA, 3, NA)
y <- c(1, 3, 4, 2, 7, 6, 3)

context("tests remove_missing")
test_that("remove_missing deletes NAs", {
  
  expect_that(length(remove_missing(x)), equals(7))
  expect_that(length(remove_missing(y)), equals(length(y)))
  expect_that(remove_missing(x), equals(y))
  expect_that(remove_missing(y), equals(y))
})

context("tests get_minimum")
test_that("get_minimum returns the minimum value",{
  expect_that(get_minimum(x), is_equivalent_to(get_minimum(y)))
  expect_that(length(get_minimum(x)), equals(1))
  expect_that(get_minimum(x, na.rm = TRUE), is_equivalent_to(get_minimum(y)))
  expect_that(get_minimum(x), equals(min(y)))
})

context("tests get_maximum")
test_that("get_maximum returns the maximum value",{
  expect_that(get_maximum(x), is_equivalent_to(get_maximum(y)))
  expect_that(length(get_maximum(x)), equals(1))
  expect_that(get_maximum(x, na.rm = TRUE), is_equivalent_to(get_maximum(y)))
  expect_that(get_maximum(x), is_equivalent_to(max(y)))
})

context("tests get_range")
test_that("get_range returns the range of values",{
  expect_that(get_range(x), is_equivalent_to(get_range(y)))
  expect_that(length(get_range(x)), equals(1))
  expect_that(get_range(x, na.rm = TRUE), is_equivalent_to(get_range(y)))
  expect_that(get_range(x), is_equivalent_to(max(y)-min(y)))
})

context("tests get_median")
test_that("get_median returns the median value",{
  expect_that(get_median(x), is_equivalent_to(get_median(y)))
  expect_that(length(get_median(x)), equals(1))
  expect_that(get_median(x, na.rm = TRUE), is_equivalent_to(get_median(y)))
  expect_that(get_median(x), is_equivalent_to(median(y)))
})

context("tests get_average")
test_that("get_average returns the average value",{
  expect_that(get_average(x), is_equivalent_to(get_average(y)))
  expect_that(length(get_average(x)), equals(1))
  expect_that(get_average(x, na.rm = TRUE), is_equivalent_to(get_average(y)))
  expect_that(get_average(x), is_equivalent_to(mean(y)))
})

context("tests get_stv")
test_that("get_stdev returns the standard  deviation",{
  expect_that(get_stv(x), is_equivalent_to(get_stv(y)))
  expect_that(length(get_stv(x)), equals(1))
  expect_that(get_stv(x, na.rm = TRUE), is_equivalent_to(get_stv(y)))
  expect_that(get_stv(x), is_equivalent_to(sd(y)))
})

context("tests get_quartile1")
test_that("get_quartile1 retuns the value at the 1st quartile",{
  expect_that(get_quartile1(x), is_equivalent_to(get_quartile1(y)))
  expect_that(length(get_quartile1(x)), equals(1))
  expect_that(get_quartile1(x, na.rm = TRUE), is_equivalent_to(get_quartile1(y)))
  expect_that(get_quartile1(x), is_equivalent_to(get_quartile1(y)))
})

context("tests get_quartile3")
test_that("get_quartile1 retuns the value at the 3rd quartile",{
  expect_that(get_quartile3(x), is_equivalent_to(get_quartile3(y)))
  expect_that(length(get_quartile3(x)), equals(1))
  expect_that(get_quartile3(x, na.rm = TRUE), is_equivalent_to(get_quartile3(y)))
  expect_that(get_quartile3(x), is_equivalent_to(get_quartile3(y)))
})

context("tests count_missing")
test_that("count_missing returns the number of missing values",{
  expect_that(count_missing(x), equals(2))
  expect_that(count_missing(y), equals(0))
  expect_that(length(count_missing(x)), equals(1))
  expect_that(count_missing(y), equals(0))
})

context("tests summary_stats")
test_that("summary_stats returns summary stats for the input vector",{
  expect_that(summary_stats(x)[1], is_equivalent_to(min(y)))
  expect_that(summary_stats(x)[4], is_equivalent_to(median(y)))
  expect_that(summary_stats(x)[8], is_equivalent_to(max(y)))
  expect_that(summary_stats(x)[9], is_equivalent_to(max(y)-min(y)))
})

context("tests rescale_100")
test_that("rescale100 rescales a vector between 1-100",{
  expect_that(length(rescale100(x, 0, 20)), equals(length(x)))
  expect_that(length(rescale100(x, 0, 20)), equals(length(rescale100(x, 0, 20))))
  expect_that(rescale100(x, 0, 20), is_equivalent_to(rescale100(x, 0, 20)))
  #expect_that(rescale100(y, 0, 20), is_a(numeric))
})

context("tests drop_lowest")
test_that("drop_lowest removes the smallest element from a vector",{
  expect_that(drop_lowest(x), equals(drop_lowest(y)))
  expect_that(drop_lowest(x)[1], equals(drop_lowest(y)[1]))
  expect_that(drop_lowest(x), is_equivalent_to(drop_lowest(y)))
  expect_that(length(drop_lowest(x)), equals(length(x)-count_missing(x)-1))
})

context("tests score_homework")
test_that("score_homeworks outputs a homework score",{
  expect_that(score_homework(x), is_equivalent_to(mean(y)))
  expect_that(length(score_homework(x)), equals(1))
  #expect_that(score_homework(x, drop = TRUE) >= score_homework(x, drop = FALSE), is_true())
  expect_that(score_homework(x), is_equivalent_to(score_homework(y)))
})

context("tests score_quiz")
test_that("score_quiz outputs a quiz score",{
  expect_that(score_quiz(x), is_equivalent_to(mean(y)))
  expect_that(length(score_quiz(x)), equals(1))
  #expect_that((score_quiz(x, drop = TRUE) >= score_quiz(x, drop = FALSE)), is_true())
  expect_that(score_quiz(x), is_equivalent_to(score_quiz(y)))
})

context("tests score_lab")
test_that("score_lab outputs a lab score",{
  expect_that(score_lab(12), equals(100))
  expect_that(score_lab(10), equals(80))
  expect_that(score_lab(8), equals(40))
  expect_that(score_lab(6), equals(0))
})


