hw02-Tyler-Larsen
================

``` r
library(readr)
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

1. CREATE DATA DICTIONARY FILE
------------------------------

-   Refer to Github

2. IMPORT THE DATA IN R
-----------------------

``` r
dat <- read.csv('nba2017-player-statistics.csv', stringsAsFactors = FALSE)
str(dat)
```

    ## 'data.frame':    441 obs. of  24 variables:
    ##  $ Player      : chr  "Al Horford" "Amir Johnson" "Avery Bradley" "Demetrius Jackson" ...
    ##  $ Team        : chr  "BOS" "BOS" "BOS" "BOS" ...
    ##  $ Position    : chr  "C" "PF" "SG" "PG" ...
    ##  $ Experience  : chr  "9" "11" "6" "R" ...
    ##  $ Salary      : num  26540100 12000000 8269663 1450000 1410598 ...
    ##  $ Rank        : int  4 6 5 15 11 1 3 13 8 10 ...
    ##  $ Age         : int  30 29 26 22 31 27 26 21 20 29 ...
    ##  $ GP          : int  68 80 55 5 47 76 72 29 78 78 ...
    ##  $ GS          : int  68 77 55 0 0 76 72 0 20 6 ...
    ##  $ MIN         : int  2193 1608 1835 17 538 2569 2335 220 1341 1232 ...
    ##  $ FGM         : int  379 213 359 3 95 682 333 25 192 114 ...
    ##  $ FGA         : int  801 370 775 4 232 1473 720 58 423 262 ...
    ##  $ Points3     : int  86 27 108 1 39 245 157 12 46 45 ...
    ##  $ Points3_atts: int  242 66 277 1 111 646 394 35 135 130 ...
    ##  $ Points2     : int  293 186 251 2 56 437 176 13 146 69 ...
    ##  $ Points2_atts: int  559 304 498 3 121 827 326 23 288 132 ...
    ##  $ FTM         : int  108 67 68 3 33 590 176 6 85 26 ...
    ##  $ FTA         : int  135 100 93 6 41 649 217 9 124 37 ...
    ##  $ OREB        : int  95 117 65 2 17 43 48 6 45 60 ...
    ##  $ DREB        : int  369 248 269 2 68 162 367 20 175 213 ...
    ##  $ AST         : int  337 140 121 3 33 449 155 4 64 71 ...
    ##  $ STL         : int  52 52 68 0 9 70 72 10 35 26 ...
    ##  $ BLK         : int  87 62 11 0 7 13 23 2 18 17 ...
    ##  $ TO          : int  116 77 88 0 25 210 79 4 68 39 ...

``` r
dat$Player <- as.character(dat$Player)
dat$Team <- as.character(dat$Team)
dat$Experience <- as.character(dat$Experience)
dat$Position <- as.factor(dat$Position)
dat$Salary <- as.double(dat$Salary)

