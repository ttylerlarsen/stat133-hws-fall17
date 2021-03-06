warmup02
================

R Markdown
----------

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

``` r
rdata <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-salary-points.RData"
download.file(url = rdata, destfile = '~/Desktop/nba2017-salary-points.RData')


load('~/nba2017-salary-points.RData')
#head(player)

ls()
```

    ## [1] "player"   "points"   "points1"  "points2"  "points3"  "position"
    ## [7] "rdata"    "salary"   "team"

*For my Exploratory analysis, the variables I'm choosing are:*

-   Quantitative: Salary
-   Qualitative: Position

``` r
#quantitative data analysis (salary)

salary_millions <- salary / 1000000
summary(salary_millions)
```

    ##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    ##  0.005145  1.286160  3.500000  6.187014  9.250000 30.963450

``` r
hist(salary_millions)
```

![](up02-Tyler-Larsen_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
boxplot(salary_millions)
```

![](up02-Tyler-Larsen_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-2.png)

``` r
d <- (density(salary_millions))
plot(d)
```

![](up02-Tyler-Larsen_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-3.png)

``` r
#qualitative data analyis (position)

table(position)
```

    ## position
    ##  C PF PG SF SG 
    ## 89 89 85 83 95

``` r
prop.table(table(position))
```

    ## position
    ##         C        PF        PG        SF        SG 
    ## 0.2018141 0.2018141 0.1927438 0.1882086 0.2154195

``` r
barplot(table(position), main = "Number of Players per Position", xlab = "Position")
```

![](up02-Tyler-Larsen_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

-   What things were hard, even though you saw them in class?

The most difficult part was just remembering specific fuctions, even though I've seen them in class I still don't remember them perfectly.

-   What was easy(-ish) even though we haven't done it in class?

Formatting graphs/plots is not especially difficult.

-   What type of "errors" you struggled with (if any)?

On several occasions I would imput the incorrect data type as the argument of a function.

-   What are the parts you are not fully understanding?

I still don't really understand what all is going on when I download and import the data file.

-   What was the most time consuming part?

For some reason my HTML file would not knit becuase it kept saying it could not find the specified objects, which took some time to figure out.

-   Did you collaborate with other students? If so, with who? In what manner?

I did not collaborate with any other students.

-   Was there any frustrating issue? (e.g. RStudio cryptic error, one or more package not playing nice)

Just this issue with my HTML file not knitting.
