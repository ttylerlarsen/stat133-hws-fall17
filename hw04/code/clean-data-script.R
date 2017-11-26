###################################
# title: "HW04 Clean Data Script"
# subtitle: "Stat 133, Fall 2017"
# author: "Tyler Larsen"
###################################

source('functions.R')
dat <- read.csv('../data/rawdata/rawscores.csv', stringsAsFactors = FALSE)

sink('../output/summary-rawscores.txt')
str(dat)
sink()

#replace the NA elements with 0
for (i in 1:nrow(dat))
  for (j in 1:ncol(dat))
    if (is.na(dat[i,j]))
      dat[i,j] <- 0

#rescaling the quizes & tests to scores out of 100
dat$QZ1 <- rescale100(dat$QZ1, 0, 12)
dat$QZ2 <- rescale100(dat$QZ2, 0, 18)
dat$QZ3 <- rescale100(dat$QZ3, 0, 20)
dat$QZ4 <- rescale100(dat$QZ4, 0, 20)
dat$Test1 <- rescale100(dat$EX1, 0, 80)
dat$Test2 <- rescale100(dat$EX2, 0, 90)
dat$Lab <- unlist(lapply(dat$ATT, score_lab))

#creating dataframes of hw and quizes, in order to calculate totals after drop
hws <- data.frame(hw1 = dat$HW1, 
                  hw2 = dat$HW2, 
                  hw3 = dat$HW3, 
                  hw4 = dat$HW4, 
                  hw5 = dat$HW5,
                  hw6 = dat$HW6, 
                  hw7 = dat$HW7, 
                  hw8 = dat$HW8, 
                  hw9 = dat$HW9)

qzs <- data.frame(q1 = dat$QZ1,
                  q2 = dat$QZ2,
                  q3 = dat$QZ3,
                  q4 = dat$QZ4)
  
#adding columns to dat with the final scores in both the hw and quiz categories
dat$Homework <- hwq_aggregator(hws)
dat$Quiz <- hwq_aggregator(qzs)

#create column with overall grade as a percent
dat$Overall <- unlist(.10 * dat$Lab +
                  .30 * dat$Homework +
                  .15 * dat$Quiz +
                  .20 * dat$Test1 +
                  .25 * dat$Test2)
 
#create column with overall grade as a letter                 
dat$Grade <- unlist(lapply(dat$Overall, get_grade))           

names <- c("../output/Test1-stats.txt", "../output/Test2-stats.txt", "../output/Lab-stats.txt",
           "../output/homework-stats.txt", "../output/Quiz-stats.txt", "../output/Overall-stats.txt")

#save the summary statistics for the 6 columns selected to txt files
for(i in 17:22)
{
  sink(names[i-16])
  print_stats((summary_stats(dat[,i])))
  sink()
}
  
#export the clean data to a csv file
write.csv(dat, "../data/cleandata/summary-cleanscores.csv")

sink('../output/summary-cleanscores.txt')
str(dat)
sink()

freq_table <- data.frame(c('A+', 'A', 'A-','B+','B', 
                           'B-','C+', 'C', 'C-', 'D', 'F'),
                         c(16,54,31,30,52,29,23,38,27,19,15),
                         c(0.05,0.16,0.09,0.09,0.16,0.09,
                           0.07,0.11,0.08,0.06,0.04))

colnames(freq_table) <- c("Grade", "Freq", "Prop")