dat$Rank <- as.integer(dat$Rank)
dat$Age <- as.integer(dat$Age)
dat$GP <- as.integer(dat$GP)
dat$GS <- as.integer(dat$GS)
dat$MIN <- as.integer(dat$MIN)
dat$FGM <- as.integer(dat$FGM)
dat$Points3 <- as.integer(dat$Points3)
dat$Points3_atts <- as.integer(dat$Points3_atts)
dat$Points2 <- as.integer(dat$Points2)
dat$Points2_atts <- as.integer(dat$Points2_atts)
dat$PointsFTM <- as.integer(dat$FTM)
dat$FTA <- as.integer(dat$FTA)
dat$OREB <- as.integer(dat$OREB)
dat$DREB <- as.integer(dat$DREB)
dat$AST <- as.integer(dat$AST)
dat$STL <- as.integer(dat$STL)
dat$BLK <- as.integer(dat$BLK)
dat$TO <- as.integer(dat$TO)
```

``` r
dat2 <- read_csv('nba2017-player-statistics.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_integer(),
    ##   Player = col_character(),
    ##   Team = col_character(),
    ##   Position = col_character(),
    ##   Experience = col_character(),
    ##   Salary = col_double()
    ## )

    ## See spec(...) for full column specifications.

``` r
str(dat2)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    441 obs. of  24 variables:
    ##  $ Player      : chr  "Al Horford" "Amir Johnson" "Avery Bradley" "Demetrius Jackson" ...
    ##  $ Team        : chr  "BOS" "BOS" "BOS" "BOS" ...
    ##  $ Position    : chr  "C" "PF" "SG" "PG" ...
    ##  $ Experience  : chr  "9" "11" "6" "R" ...
    ##  $ Salary      : num  26540100 12000000 8269663 1450000 1410598 ...
    ##  $ Rank        : int  4 6 5 15 11 1 3 13 8 10 ...
    ##  $ Age         : int  30 29 26 22 31 27 26 21 20 29 ...
    ##  $ GP          : int  68 80 55 5 47 76 72 29 78 78 ...
    ##  $ GS          : int  68 77 55 0 0 76 72 0 20 6 ...
    ##  $ MIN         : int  2193 1608 1835 17 538 2569 2335 220 1341 1232 ...
    ##  $ FGM         : int  379 213 359 3 95 682 333 25 192 114 ...
    ##  $ FGA         : int  801 370 775 4 232 1473 720 58 423 262 ...
    ##  $ Points3     : int  86 27 108 1 39 245 157 12 46 45 ...
    ##  $ Points3_atts: int  242 66 277 1 111 646 394 35 135 130 ...
    ##  $ Points2     : int  293 186 251 2 56 437 176 13 146 69 ...
    ##  $ Points2_atts: int  559 304 498 3 121 827 326 23 288 132 ...
    ##  $ FTM         : int  108 67 68 3 33 590 176 6 85 26 ...
    ##  $ FTA         : int  135 100 93 6 41 649 217 9 124 37 ...
    ##  $ OREB        : int  95 117 65 2 17 43 48 6 45 60 ...
    ##  $ DREB        : int  369 248 269 2 68 162 367 20 175 213 ...
    ##  $ AST         : int  337 140 121 3 33 449 155 4 64 71 ...
    ##  $ STL         : int  52 52 68 0 9 70 72 10 35 26 ...
    ##  $ BLK         : int  87 62 11 0 7 13 23 2 18 17 ...
    ##  $ TO          : int  116 77 88 0 25 210 79 4 68 39 ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 24
    ##   .. ..$ Player      : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ Team        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ Position    : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ Experience  : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ Salary      : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_double" "collector"
    ##   .. ..$ Rank        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Age         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ GP          : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ GS          : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ MIN         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FGM         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FGA         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points3     : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points3_atts: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points2     : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points2_atts: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FTM         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FTA         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ OREB        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ DREB        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ AST         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ STL         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ BLK         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ TO          : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

``` r
dat2$Player <- as.character(dat2$Player)
dat2$Team <- as.character(dat2$Team)
dat2$Experience <- as.character(dat2$Experience)
dat2$Position <- as.factor(dat2$Position)
dat2$Salary <- as.double(dat2$Salary)

dat2$Rank <- as.integer(dat2$Rank)
dat2$Age <- as.integer(dat2$Age)
dat2$GP <- as.integer(dat2$GP)
dat2$GS <- as.integer(dat2$GS)
dat2$MIN <- as.integer(dat2$MIN)
dat2$FGM <- as.integer(dat2$FGM)
dat2$Points3 <- as.integer(dat2$Points3)
dat2$Points3_atts <- as.integer(dat2$Points3_atts)
dat2$Points2 <- as.integer(dat2$Points2)
dat2$Points2_atts <- as.integer(dat2$Points2_atts)
dat2$PointsFTM <- as.integer(dat2$FTM)
dat2$FTA <- as.integer(dat2$FTA)
dat2$OREB <- as.integer(dat2$OREB)
dat2$DREB <- as.integer(dat2$DREB)
dat2$AST <- as.integer(dat2$AST)
dat2$STL <- as.integer(dat2$STL)
dat2$BLK <- as.integer(dat2$BLK)
dat2$TO <- as.integer(dat2$TO)
```

3. RIGHT AFTER IMPORTING THE DATA
---------------------------------

``` r
#subset(dat, Experience == 'R') <- 
```

4. PERFORMANCE OF PLAYERS
-------------------------

``` r
#additional variables needed to compute EFF
dat$missed_FG <- dat$FGA - dat$FGM
dat$missed_FT <- dat$FTA - dat$FTM
dat$PTS <- 2*dat$Points2 + 3*dat$Points3 + dat$FTM
dat$REB <- dat$DREB + dat$OREB
dat$MPG <- dat$MIN / dat$GP

#EFF
dat$EFF <- (dat$PTS + dat$REB + dat$AST + dat$STL + dat$BLK - dat$missed_FG - dat$missed_FT - dat$TO) / dat$GP
summary(dat$EFF)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  -0.600   5.452   9.090  10.137  13.247  33.840

``` r
top_EEF <- data.frame("Player" = dat$Player, "Team" = dat$Team, "Salary" = dat$Salary, "EFF" = dat$EFF)
top_EEF <- top_EEF[order(top_EEF$EFF, decreasing = TRUE), ]
head(top_EEF, 10)
```

    ##                    Player Team   Salary      EFF
    ## 305     Russell Westbrook  OKC 26540100 33.83951
    ## 256          James Harden  HOU 26540100 32.34568
    ## 355         Anthony Davis  NOP 22116750 31.16000
    ## 28           LeBron James  CLE 30963450 30.97297
    ## 404    Karl-Anthony Towns  MIN  5960160 30.32927
    ## 228          Kevin Durant  GSW 26540100 30.19355
    ## 74  Giannis Antetokounmpo  MIL  2995421 28.37500
    ## 359      DeMarcus Cousins  NOP 16957900 27.94118
    ## 110          Jimmy Butler  CHI 17552209 25.60526
    ## 119      Hassan Whiteside  MIA 22116750 25.36364

``` r
subset(dat, dat$EFF < 0)
```

    ##              Player Team Position Experience Salary Rank Age GP GS MIN FGM
    ## 188 Patricio Garino  ORL       SG          R  31969   17  23  5  0  43   0
    ##     FGA Points3 Points3_atts Points2 Points2_atts FTM FTA OREB DREB AST
    ## 188   7       0            5       0            2   0   0    1    6   0
    ##     STL BLK TO PointsFTM missed_FG missed_FT PTS REB MPG  EFF
    ## 188   0   0  3         0         7         0   0   7 8.6 -0.6

``` r
pts_cor <- cor(dat$EFF, dat$PTS)
reb_cor <- cor(dat$EFF, dat$REB)
ast_cor <- cor(dat$EFF, dat$AST)
stl_cor <- cor(dat$EFF, dat$STL)
blk_cor <- cor(dat$EFF, dat$BLK)
missed_fg_cor <- -1 * cor(dat$EFF, dat$missed_FG)
missed_ft_cor <- -1 * cor(dat$EFF, dat$missed_FT)
to_cor <- -1 * cor(dat$EFF, dat$TO)

EFF_cor <- c(pts_cor, reb_cor, ast_cor, stl_cor, blk_cor, missed_fg_cor, missed_ft_cor, to_cor)
EFF_cor <- sort(EFF_cor, decreasing = TRUE)
EFF_cor
```

    ## [1]  0.8588644  0.7634501  0.6957286  0.6689232  0.5679571 -0.7271456
    ## [7] -0.7722477 -0.8003289

``` r
barplot(EFF_cor, col = "red")
```

![](hw02-Tyler-Larsen_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

5. EFFICIENCY AND SALARY
------------------------

``` r
ggplot(dat, aes(x = dat$EFF, y = dat$Salary))+
  geom_point(aes(color = dat$Team))+
  geom_smooth(method = loess)
```

![](hw02-Tyler-Larsen_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

``` r
players2 <- subset(dat, dat$Experience > 19)
head(players2)
```

    ##              Player Team Position Experience   Salary Rank Age GP GS  MIN
    ## 1        Al Horford  BOS        C          9 26540100    4  30 68 68 2193
    ## 3     Avery Bradley  BOS       SG          6  8269663    5  26 55 55 1835
    ## 4 Demetrius Jackson  BOS       PG          R  1450000   15  22  5  0   17
    ## 5      Gerald Green  BOS       SF          9  1410598   11  31 47  0  538
    ## 6     Isaiah Thomas  BOS       PG          5  6587132    1  27 76 76 2569
    ## 7       Jae Crowder  BOS       SF          4  6286408    3  26 72 72 2335
    ##   FGM  FGA Points3 Points3_atts Points2 Points2_atts FTM FTA OREB DREB AST
    ## 1 379  801      86          242     293          559 108 135   95  369 337
    ## 3 359  775     108          277     251          498  68  93   65  269 121
    ## 4   3    4       1            1       2            3   3   6    2    2   3
    ## 5  95  232      39          111      56          121  33  41   17   68  33
    ## 6 682 1473     245          646     437          827 590 649   43  162 449
    ## 7 333  720     157          394     176          326 176 217   48  367 155
    ##   STL BLK  TO PointsFTM missed_FG missed_FT  PTS REB      MPG       EFF
    ## 1  52  87 116       108       422        27  952 464 32.25000 19.514706
    ## 3  68  11  88        68       416        25  894 334 33.36364 16.345455
    ## 4   0   0   0         3         1         3   10   4  3.40000  2.600000
    ## 5   9   7  25        33       137         8  262  85 11.44681  4.808511
    ## 6  70  13 210       590       791        59 2199 205 33.80263 24.684211
    ## 7  72  23  79       176       387        41  999 415 32.43056 16.069444

``` r
ggplot(players2, aes(x = players2$EFF, y = players2$Salary))+
  geom_point(aes(color = players2$Team))+
  geom_smooth(method = loess)
```

![](hw02-Tyler-Larsen_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-2.png)

``` r
EFF_sal_cor <- cor(players2$EFF,players2$Salary)
```

What can you say about the relationship between these two variables for the set of “more established players”? \*

6.COMMENT AND REFLECTIONS
-------------------------

-   What things were hard, even though you saw them in class/lab?
-   What was easy(-ish) even though we haven’t done it in class/lab?
-   Did you need help to complete the assignment? If so, what kind of help?
-   How much time did it take to complete this HW?
-   What was the most time consuming part?
-   Was there anything that you did not understand? or fully grasped?
-   Was there anything frustrating in particular?
-   Was there anything exciting? Something that you feel proud of? (Don’t be shy, we won’t tell anyone).
