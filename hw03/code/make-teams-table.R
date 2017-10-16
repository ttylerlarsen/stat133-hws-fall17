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

---
  title: "hw03"
output: github_document
---
  
 
library(readr)
library(ggplot2)
library(dplyr)


#NBA Teams ranked by Total Salary

ggplot(data = teams, aes(x = reorder(team, salary), y = salary)) + 
  geom_bar(stat = 'identity') +
  labs(x = "Team", y = "Salary (in millions)")  +
  geom_hline(yintercept = mean(teams$salary), color = "red", size = 1) +
  coord_flip()



#NBA Teams ranked by Total Points

ggplot(data = teams, aes(x = reorder(team, points), y = points)) + 
  geom_bar(stat = 'identity') +
  labs(x = "Team", y = "Points")  +
  geom_hline(yintercept = mean(teams$points), color = "red", size = 1) +
  coord_flip()


#NBA Teams ranked by Total Efficiency

ggplot(data = teams, aes(x = reorder(team, eff), y = eff)) + 
  geom_bar(stat = 'identity') +
  labs(x = "Team", y = "Efficiency")  +
  geom_hline(yintercept = mean(teams$eff), color = "red", size = 1) +
  coord_flip()
```

#PCA


pca_categories <- data.frame(teams$points3, teams$points2, teams$free_throws, teams$off_rebounds, teams$def_rebounds, teams$assists, teams$steals, teams$blocks, teams$turnovers, teams$fouls)

pca <- prcomp(pca_categories, scale. = TRUE)

pca2 <- as.data.frame(pca$x)
pca2
plot(pca2$PC1,pca2$PC2, main="Scatterplot Example", 
     xlab="PCA1 ", ylab="PCA2 ", pch=19)

pca3 <- (pca2$PC1-min(pca2$PC1)) / (max(pca2$PC1) - min(pca2$PC1))
teams_pc <- data.frame(teams$team, pca3)

ggplot(data = teams_pc, aes(x = reorder(teams.team, pca3), y = pca3)) + 
  geom_bar(stat = 'identity') +
  labs(x = "Team", y = "PCA1")  +
  geom_hline(yintercept = mean(teams_pc$pca3), color = "red", size = 1) +
  coord_flip()


