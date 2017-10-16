# ==================================================================
# Title: HW03
# Description: https://github.com/ucb-stat133/stat133-fall-2017/blob/master/labs/lab06-more-dplyr-ggplot.md
# Input(s): what are the main inputs (list of inputs)
# Output(s): what are the main outputs (list of outputs)
# Author: Tyler Larsen
# Date: 10-15-2017
# ==================================================================
library("dplyr")
library("ggplot2")

setwd('/users/tylerlarsen/desktop/stat133/stat133-hws-fall17/hw03/data')

roster <- read.csv("nba2017-roster.csv")
stats <- read.csv("nba2017-stats.csv")

stats$missed_fg <- stats$field_goals_atts - stats$field_goals_made
stats$missed_ft < stats$points1_atts - stats$points1_made
stats$points <- stats$points1_made + 2*stats$points2_made + 3*stats$points3_made
stats$rebounds <- stats$def_rebounds + stats$off_rebounds
stats$EFF <-  stats$points + stats$rebounds + stats$assists + stats$steals + stats$blocks
               - stats$missed_fg - stats$missed_ft - stats$turnovers
stats$EFF <- stats$EFF / stats$games_played

setwd('/users/tylerlarsen/desktop/stat133/stat133-hws-fall17/hw03/output/')

sink(file = 'efficiency-summary.txt')
str(dat)
sink()

roster_stats <-merge(roster, stats, by = "player")

teams <- roster_stats %>%
  group_by(team) %>%
  summarise(experience = round(sum(experience),2),
            salary = round(sum(salary)/1000000, 2),
            points3 = sum(points3_made),
            points2 = sum(points2_made),
            free_throws = sum(points1_made),
            points = sum(points),
            off_rebounds = sum(off_rebounds),
            def_rebounds = sum(def_rebounds),
            assists = sum(assists),
            steals = sum(steals),
            blocks = sum(blocks),
            turnovers = sum(turnovers),
            fouls = sum(fouls),
            eff = sum(EFF))

setwd('/users/tylerlarsen/desktop/stat133/stat133-hws-fall17/hw03/data/')
sink(file = 'team-summary.txt')
str(teams)
sink()

write.csv(teams, "nba2017-teams.csv")

setwd('/users/tylerlarsen/desktop/stat133/stat133-hws-fall17/hw03/images/')
pdf(filename = "starplot.pdf")
stars(teams[ ,-1], labels = teams$team)
dev.off()

gg_pts_salary <- plot(x = teams$experience, y = teams$salary,
                      xlab = 'Experience', ylab = 'Salary')

ggsave(filename = "experience_salary.pdf", plot = gg_pts_salary,
       width = 7, height = 5)
