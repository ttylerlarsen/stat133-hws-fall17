###################################
# title: "HW04 Tester Script"
# subtitle: "Stat 133, Fall 2017"
# author: "Tyler Larsen"
###################################

library(testthat)

# source in functions to be tested
source('functions.R')

sink('../output/test-reporter.txt')
test_file('tests.R')
sink()

