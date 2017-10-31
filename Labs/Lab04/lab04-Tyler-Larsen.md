Lab 4: Data Frame Basics
================
Gaston Sanchez

> ### Learning Objectives:
>
> -   Get started with data frames
> -   Understand basic operations
> -   Understand bracket and dollar notations

------------------------------------------------------------------------

Manipulating Data Frames
------------------------

The most common format/structure for a data set is a tabular format: with row and columns (like a spreadsheet). When your data is in this shape, most of the time you will work with R **data frames** (or similar rectangular structures like a `"matrix"`, `"table"`, etc).

Learning how to manipulate data tables is among the most important *data computing* basic skills. The traditional way of manipulating data frames in R is based on bracket notation, e.g. `dat[ , ]`, to select specific rows, columns, or cells. Also, the use of the dollar `$` operator to handle columns is fundamental. In this part of the lab, you will practice a wide array of data wrangling tasks with the so-called bracket notation, and the dollar operator.

I should say that there are alternative ways for manipulating tables in R. Among the most recent paradigms, there is the **plying** framework devised by Hadley Wickham. From his doctoral research, the first *plyr* tools were available in the packages `"plyr"` and `"reshape"`. Nowadays we have the `"reshape2"` package, and the extremely popular package `"dplyr"` (among other packages). You will have time to learn more about `"dplyr"` in the next weeks. In the meantime, take some time to understand more about the bracket notation.

Creating data frames
--------------------

Most of the (raw) data tables you will be working with will already be in some data file. However, from time to time you will face the need of creating some sort of data table in R. In these situations, you will likely have to create such table with a data frame. So let's look at various ways to "manually"" create a data frame.

**Option 1**: The primary option to build a data frame is with `data.frame()`. You pass a series of vectors (or factors), of the same length, separated by commas. Each vector (or factor) will become a column in the generated data frame. Preferably, give names to each column, like `col1`, `col2`, and `col3`, in the example below:

``` r
# creating a basic data frame
my_table1 <- data.frame(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE)
)

my_table1
```

    ##   col1 col2  col3
    ## 1    A   10  TRUE
    ## 2    B   20  TRUE
    ## 3    C   30 FALSE
    ## 4    D   40  TRUE
    ## 5    E   50 FALSE

**Option 2**: Another way to create data frames is with a `list` containing vectors or factors (of the same length), which then you convert to a data.frame with `data.frame()`:

``` r
# another way to create a basic data frame
my_list <- list(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE)
)

my_table2 <- data.frame(my_list)

my_table2
```

    ##   col1 col2  col3
    ## 1    A   10  TRUE
    ## 2    B   20  TRUE
    ## 3    C   30 FALSE
    ## 4    D   40  TRUE
    ## 5    E   50 FALSE

Remember that a `data.frame` is nothing more than a `list`. So as long as the elements in the list (vectors or factors) are of the same length, we can simply convert the list into a data frame.

By default, `data.frame()` converts character vectors into factors. You can check that by exmining the structure of the data frame with `str()`:

``` r
str(my_table2)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ col1: Factor w/ 5 levels "A","B","C","D",..: 1 2 3 4 5
    ##  $ col2: num  10 20 30 40 50
    ##  $ col3: logi  TRUE TRUE FALSE TRUE FALSE

To prevent `data.frame()` from converting strings into factors, you must use the argument `stringsAsFactors = FALSE`

``` r
# strings as strings (not as factors)
my_table3 <- data.frame(
  col1 = LETTERS[1:5],
  col2 = seq(from = 10, to = 50, by = 10),
  col3 = c(TRUE, TRUE, FALSE, TRUE, FALSE),
  stringsAsFactors = FALSE
)

str(my_table3)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ col1: chr  "A" "B" "C" "D" ...
    ##  $ col2: num  10 20 30 40 50
    ##  $ col3: logi  TRUE TRUE FALSE TRUE FALSE

### Your turn

Here's a table with the starting lineup of the Golden State Warriors:

| Player   | Position | Salary     | Points | PPG  | Rookie |
|----------|----------|------------|--------|------|--------|
| Thompson | SG       | 16,663,575 | 1742   | 22.3 | FALSE  |
| Curry    | PG       | 12,112,359 | 1999   | 25.3 | FALSE  |
| Green    | PF       | 15,330,435 | 776    | 10.2 | FALSE  |
| Durant   | SF       | 26,540,100 | 1555   | 25.1 | FALSE  |
| Pachulia | C        | 2,898,000  | 426    | 6.1  | FALSE  |

-   Start by creating vectors for each of the columns.
-   Use the vectors to create a first data frame with `data.frame()`.
-   Check that this data frame is of class `"data.frame"`, and that it is also a list.
-   Create another data frame by first starting with a `list()`, and then passing the list to `data.frame()`.
-   What would you do to obtain a data frame such that when you check its structure `str()` the variables are:
    -   *Player* as character
    -   *Position* as factor
    -   *Salary* as numeric or real (ignore the commas)
    -   *Points* as integer
    -   *PPG* as numeric or real
    -   *Rookie* as logical
-   Find out how to use the *column binding* function `cbind()` to create a tabular object with the vectors created in step 1 (inspect what class of object is obtained with `cbind()`).
-   How could you convert the object in the previous step into a data frame?

``` r
GSW_table <- data.frame(
  col1 = c("Thompson", "Curry", "Green", "Druant", "Pachulia"),
  col2 = c("SG", "PG", "PF", "SF", "C"),
  col3 = c(16663575, 12112359, 15330435, 26540100, 2898000),
  col3 = c(1742, 1999, 776, 1555, 426),
  col4 = c(22.3, 25.3, 10.2, 25.1, 6.1),
  col5 = c(FALSE, FALSE, FALSE, FALSE, FALSE)
)

colnames(GSW_table) <- c("Player","Positition", "Salary", "Points", "PPG", "Rookie")


GSW_table
```

    ##     Player Positition   Salary Points  PPG Rookie
    ## 1 Thompson         SG 16663575   1742 22.3  FALSE
    ## 2    Curry         PG 12112359   1999 25.3  FALSE
    ## 3    Green         PF 15330435    776 10.2  FALSE
    ## 4   Druant         SF 26540100   1555 25.1  FALSE
    ## 5 Pachulia          C  2898000    426  6.1  FALSE

------------------------------------------------------------------------

Basic Operations with Data Frames
---------------------------------

Now that you have seen some ways to create data frames, let's discuss a number of basic manipulations of data frames. I will show you some examples and then you'll have the chance to put in practice the following operations:

-   Selecting table elements:
    -   select a given cell
    -   select a set of cells
    -   select a given row
    -   select a set of rows
    -   select a given column
    -   select a set of columns
-   Adding a new column
-   Deleting a new column
-   Renaming a column
-   Moving a column
-   Transforming a column

Let's say you have a data frame `tbl` with the lineup of the Golden State Warriors:

        player position   salary points  ppg rookie
    1 Thompson       SG 16663575   1742 22.3  FALSE
    2    Curry       PG 12112359   1999 25.3  FALSE
    3    Green       PF 15330435    776 10.2  FALSE
    4   Durant       SF 26540100   1555 25.1  FALSE
    5 Pachulia        C  2898000    426  6.1  FALSE

#### Selecting elements

The data frame `tbl` is a 2-dimensional object: the 1st dimension corresponds to the rows, while the 2nd dimension corresponds to the columns. Because `tbl` has two dimensions, the bracket notation involves working with the data frame in this form: `tbl[ , ]`. In other words, you have to specify values inside the brackets for the 1st index, and the 2nd index: `tbl[index1, index2]`.

``` r
# select value in row 1 and column 1
tbl[1,1]
```

    ## [1] "Thompson"

``` r
# select value in row 2 and column 5
tbl[2,5]
```

    ## [1] 25.3

``` r
# select values in these cells
tbl[1:3,3:5]
```

    ##     salary points  ppg
    ## 1 16663575   1742 22.3
    ## 2 12112359   1999 25.3
    ## 3 15330435    776 10.2

If no value is specified for `index1` then all rows are included. Likewise, if no value is specified for `index2` then all columns are included.

``` r
# selecting first row
tbl[1, ]
```

    ##     player position   salary points  ppg rookie
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE

``` r
# selecting third row
tbl[3, ]
```

    ##   player position   salary points  ppg rookie
    ## 3  Green       PF 15330435    776 10.2  FALSE

``` r
# selecting second column
tbl[ ,2]
```

    ## [1] "SG" "PG" "PF" "SF" "C"

``` r
# selecting columns 3 to 5
tbl[ ,3:5]
```

    ##     salary points  ppg
    ## 1 16663575   1742 22.3
    ## 2 12112359   1999 25.3
    ## 3 15330435    776 10.2
    ## 4 26540100   1555 25.1
    ## 5  2898000    426  6.1

#### Adding a column

Perhaps the simplest way to add a column is with the dollar operator `$`. You just need to give a name for the new column, and assign a vector (or factor):

``` r
# adding a column
tbl$new_column <- c('a', 'e', 'i', 'o', 'u')
tbl
```

    ##     player position   salary points  ppg rookie new_column
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE          a
    ## 2    Curry       PG 12112359   1999 25.3  FALSE          e
    ## 3    Green       PF 15330435    776 10.2  FALSE          i
    ## 4   Durant       SF 26540100   1555 25.1  FALSE          o
    ## 5 Pachulia        C  2898000    426  6.1  FALSE          u

Another way to add a column is with the *column binding* function `cbind()`:

``` r
# vector of weights
weight <- c(215, 190, 230, 240, 270)

# adding weights to tbl
tbl <- cbind(tbl, weight)
tbl
```

    ##     player position   salary points  ppg rookie new_column weight
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE          a    215
    ## 2    Curry       PG 12112359   1999 25.3  FALSE          e    190
    ## 3    Green       PF 15330435    776 10.2  FALSE          i    230
    ## 4   Durant       SF 26540100   1555 25.1  FALSE          o    240
    ## 5 Pachulia        C  2898000    426  6.1  FALSE          u    270

#### Deleting a column

The inverse operation of adding a column consists of **deleting** a column. This is possible with the `$` dollar operator. For instance, say you want to remove the column `new_column`. Use the `$` operator to select this column, and assign it the value `NULL` (think of this as *NULLifying* a column):

``` r
# deleting a column
tbl$new_column <- NULL
tbl
```

    ##     player position   salary points  ppg rookie weight
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE    215
    ## 2    Curry       PG 12112359   1999 25.3  FALSE    190
    ## 3    Green       PF 15330435    776 10.2  FALSE    230
    ## 4   Durant       SF 26540100   1555 25.1  FALSE    240
    ## 5 Pachulia        C  2898000    426  6.1  FALSE    270

#### Renaming a column

What if you want to rename a column? There are various options to do this. One way is by changing the column`names` attribute:

``` r
# attributes
attributes(tbl)
```

    ## $names
    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rookie"  
    ## [7] "weight"  
    ## 
    ## $row.names
    ## [1] 1 2 3 4 5
    ## 
    ## $class
    ## [1] "data.frame"

which is more commonly accessed with the `names()` function:

``` r
# column names
names(tbl)
```

    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rookie"  
    ## [7] "weight"

Notice that `tbl` has a list of attributes. The element `names` is the vector of column names.

You can directly modify the vector of `names`; for example let's change `rookie` to `rooky`:

``` r
# changing rookie to rooky
attributes(tbl)$names[6] <- "rooky"

# display column names
names(tbl)
```

    ## [1] "player"   "position" "salary"   "points"   "ppg"      "rooky"   
    ## [7] "weight"

By the way: this way of changing the name of a variable is very low level, and probably unfamiliar to most useRs.

#### Moving a column

A more challenging operation is when you want to move a column to a different position. What if you want to move `salary` to the last position (last column)? One option is to create a vector of column names in the desired order, and then use this vector (for the index of columns) to reassign the data frame like this:

``` r
reordered_names <- c("player", "position", "points", "ppg", "rooky", "weight", "salary")

# moving salary at the end
tbl <- tbl[ ,reordered_names]
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16663575
    ## 2    Curry       PG   1999 25.3 FALSE    190 12112359
    ## 3    Green       PF    776 10.2 FALSE    230 15330435
    ## 4   Durant       SF   1555 25.1 FALSE    240 26540100
    ## 5 Pachulia        C    426  6.1 FALSE    270  2898000

#### Transforming a column

A more common operation than deleting or moving a column, is to transform the values in a column. This can be easily accomplished with the `$` operator. For instance, let's say that we want to transform `salary` from dollars to millions of dollars:

``` r
# converting salary in millions of dollars
tbl$salary <- tbl$salary / 1000000
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

Likewise, instead of using the `$` operator, you can refer to the column using bracket notation. Here's how to transform weight from pounds to kilograms (1 pound = 0.453592 kilograms):

``` r
# weight in kilograms
tbl[ ,"weight"] <- tbl[ ,"weight"] * 0.453592
tbl
```

    ##     player position points  ppg rooky    weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE  97.52228 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE  86.18248 12.11236
    ## 3    Green       PF    776 10.2 FALSE 104.32616 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE 108.86208 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE 122.46984  2.89800

There is also the `transform()` function which transform values *interactively*, that is, temporarily:

``` r
# transform weight to inches
transform(tbl, weight = weight / 0.453592)
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

`transform()` does its job of modifying the values of `weight` but only temporarily; if you inspect `tbl` you'll see what this means:

``` r
# did weight really change?
tbl
```

    ##     player position points  ppg rooky    weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE  97.52228 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE  86.18248 12.11236
    ## 3    Green       PF    776 10.2 FALSE 104.32616 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE 108.86208 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE 122.46984  2.89800

To make the changes permanent with `transform()`, you need to reaassign them to the data frame:

``` r
# transform weight to inches (permanently)
tbl <- transform(tbl, weight = weight / 0.453592)
tbl
```

    ##     player position points  ppg rooky weight   salary
    ## 1 Thompson       SG   1742 22.3 FALSE    215 16.66358
    ## 2    Curry       PG   1999 25.3 FALSE    190 12.11236
    ## 3    Green       PF    776 10.2 FALSE    230 15.33043
    ## 4   Durant       SF   1555 25.1 FALSE    240 26.54010
    ## 5 Pachulia        C    426  6.1 FALSE    270  2.89800

------------------------------------------------------------------------

NBA Players Data
----------------

``` r
csv <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv"
download.file(url = csv, destfile = 'nba2017-players.csv')
dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)
```

Now that you've seen some of the most basic operations to maipulate data frames, let's apply them on a data set about NBA players. The corresponding data file is `nba2017-players.csv`, located in the `data/` folder of the course github repository. This file contains 15 variables measured on 441 players.

First download a copy of the csv file to your computer.

``` r
# download csv file into your working directory
#csv <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/data/nba2017-players.csv"
# download.file(url = csv, destfile = 'nba2017-players.csv')
```

To import the data in R you can use the function `read.csv()`:

``` r
dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)
```

Notice that I'm specifying the argument `stringsAsFactors = FALSE` to avoid the conversion of characters into R factors. Why do you think this is a good practice?

All the default reading table functions generate a data frame. Typically, everytime I read a new data set which I'm not familiar with, or a data set that I haven't worked on in a long time, I always like to call a couple of functions to inspect its contents:

-   `dim()`
-   `head()`
-   `tail()`
-   `str()`
-   `summary()`

A first check-up is to examine the dimensions of the data frame with `dim()`:

``` r
# dimensions (# of rows, # of columns)
dim(dat)
```

    ## [1] 441  15

If you know in advanced how many rows and columns are in the data table, this is a good way to make sure that R was able to read all the records.

Then, depending on the size of the data, you may want to take a peek at its contents with `head()` or `tail()`, just to get an idea of what the data looks like:

``` r
# display first few rows
head(dat)
```

    ##              player team position height weight age experience
    ## 1        Al Horford  BOS        C     82    245  30          9
    ## 2      Amir Johnson  BOS       PF     81    240  29         11
    ## 3     Avery Bradley  BOS       SG     74    180  26          6
    ## 4 Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5      Gerald Green  BOS       SF     79    205  31          9
    ## 6     Isaiah Thomas  BOS       PG     69    185  27          5
    ##                         college   salary games minutes points points3
    ## 1         University of Florida 26540100    68    2193    952      86
    ## 2                               12000000    80    1608    520      27
    ## 3 University of Texas at Austin  8269663    55    1835    894     108
    ## 4      University of Notre Dame  1450000     5      17     10       1
    ## 5                                1410598    47     538    262      39
    ## 6      University of Washington  6587132    76    2569   2199     245
    ##   points2 points1
    ## 1     293     108
    ## 2     186      67
    ## 3     251      68
    ## 4       2       3
    ## 5      56      33
    ## 6     437     590

For a more detailed description of how R is treating the data type in each column, you should use the structure function `str()`.

``` r
# check the structure
str(dat, vec.len = 1)
```

    ## 'data.frame':    441 obs. of  15 variables:
    ##  $ player    : chr  "Al Horford" ...
    ##  $ team      : chr  "BOS" ...
    ##  $ position  : chr  "C" ...
    ##  $ height    : int  82 81 ...
    ##  $ weight    : int  245 240 ...
    ##  $ age       : int  30 29 ...
    ##  $ experience: int  9 11 ...
    ##  $ college   : chr  "University of Florida" ...
    ##  $ salary    : num  26540100 ...
    ##  $ games     : int  68 80 ...
    ##  $ minutes   : int  2193 1608 ...
    ##  $ points    : int  952 520 ...
    ##  $ points3   : int  86 27 ...
    ##  $ points2   : int  293 186 ...
    ##  $ points1   : int  108 67 ...

This function `str()` displays the dimensions of the data frame, and then a list with the name of all the variables, and their data types (e.g. `chr` character, `num` real, etc). The argument `vec.len = 1` indicates that just the first element in each column should be displayed.

When working with data frames, remember to always take some time inspecting the contents, and checking how R is handling the data types. It is in these early stages of data exploration that you can catch potential issues in order to avoid disastrous consequences or bugs in subsequent stages.

------------------------------------------------------------------------

### Your turn:

Use bracket notation, the dollar operator, as well as concepts of logical subsetting and indexing to:

-   Display the last 5 rows of the data.

``` r
tail(dat)
```

    ##              player team position height weight age experience
    ## 436 Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437 Marquese Chriss  PHO       PF     82    233  19          0
    ## 438    Ronnie Price  PHO       PG     74    190  33         11
    ## 439     T.J. Warren  PHO       SF     80    230  23          2
    ## 440      Tyler Ulis  PHO       PG     70    150  21          0
    ## 441  Tyson Chandler  PHO        C     85    240  34         15
    ##                             college   salary games minutes points points3
    ## 436                                  4000000    67     963    419      35
    ## 437        University of Washington  2941440    82    1743    753      72
    ## 438       Utah Valley State College   282595    14     134     14       3
    ## 439 North Carolina State University  2128920    66    2048    951      26
    ## 440          University of Kentucky   918369    61    1123    444      21
    ## 441                                 12415000    47    1298    397       0
    ##     points2 points1
    ## 436     137      40
    ## 437     212     113
    ## 438       1       3
    ## 439     377     119
    ## 440     163      55
    ## 441     153      91

-   Display those rows associated to players having height less than 70 inches tall.

``` r
tall <- subset(dat, height > 70)
tall
```

    ##                       player team position height weight age experience
    ## 1                 Al Horford  BOS        C     82    245  30          9
    ## 2               Amir Johnson  BOS       PF     81    240  29         11
    ## 3              Avery Bradley  BOS       SG     74    180  26          6
    ## 4          Demetrius Jackson  BOS       PG     73    201  22          0
    ## 5               Gerald Green  BOS       SF     79    205  31          9
    ## 7                Jae Crowder  BOS       SF     78    235  26          4
    ## 8                James Young  BOS       SG     78    215  21          2
    ## 9               Jaylen Brown  BOS       SF     79    225  20          0
    ## 10             Jonas Jerebko  BOS       PF     82    231  29          6
    ## 11             Jordan Mickey  BOS       PF     80    235  22          1
    ## 12              Kelly Olynyk  BOS        C     84    238  25          3
    ## 13              Marcus Smart  BOS       SG     76    220  22          2
    ## 14              Terry Rozier  BOS       PG     74    190  22          1
    ## 15              Tyler Zeller  BOS        C     84    253  27          4
    ## 16             Channing Frye  CLE        C     83    255  33         10
    ## 17             Dahntay Jones  CLE       SF     78    225  36         12
    ## 18            Deron Williams  CLE       PG     75    200  32         11
    ## 19          Derrick Williams  CLE       PF     80    240  25          5
    ## 20               Edy Tavares  CLE        C     87    260  24          1
    ## 21             Iman Shumpert  CLE       SG     77    220  26          5
    ## 22                J.R. Smith  CLE       SG     78    225  31         12
    ## 23               James Jones  CLE       SF     80    218  36         13
    ## 25                Kevin Love  CLE       PF     82    251  28          8
    ## 26               Kyle Korver  CLE       SG     79    212  35         13
    ## 27              Kyrie Irving  CLE       PG     75    193  24          5
    ## 28              LeBron James  CLE       SF     80    250  32         13
    ## 29         Richard Jefferson  CLE       SF     79    233  36         15
    ## 30          Tristan Thompson  CLE        C     81    238  25          5
    ## 31             Bruno Caboclo  TOR       SF     81    218  21          2
    ## 32               Cory Joseph  TOR       SG     75    193  25          5
    ## 33              Delon Wright  TOR       PG     77    183  24          1
    ## 34             DeMar DeRozan  TOR       SG     79    221  27          7
    ## 35           DeMarre Carroll  TOR       SF     80    215  30          7
    ## 36             Fred VanVleet  TOR       PG     72    195  22          0
    ## 37              Jakob Poeltl  TOR        C     84    248  21          0
    ## 38         Jonas Valanciunas  TOR        C     84    265  24          4
    ## 39                Kyle Lowry  TOR       PG     72    205  30         10
    ## 40            Lucas Nogueira  TOR        C     84    241  24          2
    ## 41             Norman Powell  TOR       SG     76    215  23          1
    ## 42               P.J. Tucker  TOR       SF     78    245  31          5
    ## 43             Pascal Siakam  TOR       PF     81    230  22          0
    ## 44         Patrick Patterson  TOR       PF     81    230  27          6
    ## 45               Serge Ibaka  TOR       PF     82    235  27          7
    ## 46          Bojan Bogdanovic  WAS       SF     80    216  27          2
    ## 47              Bradley Beal  WAS       SG     77    207  23          4
    ## 48          Brandon Jennings  WAS       PG     73    170  27          7
    ## 49          Chris McCullough  WAS       PF     83    200  21          1
    ## 50             Daniel Ochefu  WAS        C     83    245  23          0
    ## 51               Ian Mahinmi  WAS        C     83    250  30          8
    ## 52               Jason Smith  WAS        C     84    245  30          8
    ## 53                 John Wall  WAS       PG     76    195  26          6
    ## 54             Marcin Gortat  WAS        C     83    240  32          9
    ## 55           Markieff Morris  WAS       PF     82    245  27          5
    ## 56               Otto Porter  WAS       SF     80    198  23          3
    ## 57         Sheldon McClellan  WAS       SG     77    200  24          0
    ## 58          Tomas Satoransky  WAS       SG     79    210  25          0
    ## 59                Trey Burke  WAS       PG     73    191  24          3
    ## 60           DeAndre' Bembry  ATL       SF     78    210  22          0
    ## 61           Dennis Schroder  ATL       PG     73    172  23          3
    ## 62             Dwight Howard  ATL        C     83    265  31         12
    ## 63            Ersan Ilyasova  ATL       PF     82    235  29          8
    ## 64             Jose Calderon  ATL       PG     75    200  35         11
    ## 65             Kent Bazemore  ATL       SF     77    201  27          4
    ## 66            Kris Humphries  ATL       PF     81    235  31         12
    ## 67           Malcolm Delaney  ATL       PG     75    190  27          0
    ## 68             Mike Dunleavy  ATL       SF     81    230  36         14
    ## 69              Mike Muscala  ATL        C     83    240  25          3
    ## 70              Paul Millsap  ATL       PF     80    246  31         10
    ## 71                Ryan Kelly  ATL       PF     83    230  25          3
    ## 72           Thabo Sefolosha  ATL       SF     79    220  32         10
    ## 73              Tim Hardaway  ATL       SG     78    205  24          3
    ## 74     Giannis Antetokounmpo  MIL       SF     83    222  22          3
    ## 75               Greg Monroe  MIL        C     83    265  26          6
    ## 76             Jabari Parker  MIL       PF     80    250  21          2
    ## 77               Jason Terry  MIL       SG     74    185  39         17
    ## 78               John Henson  MIL        C     83    229  26          4
    ## 79           Khris Middleton  MIL       SF     80    234  25          4
    ## 80           Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 81       Matthew Dellavedova  MIL       PG     76    198  26          3
    ## 82           Michael Beasley  MIL       PF     81    235  28          8
    ## 83           Mirza Teletovic  MIL       PF     81    242  31          4
    ## 84             Rashad Vaughn  MIL       SG     78    202  20          1
    ## 85             Spencer Hawes  MIL       PF     85    245  28          9
    ## 86                Thon Maker  MIL        C     85    216  19          0
    ## 87                Tony Snell  MIL       SG     79    200  25          3
    ## 88              Aaron Brooks  IND       PG     72    161  32          8
    ## 89              Al Jefferson  IND        C     82    289  32         12
    ## 90                C.J. Miles  IND       SF     78    225  29         11
    ## 91             Georges Niang  IND       PF     80    230  23          0
    ## 92               Jeff Teague  IND       PG     74    186  28          7
    ## 93                 Joe Young  IND       PG     74    180  24          1
    ## 94            Kevin Seraphin  IND       PF     81    285  27          6
    ## 95          Lance Stephenson  IND       SG     77    230  26          6
    ## 96               Lavoy Allen  IND       PF     81    260  27          5
    ## 97               Monta Ellis  IND       SG     75    185  31         11
    ## 98              Myles Turner  IND        C     83    243  20          1
    ## 99               Paul George  IND       SF     81    220  26          6
    ## 100         Rakeem Christmas  IND       PF     81    250  25          1
    ## 101           Thaddeus Young  IND       PF     80    221  28          9
    ## 102           Anthony Morrow  CHI       SG     77    210  31          8
    ## 103             Bobby Portis  CHI       PF     83    230  21          1
    ## 104            Cameron Payne  CHI       PG     75    185  22          1
    ## 105        Cristiano Felicio  CHI        C     82    275  24          1
    ## 106         Denzel Valentine  CHI       SG     78    212  23          0
    ## 107              Dwyane Wade  CHI       SG     76    220  35         13
    ## 108            Isaiah Canaan  CHI       SG     72    201  25          3
    ## 109             Jerian Grant  CHI       PG     76    195  24          1
    ## 110             Jimmy Butler  CHI       SF     79    220  27          5
    ## 111        Joffrey Lauvergne  CHI        C     83    220  25          2
    ## 112  Michael Carter-Williams  CHI       PG     78    190  25          3
    ## 113           Nikola Mirotic  CHI       PF     82    220  25          2
    ## 114              Paul Zipser  CHI       SF     80    215  22          0
    ## 115              Rajon Rondo  CHI       PG     73    186  30         10
    ## 116              Robin Lopez  CHI        C     84    255  28          8
    ## 117             Dion Waiters  MIA       SG     76    225  25          4
    ## 118             Goran Dragic  MIA       PG     75    190  30          8
    ## 119         Hassan Whiteside  MIA        C     84    265  27          4
    ## 120            James Johnson  MIA       PF     81    250  29          7
    ## 121           Josh McRoberts  MIA       PF     82    240  29          9
    ## 122          Josh Richardson  MIA       SG     78    200  23          1
    ## 123          Justise Winslow  MIA       SF     79    225  20          1
    ## 124             Luke Babbitt  MIA       SF     81    225  27          6
    ## 125              Okaro White  MIA       PF     80    204  24          0
    ## 126          Rodney McGruder  MIA       SG     76    205  25          0
    ## 127            Tyler Johnson  MIA       PG     76    186  24          2
    ## 128            Udonis Haslem  MIA        C     80    235  36         13
    ## 129          Wayne Ellington  MIA       SG     76    200  29          7
    ## 130              Willie Reed  MIA        C     82    220  26          1
    ## 131           Andre Drummond  DET        C     83    279  23          4
    ## 132              Aron Baynes  DET        C     82    260  30          4
    ## 133               Beno Udrih  DET       PG     75    205  34         12
    ## 134         Boban Marjanovic  DET        C     87    290  28          1
    ## 135          Darrun Hilliard  DET       SG     78    205  23          1
    ## 136           Henry Ellenson  DET       PF     83    245  20          0
    ## 137                Ish Smith  DET       PG     72    175  28          6
    ## 138                Jon Leuer  DET       PF     82    228  27          5
    ## 139 Kentavious Caldwell-Pope  DET       SG     77    205  23          3
    ## 140            Marcus Morris  DET       SF     81    235  27          5
    ## 141          Michael Gbinije  DET       SG     79    200  24          0
    ## 142           Reggie Bullock  DET       SF     79    205  25          3
    ## 143           Reggie Jackson  DET       PG     75    208  26          5
    ## 144          Stanley Johnson  DET       SF     79    245  20          1
    ## 145            Tobias Harris  DET       PF     81    235  24          5
    ## 146            Brian Roberts  CHO       PG     73    173  31          4
    ## 147            Briante Weber  CHO       PG     74    165  24          1
    ## 148           Christian Wood  CHO       PF     83    220  21          1
    ## 149              Cody Zeller  CHO       PF     84    240  24          3
    ## 150           Frank Kaminsky  CHO        C     84    242  23          1
    ## 151              Jeremy Lamb  CHO       SG     77    185  24          4
    ## 152          Johnny O'Bryant  CHO       PF     81    257  23          2
    ## 153             Kemba Walker  CHO       PG     73    172  26          5
    ## 154          Marco Belinelli  CHO       SG     77    210  30          9
    ## 155          Marvin Williams  CHO       PF     81    237  30         11
    ## 156   Michael Kidd-Gilchrist  CHO       SF     79    232  23          4
    ## 157            Miles Plumlee  CHO        C     83    249  28          4
    ## 158            Nicolas Batum  CHO       SG     80    200  28          8
    ## 159           Ramon Sessions  CHO       PG     75    190  30          9
    ## 160           Treveon Graham  CHO       SG     78    220  23          0
    ## 161          Carmelo Anthony  NYK       SF     80    240  32         13
    ## 162           Chasson Randle  NYK       PG     74    185  23          0
    ## 163             Courtney Lee  NYK       SG     77    200  31          8
    ## 164             Derrick Rose  NYK       PG     75    190  28          7
    ## 165              Joakim Noah  NYK        C     83    230  31          9
    ## 166           Justin Holiday  NYK       SG     78    185  27          3
    ## 167       Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 168             Kyle O'Quinn  NYK        C     82    250  26          4
    ## 169             Lance Thomas  NYK       PF     80    235  28          5
    ## 170         Marshall Plumlee  NYK        C     84    250  24          0
    ## 171            Maurice Ndour  NYK       PF     81    200  24          0
    ## 172     Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173                Ron Baker  NYK       SG     76    220  23          0
    ## 174            Sasha Vujacic  NYK       SG     79    195  32          9
    ## 175        Willy Hernangomez  NYK        C     83    240  22          0
    ## 176             Aaron Gordon  ORL       SF     81    220  21          2
    ## 177          Bismack Biyombo  ORL        C     81    255  24          5
    ## 178              C.J. Watson  ORL       PG     74    175  32          9
    ## 179            D.J. Augustin  ORL       PG     72    183  29          8
    ## 180             Damjan Rudez  ORL       SF     82    228  30          2
    ## 181            Elfrid Payton  ORL       PG     76    185  22          2
    ## 182            Evan Fournier  ORL       SG     79    205  24          4
    ## 183               Jeff Green  ORL       PF     81    235  30          8
    ## 184              Jodie Meeks  ORL       SG     76    210  29          7
    ## 185      Marcus Georges-Hunt  ORL       SG     77    216  22          0
    ## 186            Mario Hezonja  ORL       SF     80    215  21          1
    ## 187           Nikola Vucevic  ORL        C     84    260  26          5
    ## 188          Patricio Garino  ORL       SG     78    210  23          0
    ## 189        Stephen Zimmerman  ORL        C     84    240  20          0
    ## 190            Terrence Ross  ORL       SF     79    206  25          4
    ## 191           Alex Poythress  PHI       PF     79    238  23          0
    ## 192              Dario Saric  PHI       PF     82    223  22          0
    ## 193         Gerald Henderson  PHI       SG     77    215  29          7
    ## 194            Jahlil Okafor  PHI        C     83    275  21          1
    ## 195           Jerryd Bayless  PHI       PG     75    200  28          8
    ## 196              Joel Embiid  PHI        C     84    250  22          0
    ## 197          Justin Anderson  PHI       SF     78    228  23          1
    ## 198             Nik Stauskas  PHI       SG     78    205  23          2
    ## 199           Richaun Holmes  PHI        C     82    245  23          1
    ## 200         Robert Covington  PHI       SF     81    215  26          3
    ## 201         Sergio Rodriguez  PHI       PG     75    176  30          4
    ## 202               Shawn Long  PHI        C     81    255  24          0
    ## 203           T.J. McConnell  PHI       PG     74    200  24          1
    ## 204           Tiago Splitter  PHI        C     83    245  32          6
    ## 205  Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 206         Andrew Nicholson  BRK       PF     81    250  27          4
    ## 207           Archie Goodwin  BRK       SG     77    200  22          3
    ## 208              Brook Lopez  BRK        C     84    275  28          8
    ## 209             Caris LeVert  BRK       SF     79    203  22          0
    ## 210         Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 211               Jeremy Lin  BRK       PG     75    200  28          6
    ## 212               Joe Harris  BRK       SG     78    219  25          2
    ## 213          Justin Hamilton  BRK        C     84    260  26          2
    ## 214           K.J. McDaniels  BRK       SF     78    205  23          2
    ## 215               Quincy Acy  BRK       PF     79    240  26          4
    ## 216               Randy Foye  BRK       SG     76    213  33         10
    ## 217  Rondae Hollis-Jefferson  BRK       SF     79    220  22          1
    ## 218          Sean Kilpatrick  BRK       SG     76    210  27          2
    ## 219        Spencer Dinwiddie  BRK       PG     78    200  23          2
    ## 220            Trevor Booker  BRK       PF     80    228  29          6
    ## 221           Andre Iguodala  GSW       SF     78    215  33         12
    ## 222             Damian Jones  GSW        C     84    245  21          0
    ## 223               David West  GSW        C     81    250  36         13
    ## 224           Draymond Green  GSW       PF     79    230  26          4
    ## 225                Ian Clark  GSW       SG     75    175  25          3
    ## 226     James Michael McAdoo  GSW       PF     81    230  24          2
    ## 227             JaVale McGee  GSW        C     84    270  29          8
    ## 228             Kevin Durant  GSW       SF     81    240  28          9
    ## 229             Kevon Looney  GSW        C     81    220  20          1
    ## 230            Klay Thompson  GSW       SG     79    215  26          5
    ## 231              Matt Barnes  GSW       SF     79    226  36         13
    ## 232            Patrick McCaw  GSW       SG     79    185  21          0
    ## 233         Shaun Livingston  GSW       PG     79    192  31         11
    ## 234            Stephen Curry  GSW       PG     75    190  28          7
    ## 235            Zaza Pachulia  GSW        C     83    270  32         13
    ## 236              Bryn Forbes  SAS       SG     75    190  23          0
    ## 237              Danny Green  SAS       SG     78    215  29          7
    ## 238                David Lee  SAS       PF     81    245  33         11
    ## 239            Davis Bertans  SAS       PF     82    210  24          0
    ## 240          Dejounte Murray  SAS       PG     77    170  20          0
    ## 241           Dewayne Dedmon  SAS        C     84    245  27          3
    ## 242             Joel Anthony  SAS        C     81    245  34          9
    ## 243         Jonathon Simmons  SAS       SG     78    195  27          1
    ## 244            Kawhi Leonard  SAS       SF     79    230  25          5
    ## 245            Kyle Anderson  SAS       SG     81    230  23          2
    ## 246        LaMarcus Aldridge  SAS       PF     83    260  31         10
    ## 247            Manu Ginobili  SAS       SG     78    205  39         14
    ## 248              Patty Mills  SAS       PG     72    185  28          7
    ## 249                Pau Gasol  SAS        C     84    250  36         15
    ## 250              Tony Parker  SAS       PG     74    185  34         15
    ## 251              Bobby Brown  HOU       PG     74    175  32          2
    ## 252           Chinanu Onuaku  HOU        C     82    245  20          0
    ## 253             Clint Capela  HOU        C     82    240  22          2
    ## 254              Eric Gordon  HOU       SG     76    215  28          8
    ## 255            Isaiah Taylor  HOU       PG     75    170  22          0
    ## 256             James Harden  HOU       PG     77    220  27          7
    ## 257             Kyle Wiltjer  HOU       PF     82    240  24          0
    ## 258             Lou Williams  HOU       SG     73    175  30         11
    ## 259         Montrezl Harrell  HOU        C     80    240  23          1
    ## 260         Patrick Beverley  HOU       SG     73    185  28          4
    ## 261            Ryan Anderson  HOU       PF     82    240  28          8
    ## 262               Sam Dekker  HOU       SF     81    230  22          1
    ## 263             Trevor Ariza  HOU       SF     80    215  31         12
    ## 264            Troy Williams  HOU       SF     79    218  22          0
    ## 265            Alan Anderson  LAC       SF     78    220  34          7
    ## 266            Austin Rivers  LAC       SG     76    200  24          4
    ## 267            Blake Griffin  LAC       PF     82    251  27          6
    ## 268             Brandon Bass  LAC       PF     80    250  31         11
    ## 269            Brice Johnson  LAC       PF     82    230  22          0
    ## 270               Chris Paul  LAC       PG     72    175  31         11
    ## 271           DeAndre Jordan  LAC        C     83    265  28          8
    ## 272            Diamond Stone  LAC        C     83    255  19          0
    ## 273              J.J. Redick  LAC       SG     76    190  32         10
    ## 274           Jamal Crawford  LAC       SG     77    200  36         16
    ## 275         Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 276        Marreese Speights  LAC        C     82    255  29          8
    ## 277              Paul Pierce  LAC       SF     79    235  39         18
    ## 278           Raymond Felton  LAC       PG     73    205  32         11
    ## 279           Wesley Johnson  LAC       SF     79    215  29          6
    ## 280               Alec Burks  UTA       SG     78    214  25          5
    ## 281               Boris Diaw  UTA       PF     80    250  34         13
    ## 282               Dante Exum  UTA       PG     78    190  21          1
    ## 283           Derrick Favors  UTA       PF     82    265  25          6
    ## 284              George Hill  UTA       PG     75    188  30          8
    ## 285           Gordon Hayward  UTA       SF     80    226  26          6
    ## 286              Jeff Withey  UTA        C     84    231  26          3
    ## 287               Joe Ingles  UTA       SF     80    226  29          2
    ## 288              Joe Johnson  UTA       SF     79    240  35         15
    ## 289            Joel Bolomboy  UTA       PF     81    235  23          0
    ## 290                Raul Neto  UTA       PG     73    179  24          1
    ## 291              Rodney Hood  UTA       SG     80    206  24          2
    ## 292              Rudy Gobert  UTA        C     85    245  24          3
    ## 293             Shelvin Mack  UTA       PG     75    203  26          5
    ## 294               Trey Lyles  UTA       PF     82    234  21          1
    ## 295             Alex Abrines  OKC       SG     78    190  23          0
    ## 296           Andre Roberson  OKC       SF     79    210  25          3
    ## 297         Domantas Sabonis  OKC       PF     83    240  20          0
    ## 298           Doug McDermott  OKC       SF     80    225  25          2
    ## 299              Enes Kanter  OKC        C     83    245  24          5
    ## 300             Jerami Grant  OKC       SF     80    210  22          2
    ## 301             Josh Huestis  OKC       PF     79    230  25          1
    ## 302             Kyle Singler  OKC       SF     80    228  28          4
    ## 303            Nick Collison  OKC       PF     82    255  36         12
    ## 304              Norris Cole  OKC       PG     74    175  28          5
    ## 305        Russell Westbrook  OKC       PG     75    200  28          8
    ## 306           Semaj Christon  OKC       PG     75    190  24          0
    ## 307             Steven Adams  OKC        C     84    255  23          3
    ## 308               Taj Gibson  OKC       PF     81    225  31          7
    ## 309           Victor Oladipo  OKC       SG     76    210  24          3
    ## 310          Andrew Harrison  MEM       PG     78    213  22          0
    ## 311           Brandan Wright  MEM       PF     82    210  29          8
    ## 312         Chandler Parsons  MEM       SF     82    230  28          5
    ## 313            Deyonta Davis  MEM        C     83    237  20          0
    ## 314              James Ennis  MEM       SF     79    210  26          2
    ## 315           JaMychal Green  MEM       PF     81    227  26          2
    ## 316            Jarell Martin  MEM       PF     82    239  22          1
    ## 317               Marc Gasol  MEM        C     85    255  32          8
    ## 318              Mike Conley  MEM       PG     73    175  29          9
    ## 319               Tony Allen  MEM       SG     76    213  35         12
    ## 320             Troy Daniels  MEM       SG     76    205  25          3
    ## 321             Vince Carter  MEM       SF     78    220  40         18
    ## 322             Wade Baldwin  MEM       PG     76    202  20          0
    ## 323             Wayne Selden  MEM       SG     77    230  22          0
    ## 324            Zach Randolph  MEM       PF     81    260  35         15
    ## 325          Al-Farouq Aminu  POR       SF     81    220  26          6
    ## 326             Allen Crabbe  POR       SG     78    210  24          3
    ## 327            C.J. McCollum  POR       SG     76    200  25          3
    ## 328           Damian Lillard  POR       PG     75    195  26          4
    ## 329                 Ed Davis  POR       PF     82    240  27          6
    ## 330              Evan Turner  POR       SF     79    220  28          6
    ## 331              Jake Layman  POR       SF     81    210  22          0
    ## 332             Jusuf Nurkic  POR        C     84    280  22          2
    ## 333         Maurice Harkless  POR       SF     81    215  23          4
    ## 334           Meyers Leonard  POR       PF     85    245  24          4
    ## 335              Noah Vonleh  POR       PF     82    240  21          2
    ## 336          Pat Connaughton  POR       SG     77    206  24          1
    ## 337           Shabazz Napier  POR       PG     73    175  25          2
    ## 338           Tim Quarterman  POR       SG     78    195  22          0
    ## 339         Danilo Gallinari  DEN       SF     82    225  28          7
    ## 340           Darrell Arthur  DEN       PF     81    235  28          7
    ## 341          Emmanuel Mudiay  DEN       PG     77    200  20          1
    ## 342              Gary Harris  DEN       SG     76    210  22          2
    ## 343             Jamal Murray  DEN       SG     76    207  19          0
    ## 344            Jameer Nelson  DEN       PG     72    190  34         12
    ## 345         Juan Hernangomez  DEN       PF     81    230  21          0
    ## 346           Kenneth Faried  DEN       PF     80    228  27          5
    ## 347            Malik Beasley  DEN       SG     77    196  20          0
    ## 348            Mason Plumlee  DEN        C     83    245  26          3
    ## 349              Mike Miller  DEN       SF     80    218  36         16
    ## 350             Nikola Jokic  DEN        C     82    250  21          1
    ## 351              Roy Hibbert  DEN        C     86    270  30          8
    ## 352              Will Barton  DEN       SG     78    175  26          4
    ## 353          Wilson Chandler  DEN       SF     80    225  29          8
    ## 354            Alexis Ajinca  NOP        C     86    248  28          6
    ## 355            Anthony Davis  NOP        C     82    253  23          4
    ## 356             Axel Toupane  NOP       SF     79    197  24          1
    ## 357            Cheick Diallo  NOP       PF     81    220  20          0
    ## 358         Dante Cunningham  NOP       SF     80    230  29          7
    ## 359         DeMarcus Cousins  NOP        C     83    270  26          6
    ## 360       Donatas Motiejunas  NOP       PF     84    222  26          4
    ## 361            E'Twaun Moore  NOP       SG     76    191  27          5
    ## 362          Jordan Crawford  NOP       SG     76    195  28          4
    ## 363             Jrue Holiday  NOP       PG     76    205  26          7
    ## 364                Omer Asik  NOP        C     84    255  30          6
    ## 365               Quinn Cook  NOP       PG     74    184  23          0
    ## 366             Solomon Hill  NOP       SF     79    225  25          3
    ## 367              Tim Frazier  NOP       PG     73    170  26          2
    ## 368             A.J. Hammons  DAL        C     84    260  24          0
    ## 369          DeAndre Liggins  DAL       SG     78    209  28          3
    ## 370             Devin Harris  DAL       PG     75    192  33         12
    ## 371            Dirk Nowitzki  DAL       PF     84    245  38         18
    ## 372      Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 373            Dwight Powell  DAL        C     83    240  25          2
    ## 374          Harrison Barnes  DAL       PF     80    210  24          4
    ## 375               J.J. Barea  DAL       PG     72    185  32         10
    ## 376            Jarrod Uthoff  DAL       PF     81    221  23          0
    ## 377             Nerlens Noel  DAL        C     83    228  22          2
    ## 378         Nicolas Brussino  DAL       SF     79    195  23          0
    ## 379              Salah Mejri  DAL        C     85    245  30          1
    ## 380               Seth Curry  DAL       PG     74    185  26          3
    ## 381          Wesley Matthews  DAL       SG     77    220  30          7
    ## 382             Yogi Ferrell  DAL       PG     72    180  23          0
    ## 383         Anthony Tolliver  SAC       PF     80    240  31          8
    ## 384            Arron Afflalo  SAC       SG     77    210  31          9
    ## 385             Ben McLemore  SAC       SG     77    195  23          3
    ## 386              Buddy Hield  SAC       SG     76    214  23          0
    ## 387          Darren Collison  SAC       PG     72    175  29          7
    ## 388           Garrett Temple  SAC       SG     78    195  30          6
    ## 389     Georgios Papagiannis  SAC        C     85    240  19          0
    ## 390             Kosta Koufos  SAC        C     84    265  27          8
    ## 391        Langston Galloway  SAC       PG     74    200  25          2
    ## 392       Malachi Richardson  SAC       SG     78    205  21          0
    ## 393                 Rudy Gay  SAC       SF     80    230  30         10
    ## 394          Skal Labissiere  SAC       PF     83    225  20          0
    ## 395                Ty Lawson  SAC       PG     71    195  29          7
    ## 396             Tyreke Evans  SAC       SF     78    220  27          7
    ## 397      Willie Cauley-Stein  SAC        C     84    240  23          1
    ## 398            Adreian Payne  MIN       PF     82    237  25          2
    ## 399           Andrew Wiggins  MIN       SF     80    199  21          2
    ## 400             Brandon Rush  MIN       SG     78    220  31          8
    ## 401             Cole Aldrich  MIN        C     83    250  28          6
    ## 402             Gorgui Dieng  MIN       PF     83    241  27          3
    ## 403              Jordan Hill  MIN        C     82    235  29          7
    ## 404       Karl-Anthony Towns  MIN        C     84    244  21          1
    ## 405                Kris Dunn  MIN       PG     76    210  22          0
    ## 406          Nemanja Bjelica  MIN       PF     82    240  28          1
    ## 407              Omri Casspi  MIN       SF     81    225  28          7
    ## 408              Ricky Rubio  MIN       PG     76    194  26          5
    ## 409         Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 410               Tyus Jones  MIN       PG     74    195  20          1
    ## 411              Zach LaVine  MIN       SG     77    189  21          2
    ## 412           Brandon Ingram  LAL       SF     81    190  19          0
    ## 413             Corey Brewer  LAL       SF     81    186  30          9
    ## 414         D'Angelo Russell  LAL       PG     77    195  20          1
    ## 415              David Nwaba  LAL       SG     76    209  24          0
    ## 416              Ivica Zubac  LAL        C     85    265  19          0
    ## 417          Jordan Clarkson  LAL       SG     77    194  24          2
    ## 418            Julius Randle  LAL       PF     81    250  22          2
    ## 419          Larry Nance Jr.  LAL       PF     81    230  24          1
    ## 420                Luol Deng  LAL       SF     81    220  31         12
    ## 421        Metta World Peace  LAL       SF     78    260  37         16
    ## 422               Nick Young  LAL       SG     79    210  31          9
    ## 423              Tarik Black  LAL        C     81    250  25          2
    ## 424          Thomas Robinson  LAL       PF     82    237  25          4
    ## 425           Timofey Mozgov  LAL        C     85    275  30          6
    ## 426              Tyler Ennis  LAL       PG     75    194  22          2
    ## 427            Alan Williams  PHO        C     80    260  24          1
    ## 428                 Alex Len  PHO        C     85    260  23          3
    ## 429           Brandon Knight  PHO       SG     75    189  25          5
    ## 430            Derrick Jones  PHO       SF     79    190  19          0
    ## 431             Devin Booker  PHO       SG     78    206  20          1
    ## 432            Dragan Bender  PHO       PF     85    225  19          0
    ## 433           Elijah Millsap  PHO       SG     78    225  29          2
    ## 434             Eric Bledsoe  PHO       PG     73    190  27          6
    ## 435             Jared Dudley  PHO       PF     79    225  31          9
    ## 436          Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437          Marquese Chriss  PHO       PF     82    233  19          0
    ## 438             Ronnie Price  PHO       PG     74    190  33         11
    ## 439              T.J. Warren  PHO       SF     80    230  23          2
    ## 441           Tyson Chandler  PHO        C     85    240  34         15
    ##                                                      college   salary
    ## 1                                      University of Florida 26540100
    ## 2                                                            12000000
    ## 3                              University of Texas at Austin  8269663
    ## 4                                   University of Notre Dame  1450000
    ## 5                                                             1410598
    ## 7                                       Marquette University  6286408
    ## 8                                     University of Kentucky  1825200
    ## 9                                   University of California  4743000
    ## 10                                                            5000000
    ## 11                                Louisiana State University  1223653
    ## 12                                        Gonzaga University  3094014
    ## 13                                 Oklahoma State University  3578880
    ## 14                                  University of Louisville  1906440
    ## 15                              University of North Carolina  8000000
    ## 16                                     University of Arizona  7806971
    ## 17                                           Duke University    18255
    ## 18                University of Illinois at Urbana-Champaign   259626
    ## 19                                     University of Arizona   268029
    ## 20                                                               5145
    ## 21                           Georgia Institute of Technology  9700000
    ## 22                                                           12800000
    ## 23                                       University of Miami  1551659
    ## 25                     University of California, Los Angeles 21165675
    ## 26                                      Creighton University  5239437
    ## 27                                           Duke University 17638063
    ## 28                                                           30963450
    ## 29                                     University of Arizona  2500000
    ## 30                             University of Texas at Austin 15330435
    ## 31                                                            1589640
    ## 32                             University of Texas at Austin  7330000
    ## 33                                        University of Utah  1577280
    ## 34                         University of Southern California 26540100
    ## 35                                    University of Missouri 14200000
    ## 36                                  Wichita State University   543471
    ## 37                                        University of Utah  2703960
    ## 38                                                           14382022
    ## 39                                      Villanova University 12000000
    ## 40                                                            1921320
    ## 41                     University of California, Los Angeles   874636
    ## 42                             University of Texas at Austin  5300000
    ## 43                               New Mexico State University  1196040
    ## 44                                    University of Kentucky  6050000
    ## 45                                                           12250000
    ## 46                                                            3730653
    ## 47                                     University of Florida 22116750
    ## 48                                                            1200000
    ## 49                                       Syracuse University  1191480
    ## 50                                      Villanova University   543471
    ## 51                                                           15944154
    ## 52                                 Colorado State University  5000000
    ## 53                                    University of Kentucky 16957900
    ## 54                                                           12000000
    ## 55                                      University of Kansas  7400000
    ## 56                                     Georgetown University  5893981
    ## 57                                       University of Miami   543471
    ## 58                                                            2870813
    ## 59                                    University of Michigan  3386598
    ## 60                                 Saint Joseph's University  1499760
    ## 61                                                            2708582
    ## 62                                                           23180275
    ## 63                                                            8400000
    ## 64                                                             392478
    ## 65                                   Old Dominion University 15730338
    ## 66                                   University of Minnesota  4000000
    ## 67       Virginia Polytechnic Institute and State University  2500000
    ## 68                                           Duke University  4837500
    ## 69                                       Bucknell University  1015696
    ## 70                                 Louisiana Tech University 20072033
    ## 71                                           Duke University   418228
    ## 72                                                            3850000
    ## 73                                    University of Michigan  2281605
    ## 74                                                            2995421
    ## 75                                     Georgetown University 17100000
    ## 76                                           Duke University  5374320
    ## 77                                     University of Arizona  1551659
    ## 78                              University of North Carolina 12517606
    ## 79                                      Texas A&M University 15200000
    ## 80                                    University of Virginia   925000
    ## 81                        Saint Mary's College of California  9607500
    ## 82                                   Kansas State University  1403611
    ## 83                                                           10500000
    ## 84                           University of Nevada, Las Vegas  1811040
    ## 85                                  University of Washington  6348759
    ## 86                                                            2568600
    ## 87                                  University of New Mexico  2368327
    ## 88                                      University of Oregon  2700000
    ## 89                                                           10230179
    ## 90                                                            4583450
    ## 91                                     Iowa State University   650000
    ## 92                                    Wake Forest University  8800000
    ## 93                                      University of Oregon  1052342
    ## 94                                                            1800000
    ## 95                                  University of Cincinnati  4000000
    ## 96                                         Temple University  4000000
    ## 97                                                           10770000
    ## 98                             University of Texas at Austin  2463840
    ## 99                       California State University, Fresno 18314532
    ## 100                                      Syracuse University  1052342
    ## 101                          Georgia Institute of Technology 14153652
    ## 102                          Georgia Institute of Technology  3488000
    ## 103                                   University of Arkansas  1453680
    ## 104                                  Murray State University  2112480
    ## 105                                                            874636
    ## 106                                Michigan State University  2092200
    ## 107                                     Marquette University 23200000
    ## 108                                  Murray State University  1015696
    ## 109                                 University of Notre Dame  1643040
    ## 110                                     Marquette University 17552209
    ## 111                                                           1709720
    ## 112                                      Syracuse University  3183526
    ## 113                                                           5782450
    ## 114                                                            750000
    ## 115                                   University of Kentucky 14000000
    ## 116                                      Stanford University 13219250
    ## 117                                      Syracuse University  2898000
    ## 118                                                          15890000
    ## 119                                      Marshall University 22116750
    ## 120                                   Wake Forest University  4000000
    ## 121                                          Duke University  5782450
    ## 122                                  University of Tennessee   874636
    ## 123                                          Duke University  2593440
    ## 124                               University of Nevada, Reno  1227000
    ## 125                                 Florida State University   210995
    ## 126                                  Kansas State University   543471
    ## 127                      California State University, Fresno  5628000
    ## 128                                    University of Florida  4000000
    ## 129                             University of North Carolina  6000000
    ## 130                                   Saint Louis University  1015696
    ## 131                                University of Connecticut 22116750
    ## 132                              Washington State University  6500000
    ## 133                                                           1551659
    ## 134                                                           7000000
    ## 135                                     Villanova University   874060
    ## 136                                     Marquette University  1704120
    ## 137                                   Wake Forest University  6000000
    ## 138                                  University of Wisconsin 10991957
    ## 139                                    University of Georgia  3678319
    ## 140                                     University of Kansas  4625000
    ## 141                                      Syracuse University   650000
    ## 142                             University of North Carolina  2255644
    ## 143                                           Boston College 14956522
    ## 144                                    University of Arizona  2969880
    ## 145                                  University of Tennessee 17200000
    ## 146                                     University of Dayton  1050961
    ## 147                         Virginia Commonwealth University   102898
    ## 148                          University of Nevada, Las Vegas   874636
    ## 149                                       Indiana University  5318313
    ## 150                                  University of Wisconsin  2730000
    ## 151                                University of Connecticut  6511628
    ## 152                               Louisiana State University   161483
    ## 153                                University of Connecticut 12000000
    ## 154                                                           6333333
    ## 155                             University of North Carolina 12250000
    ## 156                                   University of Kentucky 13000000
    ## 157                                          Duke University 12500000
    ## 158                                                          20869566
    ## 159                               University of Nevada, Reno  6000000
    ## 160                         Virginia Commonwealth University   543471
    ## 161                                      Syracuse University 24559380
    ## 162                                      Stanford University   143860
    ## 163                              Western Kentucky University 11242000
    ## 164                                    University of Memphis 21323250
    ## 165                                    University of Florida 17000000
    ## 166                                 University of Washington  1015696
    ## 167                                                           4317720
    ## 168                                 Norfolk State University  3900000
    ## 169                                          Duke University  6191000
    ## 170                                          Duke University   543471
    ## 171                                          Ohio University   543471
    ## 172                                                           2898000
    ## 173                                 Wichita State University   543471
    ## 174                                                           1410598
    ## 175                                                           1375000
    ## 176                                    University of Arizona  4351320
    ## 177                                                          17000000
    ## 178                                  University of Tennessee  5000000
    ## 179                            University of Texas at Austin  7250000
    ## 180                                                            980431
    ## 181                     University of Louisiana at Lafayette  2613600
    ## 182                                                          17000000
    ## 183                                    Georgetown University 15000000
    ## 184                                   University of Kentucky  6540000
    ## 185                          Georgia Institute of Technology    31969
    ## 186                                                           3909840
    ## 187                        University of Southern California 11750000
    ## 188                             George Washington University    31969
    ## 189                          University of Nevada, Las Vegas   950000
    ## 190                                 University of Washington 10000000
    ## 191                                   University of Kentucky    31969
    ## 192                                                           2318280
    ## 193                                          Duke University  9000000
    ## 194                                          Duke University  4788840
    ## 195                                    University of Arizona  9424084
    ## 196                                     University of Kansas  4826160
    ## 197                                   University of Virginia  1514160
    ## 198                                   University of Michigan  2993040
    ## 199                           Bowling Green State University  1025831
    ## 200                               Tennessee State University  1015696
    ## 201                                                           8000000
    ## 202                     University of Louisiana at Lafayette    89513
    ## 203                                    University of Arizona   874636
    ## 204                                                           8550000
    ## 205                                                           1326960
    ## 206                               St. Bonaventure University  6088993
    ## 207                                   University of Kentucky   119494
    ## 208                                      Stanford University 21165675
    ## 209                                   University of Michigan  1562280
    ## 210                                    Seton Hall University  1074145
    ## 211                                       Harvard University 11483254
    ## 212                                   University of Virginia   980431
    ## 213                               Louisiana State University  3000000
    ## 214                                       Clemson University  3333333
    ## 215                                        Baylor University  1790902
    ## 216                                     Villanova University  2500000
    ## 217                                    University of Arizona  1395600
    ## 218                                 University of Cincinnati   980431
    ## 219                                   University of Colorado   726672
    ## 220                                       Clemson University  9250000
    ## 221                                    University of Arizona 11131368
    ## 222                                    Vanderbilt University  1171560
    ## 223                                        Xavier University  1551659
    ## 224                                Michigan State University 15330435
    ## 225                                       Belmont University  1015696
    ## 226                             University of North Carolina   980431
    ## 227                               University of Nevada, Reno  1403611
    ## 228                            University of Texas at Austin 26540100
    ## 229                    University of California, Los Angeles  1182840
    ## 230                              Washington State University 16663575
    ## 231                    University of California, Los Angeles   383351
    ## 232                          University of Nevada, Las Vegas   543471
    ## 233                                                           5782450
    ## 234                                         Davidson College 12112359
    ## 235                                                           2898000
    ## 236                                Michigan State University   543471
    ## 237                             University of North Carolina 10000000
    ## 238                                    University of Florida  1551659
    ## 239                                                            543471
    ## 240                                 University of Washington  1180080
    ## 241                        University of Southern California  2898000
    ## 242                          University of Nevada, Las Vegas   165952
    ## 243                                    University of Houston   874636
    ## 244                               San Diego State University 17638063
    ## 245                    University of California, Los Angeles  1192080
    ## 246                            University of Texas at Austin 20575005
    ## 247                                                          14000000
    ## 248                       Saint Mary's College of California  3578948
    ## 249                                                          15500000
    ## 250                                                          14445313
    ## 251                   California State University, Fullerton   680534
    ## 252                                 University of Louisville   543471
    ## 253                                                           1296240
    ## 254                                       Indiana University 12385364
    ## 255                            University of Texas at Austin   255000
    ## 256                                 Arizona State University 26540100
    ## 257                                       Gonzaga University   543471
    ## 258                                                           7000000
    ## 259                                 University of Louisville  1000000
    ## 260                                   University of Arkansas  6000000
    ## 261                                 University of California 18735364
    ## 262                                  University of Wisconsin  1720560
    ## 263                    University of California, Los Angeles  7806971
    ## 264                                       Indiana University   150000
    ## 265                                Michigan State University  1315448
    ## 266                                          Duke University 11000000
    ## 267                                   University of Oklahoma 20140838
    ## 268                               Louisiana State University  1551659
    ## 269                             University of North Carolina  1273920
    ## 270                                   Wake Forest University 22868828
    ## 271                                     Texas A&M University 21165675
    ## 272                                   University of Maryland   543471
    ## 273                                          Duke University  7377500
    ## 274                                   University of Michigan 13253012
    ## 275                    University of California, Los Angeles  2203000
    ## 276                                    University of Florida  1403611
    ## 277                                     University of Kansas  3500000
    ## 278                             University of North Carolina  1551659
    ## 279                                      Syracuse University  5628000
    ## 280                                   University of Colorado 10154495
    ## 281                                                           7000000
    ## 282                                                           3940320
    ## 283                          Georgia Institute of Technology 11050000
    ## 284        Indiana University-Purdue University Indianapolis  8000000
    ## 285                                        Butler University 16073140
    ## 286                                     University of Kansas  1015696
    ## 287                                                           2250000
    ## 288                                   University of Arkansas 11000000
    ## 289                                   Weber State University   600000
    ## 290                                                            937800
    ## 291                                          Duke University  1406520
    ## 292                                                           2121288
    ## 293                                        Butler University  2433334
    ## 294                                   University of Kentucky  2340600
    ## 295                                                           5994764
    ## 296                                   University of Colorado  2183072
    ## 297                                       Gonzaga University  2440200
    ## 298                                     Creighton University  2483040
    ## 299                                                          17145838
    ## 300                                      Syracuse University   980431
    ## 301                                      Stanford University  1191480
    ## 302                                          Duke University  4837500
    ## 303                                     University of Kansas  3750000
    ## 304                               Cleveland State University   247991
    ## 305                    University of California, Los Angeles 26540100
    ## 306                                        Xavier University   543471
    ## 307                                 University of Pittsburgh  3140517
    ## 308                        University of Southern California  8950000
    ## 309                                       Indiana University  6552960
    ## 310                                   University of Kentucky   945000
    ## 311                             University of North Carolina  5700000
    ## 312                                    University of Florida 22116750
    ## 313                                Michigan State University  1369229
    ## 314                  California State University, Long Beach  2898000
    ## 315                                    University of Alabama   980431
    ## 316                               Louisiana State University  1286160
    ## 317                                                          21165675
    ## 318                                    Ohio State University 26540100
    ## 319                                Oklahoma State University  5505618
    ## 320                         Virginia Commonwealth University  3332940
    ## 321                             University of North Carolina  4264057
    ## 322                                    Vanderbilt University  1793760
    ## 323                                     University of Kansas    83119
    ## 324                                Michigan State University 10361445
    ## 325                                   Wake Forest University  7680965
    ## 326                                 University of California 18500000
    ## 327                                        Lehigh University  3219579
    ## 328                                   Weber State University 24328425
    ## 329                             University of North Carolina  6666667
    ## 330                                    Ohio State University 16393443
    ## 331                                   University of Maryland   600000
    ## 332                                                           1921320
    ## 333                                    St. John's University  8988764
    ## 334               University of Illinois at Urbana-Champaign  9213484
    ## 335                                       Indiana University  2751360
    ## 336                                 University of Notre Dame   874636
    ## 337                                University of Connecticut  1350120
    ## 338                               Louisiana State University   543471
    ## 339                                                          15050000
    ## 340                                     University of Kansas  8070175
    ## 341                                                           3241800
    ## 342                                Michigan State University  1655880
    ## 343                                   University of Kentucky  3210840
    ## 344                                Saint Joseph's University  4540525
    ## 345                                                           1987440
    ## 346                                Morehead State University 12078652
    ## 347                                 Florida State University  1627320
    ## 348                                          Duke University  2328530
    ## 349                                    University of Florida  3500000
    ## 350                                                           1358500
    ## 351                                    Georgetown University  5000000
    ## 352                                    University of Memphis  3533333
    ## 353                                        DePaul University 11200000
    ## 354                                                           4600000
    ## 355                                   University of Kentucky 22116750
    ## 356                                                             20580
    ## 357                                     University of Kansas   543471
    ## 358                                     Villanova University  2978250
    ## 359                                   University of Kentucky 16957900
    ## 360                                                            576724
    ## 361                                        Purdue University  8081363
    ## 362                                        Xavier University   173094
    ## 363                    University of California, Los Angeles 11286518
    ## 364                                                           9904494
    ## 365                                          Duke University    63938
    ## 366                                    University of Arizona 11241218
    ## 367                            Pennsylvania State University  2090000
    ## 368                                        Purdue University   650000
    ## 369                                   University of Kentucky  1015696
    ## 370                                  University of Wisconsin  4228000
    ## 371                                                          25000000
    ## 372                                    University of Florida   543471
    ## 373                                      Stanford University  8375000
    ## 374                             University of North Carolina 22116750
    ## 375                                  Northeastern University  4096950
    ## 376                                       University of Iowa    63938
    ## 377                                   University of Kentucky  4384490
    ## 378                                                            543471
    ## 379                                                            874636
    ## 380                                          Duke University  2898000
    ## 381                                     Marquette University 17100000
    ## 382                                       Indiana University   207798
    ## 383                                     Creighton University  8000000
    ## 384                    University of California, Los Angeles 12500000
    ## 385                                     University of Kansas  4008882
    ## 386                                   University of Oklahoma  3517200
    ## 387                    University of California, Los Angeles  5229454
    ## 388                               Louisiana State University  8000000
    ## 389                                                           2202240
    ## 390                                    Ohio State University  8046500
    ## 391                                Saint Joseph's University  5200000
    ## 392                                      Syracuse University  1439880
    ## 393                                University of Connecticut 13333333
    ## 394                                   University of Kentucky  1188840
    ## 395                             University of North Carolina  1315448
    ## 396                                    University of Memphis 10661286
    ## 397                                   University of Kentucky  3551160
    ## 398                                Michigan State University  2022240
    ## 399                                     University of Kansas  6006600
    ## 400                                     University of Kansas  3500000
    ## 401                                     University of Kansas  7643979
    ## 402                                 University of Louisville  2348783
    ## 403                                    University of Arizona  3911380
    ## 404                                   University of Kentucky  5960160
    ## 405                                       Providence College  3872520
    ## 406                                                           3800000
    ## 407                                                            138414
    ## 408                                                          13550000
    ## 409                    University of California, Los Angeles  3046299
    ## 410                                          Duke University  1339680
    ## 411                    University of California, Los Angeles  2240880
    ## 412                                          Duke University  5281680
    ## 413                                    University of Florida  7600000
    ## 414                                    Ohio State University  5332800
    ## 415 California Polytechnic State University, San Luis Obispo    73528
    ## 416                                                           1034956
    ## 417                                   University of Missouri 12500000
    ## 418                                   University of Kentucky  3267120
    ## 419                                    University of Wyoming  1207680
    ## 420                                          Duke University 18000000
    ## 421                                    St. John's University  1551659
    ## 422                        University of Southern California  5443918
    ## 423                                     University of Kansas  6191000
    ## 424                                     University of Kansas  1050961
    ## 425                                                          16000000
    ## 426                                      Syracuse University  1733880
    ## 427                  University of California, Santa Barbara   874636
    ## 428                                   University of Maryland  4823621
    ## 429                                   University of Kentucky 12606250
    ## 430                          University of Nevada, Las Vegas   543471
    ## 431                                   University of Kentucky  2223600
    ## 432                                                           4276320
    ## 433                      University of Alabama at Birmingham    23069
    ## 434                                   University of Kentucky 14000000
    ## 435                                           Boston College 10470000
    ## 436                                                           4000000
    ## 437                                 University of Washington  2941440
    ## 438                                Utah Valley State College   282595
    ## 439                          North Carolina State University  2128920
    ## 441                                                          12415000
    ##     games minutes points points3 points2 points1
    ## 1      68    2193    952      86     293     108
    ## 2      80    1608    520      27     186      67
    ## 3      55    1835    894     108     251      68
    ## 4       5      17     10       1       2       3
    ## 5      47     538    262      39      56      33
    ## 7      72    2335    999     157     176     176
    ## 8      29     220     68      12      13       6
    ## 9      78    1341    515      46     146      85
    ## 10     78    1232    299      45      69      26
    ## 11     25     141     38       0      15       8
    ## 12     75    1538    678      68     192      90
    ## 13     79    2399    835      94     175     203
    ## 14     74    1263    410      57      94      51
    ## 15     51     525    178       0      78      22
    ## 16     74    1398    676     137     101      63
    ## 17      1      12      9       0       3       3
    ## 18     24     486    179      22      46      21
    ## 19     25     427    156      21      33      27
    ## 20      1      24      6       0       3       0
    ## 21     76    1937    567      94     107      71
    ## 22     41    1187    351      95      28      10
    ## 23     48     381    132      31      13      13
    ## 25     60    1885   1142     145     225     257
    ## 26     35     859    373      97      34      14
    ## 27     72    2525   1816     177     494     297
    ## 28     74    2794   1954     124     612     358
    ## 29     79    1614    448      62      91      80
    ## 30     78    2336    630       0     262     106
    ## 31      9      40     14       2       4       0
    ## 32     80    2003    740      48     251      94
    ## 33     27     446    150      10      39      42
    ## 34     74    2620   2020      33     688     545
    ## 35     72    1882    638     109     111      89
    ## 36     37     294    107      11      28      18
    ## 37     54     626    165       0      67      31
    ## 38     80    2066    959       1     390     176
    ## 39     60    2244   1344     193     233     299
    ## 40     57    1088    253       3     100      44
    ## 41     76    1368    636      56     171     126
    ## 42     24     609    139      24      28      11
    ## 43     55     859    229       1     102      22
    ## 44     65    1599    445      94      60      43
    ## 45     23     712    327      41      87      30
    ## 46     26     601    330      45      62      71
    ## 47     77    2684   1779     223     414     282
    ## 48     23     374     81      11      18      12
    ## 49      2       8      1       0       0       1
    ## 50     19      75     24       0      12       0
    ## 51     31     555    173       0      65      43
    ## 52     74    1068    420      37     137      35
    ## 53     78    2836   1805      89     558     422
    ## 54     82    2556    883       0     390     103
    ## 55     76    2374   1063      71     335     180
    ## 56     80    2605   1075     148     266      99
    ## 57     30     287     90       7      23      23
    ## 58     57     719    154       9      52      23
    ## 59     57     703    285      31      85      22
    ## 60     38     371    101       1      46       6
    ## 61     79    2485   1414     100     448     218
    ## 62     74    2199   1002       0     388     226
    ## 63     26     633    270      32      61      52
    ## 64     17     247     61       8      15       7
    ## 65     73    1963    801      92     203     119
    ## 66     56     689    257      19      68      64
    ## 67     73    1248    391      26     119      75
    ## 68     30     475    169      33      24      22
    ## 69     70    1237    435      46     124      49
    ## 70     69    2343   1246      75     355     311
    ## 71     16     110     25       4       4       5
    ## 72     62    1596    444      41     133      55
    ## 73     79    2154   1143     149     266     164
    ## 74     80    2845   1832      49     607     471
    ## 75     81    1823    951       0     387     177
    ## 76     51    1728   1025      65     334     162
    ## 77     74    1365    307      73      32      24
    ## 78     58    1123    392       0     159      74
    ## 79     29     889    426      45     105      81
    ## 80     75    1982    767      78     212     109
    ## 81     76    1986    577      79     129      82
    ## 82     56     935    528      18     198      78
    ## 83     70    1133    451     104      52      35
    ## 84     41     458    142      26      31       2
    ## 85     19     171     83       9      21      14
    ## 86     57     562    226      28      55      32
    ## 87     80    2336    683     144     102      47
    ## 88     65     894    322      48      73      32
    ## 89     66     931    535       0     235      65
    ## 90     76    1776    815     169     112      84
    ## 91     23      93     21       1       8       2
    ## 92     82    2657   1254      90     312     360
    ## 93     33     135     68       5      21      11
    ## 94     49     559    232       0     109      14
    ## 95      6     132     43       5      13       2
    ## 96     61     871    177       0      77      23
    ## 97     74    1998    630      43     204      93
    ## 98     81    2541   1173      40     404     245
    ## 99     75    2689   1775     195     427     336
    ## 100    29     219     59       0      19      21
    ## 101    74    2237    814      45     317      45
    ## 102     9      87     41       6       6      11
    ## 103    64    1000    437      32     151      39
    ## 104    11     142     54      11      10       1
    ## 105    66    1040    316       0     128      60
    ## 106    57     976    291      73      29      14
    ## 107    60    1792   1096      45     369     223
    ## 108    39     592    181      25      38      30
    ## 109    63    1028    370      49      79      65
    ## 110    76    2809   1816      91     479     585
    ## 111    20     241     89       6      31       9
    ## 112    45     846    297      15      97      58
    ## 113    70    1679    744     129     129      99
    ## 114    44     843    240      33      55      31
    ## 115    69    1843    538      50     179      30
    ## 116    81    2271    839       0     382      75
    ## 117    46    1384    729      85     196      82
    ## 118    73    2459   1483     117     417     298
    ## 119    77    2513   1309       0     542     225
    ## 120    76    2085    975      87     281     152
    ## 121    22     381    107      13      31       6
    ## 122    53    1614    539      75     127      60
    ## 123    18     625    196       7      73      29
    ## 124    68    1065    324      87      26      11
    ## 125    35     471     98      12      21      20
    ## 126    78    1966    497      73     117      44
    ## 127    73    2178   1002      93     264     195
    ## 128    17     130     31       0      11       9
    ## 129    62    1500    648     149      82      37
    ## 130    71    1031    374       1     161      49
    ## 131    81    2409   1105       2     481     137
    ## 132    75    1163    365       0     143      79
    ## 133    39     560    227      11      81      32
    ## 134    35     293    191       0      72      47
    ## 135    39     381    127      12      35      21
    ## 136    19     146     60      10      13       4
    ## 137    81    1955    758      28     301      72
    ## 138    75    1944    767      49     261      98
    ## 139    76    2529   1047     153     217     154
    ## 140    79    2565   1105     118     303     145
    ## 141     9      32      4       0       1       2
    ## 142    31     467    141      28      26       5
    ## 143    52    1424    752      66     218     118
    ## 144    77    1371    339      45      84      36
    ## 145    82    2567   1321     109     402     190
    ## 146    41     416    142      17      29      33
    ## 147    13     159     50       1      19       9
    ## 148    13     107     35       0      12      11
    ## 149    62    1725    639       0     253     133
    ## 150    75    1954    874     116     204     118
    ## 151    62    1143    603      41     185     110
    ## 152     4      34     18       1       7       1
    ## 153    79    2739   1830     240     403     304
    ## 154    74    1778    780     102     162     150
    ## 155    76    2295    849     124     173     131
    ## 156    81    2349    743       1     294     152
    ## 157    13     174     31       0      14       3
    ## 158    77    2617   1164     135     258     243
    ## 159    50     811    312      21      79      91
    ## 160    27     189     57       9      10      10
    ## 161    74    2538   1659     151     451     304
    ## 162    18     225     95      10      18      29
    ## 163    77    2459    835     108     213      85
    ## 164    64    2082   1154      13     447     221
    ## 165    46    1015    232       0      99      34
    ## 166    82    1639    629      97     136      66
    ## 167    66    2164   1196     112     331     198
    ## 168    79    1229    496       2     213      64
    ## 169    46     968    275      38      59      43
    ## 170    21     170     40       0      16       8
    ## 171    32     331     98       1      38      19
    ## 172    68    1016    425      54     104      55
    ## 173    52     857    215      23      59      28
    ## 174    42     408    124      23      19      17
    ## 175    72    1324    587       4     242      91
    ## 176    80    2298   1019      77     316     156
    ## 177    81    1793    483       0     179     125
    ## 178    62    1012    281      32      64      57
    ## 179    78    1538    616      95     100     131
    ## 180    45     314     82      20      11       0
    ## 181    82    2412   1046      40     390     146
    ## 182    68    2234   1167     128     280     223
    ## 183    69    1534    638      53     167     145
    ## 184    36     738    327      56      47      65
    ## 185     5      48     14       1       1       9
    ## 186    65     960    317      43      74      40
    ## 187    75    2163   1096      23     460     107
    ## 188     5      43      0       0       0       0
    ## 189    19     108     23       0      10       3
    ## 190    24     748    299      46      69      23
    ## 191     6     157     64       6      19       8
    ## 192    81    2129   1040     106     275     172
    ## 193    72    1667    662      61     173     133
    ## 194    50    1134    590       0     242     106
    ## 195     3      71     33       2       9       9
    ## 196    31     786    627      36     164     191
    ## 197    24     518    203      21      54      32
    ## 198    80    2188    756     132     119     122
    ## 199    57    1193    559      27     203      72
    ## 200    67    2119    864     137     155     143
    ## 201    68    1518    530      92     118      18
    ## 202    18     234    148       7      54      19
    ## 203    81    2133    556      11     225      73
    ## 204     8      76     39       2      12       9
    ## 205    69    1190    445      50      95     105
    ## 206    10     111     30       2      11       2
    ## 207    12     184     95       4      30      23
    ## 208    75    2222   1539     134     421     295
    ## 209    57    1237    468      59     112      67
    ## 210    73    1643    543      44     160      91
    ## 211    36     883    523      58     117     115
    ## 212    52    1138    428      85      69      35
    ## 213    64    1177    442      55     119      39
    ## 214    20     293    126      11      35      23
    ## 215    32     510    209      36      29      43
    ## 216    69    1284    357      67      51      54
    ## 217    78    1761    675      15     220     190
    ## 218    70    1754    919     105     200     204
    ## 219    59    1334    432      38      96     126
    ## 220    71    1754    709      25     280      74
    ## 221    76    1998    574      64     155      72
    ## 222    10      85     19       0       8       3
    ## 223    68     854    316       3     132      43
    ## 224    76    2471    776      81     191     151
    ## 225    77    1137    527      61     150      44
    ## 226    52     457    147       2      60      21
    ## 227    77     739    472       0     208      56
    ## 228    62    2070   1555     117     434     336
    ## 229    53     447    135       2      54      21
    ## 230    78    2649   1742     268     376     186
    ## 231    20     410    114      18      20      20
    ## 232    71    1074    282      41      65      29
    ## 233    76    1345    389       1     172      42
    ## 234    79    2638   1999     324     351     325
    ## 235    70    1268    426       0     164      98
    ## 236    36     285     94      17      19       5
    ## 237    68    1807    497     118      58      27
    ## 238    79    1477    576       0     248      80
    ## 239    67     808    303      69      34      28
    ## 240    38     322    130       9      41      21
    ## 241    76    1330    387       0     161      65
    ## 242    19     122     25       0      10       5
    ## 243    78    1392    483      30     147      99
    ## 244    74    2474   1888     147     489     469
    ## 245    72    1020    246      15      78      45
    ## 246    72    2335   1243      23     477     220
    ## 247    69    1291    517      89      82      86
    ## 248    80    1754    759     147     126      66
    ## 249    64    1627    792      56     247     130
    ## 250    63    1587    638      23     242      85
    ## 251    25     123     62      14       9       2
    ## 252     5      52     14       0       5       4
    ## 253    65    1551    818       0     362      94
    ## 254    75    2323   1217     246     166     147
    ## 255     4      52      3       0       1       1
    ## 256    81    2947   2356     262     412     746
    ## 257    14      44     13       4       0       1
    ## 258    23     591    343      41      61      98
    ## 259    58    1064    527       1     224      76
    ## 260    67    2058    639     110     118      73
    ## 261    72    2116    979     204     119     129
    ## 262    77    1419    504      60     143      38
    ## 263    80    2773    936     191     135      93
    ## 264     6     139     58       8      14       6
    ## 265    30     308     86      14      16      12
    ## 266    74    2054    889     111     212     132
    ## 267    61    2076   1316      38     441     320
    ## 268    52     577    292       1     106      77
    ## 269     3       9      4       0       2       0
    ## 270    61    1921   1104     124     250     232
    ## 271    81    2570   1029       0     412     205
    ## 272     7      24     10       0       3       4
    ## 273    78    2198   1173     201     195     180
    ## 274    82    2157   1008     116     243     174
    ## 275    80    1787    484      43     148      59
    ## 276    82    1286    711     103     141     120
    ## 277    25     277     81      15      13      10
    ## 278    80    1700    538      46     175      50
    ## 279    68     810    186      29      44      11
    ## 280    42     653    283      25      74      60
    ## 281    73    1283    338      20     126      26
    ## 282    66    1228    412      44     111      58
    ## 283    50    1186    476       3     200      67
    ## 284    49    1544    829      94     195     157
    ## 285    73    2516   1601     149     396     362
    ## 286    51     432    146       0      55      36
    ## 287    82    1972    581     123      81      50
    ## 288    78    1843    715     106     167      63
    ## 289    12      53     22       1       8       3
    ## 290    40     346    100      10      31       8
    ## 291    59    1593    748     114     158      90
    ## 292    81    2744   1137       0     413     311
    ## 293    55    1205    430      37     133      53
    ## 294    71    1158    440      65      94      57
    ## 295    68    1055    406      94      40      44
    ## 296    79    2376    522      45     170      47
    ## 297    81    1632    479      51     141      44
    ## 298    22     430    145      21      35      12
    ## 299    72    1533   1033       5     397     224
    ## 300    78    1490    421      43     103      86
    ## 301     2      31     14       2       4       0
    ## 302    32     385     88       7      27      13
    ## 303    20     128     33       0      14       5
    ## 304    13     125     43       3      13       8
    ## 305    81    2802   2558     200     624     710
    ## 306    64     973    183      12      65      17
    ## 307    80    2389    905       0     374     157
    ## 308    23     487    207       1      88      28
    ## 309    67    2222   1067     127     285     116
    ## 310    72    1474    425      43      74     148
    ## 311    28     447    189       0      83      23
    ## 312    34     675    210      25      50      35
    ## 313    36     238     58       0      24      10
    ## 314    64    1501    429      51      95      86
    ## 315    77    2101    689      55     195     134
    ## 316    42     558    165       9      49      40
    ## 317    74    2531   1446     104     428     278
    ## 318    69    2292   1415     171     293     316
    ## 319    71    1914    643      15     259      80
    ## 320    67    1183    551     138      47      43
    ## 321    73    1799    586     112      81      88
    ## 322    33     405    106       3      33      31
    ## 323    11     189     55       3      17      12
    ## 324    73    1786   1028      21     412     141
    ## 325    61    1773    532      70     113      96
    ## 326    79    2254    845     134     169     105
    ## 327    80    2796   1837     185     507     268
    ## 328    75    2694   2024     214     447     488
    ## 329    46     789    200       0      75      50
    ## 330    65    1658    586      31     204      85
    ## 331    35     249     78      13      13      13
    ## 332    20     584    304       0     120      64
    ## 333    77    2223    773      68     246      77
    ## 334    74    1222    401      74      72      35
    ## 335    74    1265    327       7     123      60
    ## 336    39     316     98      17      20       7
    ## 337    53     512    218      34      39      38
    ## 338    16      80     31       5       8       0
    ## 339    63    2134   1145     126     209     349
    ## 340    41     639    262      53      42      19
    ## 341    55    1406    603      56     152     131
    ## 342    57    1782    851     107     213     104
    ## 343    82    1764    811     115     180     106
    ## 344    75    2045    687     106     162      45
    ## 345    62     842    305      46      55      57
    ## 346    61    1296    587       0     228     131
    ## 347    22     165     83       9      24       8
    ## 348    27     632    245       0      99      47
    ## 349    20     151     28       8       1       2
    ## 350    73    2038   1221      45     449     188
    ## 351     6      11      4       0       2       0
    ## 352    60    1705    820      87     208     143
    ## 353    71    2197   1117     110     323     141
    ## 354    39     584    207       0      89      29
    ## 355    75    2708   2099      40     730     519
    ## 356     2      41     11       1       4       0
    ## 357    17     199     87       0      36      15
    ## 358    66    1649    435      71     103      16
    ## 359    17     574    414      36     106      94
    ## 360    34     479    150      11      46      25
    ## 361    73    1820    700      77     206      57
    ## 362    19     442    267      37      68      20
    ## 363    67    2190   1029     100     305     119
    ## 364    31     482     85       0      31      23
    ## 365     9     111     52       6      16       2
    ## 366    80    2374    563      94      89     103
    ## 367    65    1525    464      40     123      98
    ## 368    22     163     48       5      12       9
    ## 369     1      25      8       0       3       2
    ## 370    65    1087    437      58      78     107
    ## 371    54    1424    769      79     217      98
    ## 372    81    1642    350      56      68      46
    ## 373    77    1333    516      21     173     107
    ## 374    79    2803   1518      78     521     242
    ## 375    35     771    381      53      89      44
    ## 376     9     115     40       3      13       5
    ## 377    22     483    188       0      77      34
    ## 378    54     521    150      29      23      17
    ## 379    73     905    213       1      87      36
    ## 380    70    2029    898     137     201      85
    ## 381    73    2495    986     174     159     146
    ## 382    36    1046    408      60      82      64
    ## 383    65    1477    461      90      65      61
    ## 384    61    1580    515      62     123      83
    ## 385    61    1176    495      65     115      70
    ## 386    25     727    378      59      83      35
    ## 387    68    2063    900      73     267     147
    ## 388    65    1728    506      82     101      58
    ## 389    22     355    124       0      56      12
    ## 390    71    1419    470       0     216      38
    ## 391    19     375    114      19      23      11
    ## 392    22     198     79       8      20      15
    ## 393    30    1013    562      42     159     118
    ## 394    33     612    289       3     114      52
    ## 395    69    1732    681      34     203     173
    ## 396    14     314    163      21      38      24
    ## 397    75    1421    611       0     255     101
    ## 398    18     135     63       3      20      14
    ## 399    82    3048   1933     103     606     412
    ## 400    47    1030    197      44      26      13
    ## 401    62     531    105       0      45      15
    ## 402    82    2653    816      16     316     136
    ## 403     7      47     12       0       5       2
    ## 404    82    3030   2061     101     701     356
    ## 405    78    1333    293      21      97      36
    ## 406    65    1190    403      56      95      45
    ## 407    13     222     45       2      17       5
    ## 408    75    2469    836      60     201     254
    ## 409    78    1516    772      49     239     147
    ## 410    60     774    209      26      49      33
    ## 411    47    1749    889     120     206     117
    ## 412    79    2279    740      55     221     133
    ## 413    24     358    129       5      48      18
    ## 414    63    1811    984     135     216     147
    ## 415    20     397    120       1      46      25
    ## 416    38     609    284       0     126      32
    ## 417    82    2397   1205     117     360     134
    ## 418    74    2132    975      17     360     204
    ## 419    63    1442    449      10     180      59
    ## 420    56    1486    425      51     113      46
    ## 421    25     160     57       9      10      10
    ## 422    60    1556    791     170     102      77
    ## 423    67    1091    383       1     149      82
    ## 424    48     560    241       0     105      31
    ## 425    54    1104    401       0     169      63
    ## 426    22     392    170      21      44      19
    ## 427    47     708    346       0     138      70
    ## 428    77    1560    613       3     227     150
    ## 429    54    1140    595      45     164     132
    ## 430    32     545    168       3      65      29
    ## 431    78    2730   1726     147     459     367
    ## 432    43     574    146      28      29       4
    ## 433     2      23      3       0       1       1
    ## 434    66    2176   1390     104     345     388
    ## 435    64    1362    434      77      80      43
    ## 436    67     963    419      35     137      40
    ## 437    82    1743    753      72     212     113
    ## 438    14     134     14       3       1       3
    ## 439    66    2048    951      26     377     119
    ## 441    47    1298    397       0     153      91

-   Of those players that are centers (position `C`), display their names and salaries.

``` r
centers <- subset(dat, position == 'C')
centers$team <- NULL
centers$height <- NULL
centers$weight <- NULL
centers$age <- NULL
centers$experience <- NULL
centers$college <- NULL
centers$games <- NULL
centers$minutes <- NULL
centers$points1 <- NULL
centers$points2 <- NULL
centers$points3 <-NULL
centers$points <- NULL
centers
```

    ##                   player position   salary
    ## 1             Al Horford        C 26540100
    ## 12          Kelly Olynyk        C  3094014
    ## 15          Tyler Zeller        C  8000000
    ## 16         Channing Frye        C  7806971
    ## 20           Edy Tavares        C     5145
    ## 30      Tristan Thompson        C 15330435
    ## 37          Jakob Poeltl        C  2703960
    ## 38     Jonas Valanciunas        C 14382022
    ## 40        Lucas Nogueira        C  1921320
    ## 50         Daniel Ochefu        C   543471
    ## 51           Ian Mahinmi        C 15944154
    ## 52           Jason Smith        C  5000000
    ## 54         Marcin Gortat        C 12000000
    ## 62         Dwight Howard        C 23180275
    ## 69          Mike Muscala        C  1015696
    ## 75           Greg Monroe        C 17100000
    ## 78           John Henson        C 12517606
    ## 86            Thon Maker        C  2568600
    ## 89          Al Jefferson        C 10230179
    ## 98          Myles Turner        C  2463840
    ## 105    Cristiano Felicio        C   874636
    ## 111    Joffrey Lauvergne        C  1709720
    ## 116          Robin Lopez        C 13219250
    ## 119     Hassan Whiteside        C 22116750
    ## 128        Udonis Haslem        C  4000000
    ## 130          Willie Reed        C  1015696
    ## 131       Andre Drummond        C 22116750
    ## 132          Aron Baynes        C  6500000
    ## 134     Boban Marjanovic        C  7000000
    ## 150       Frank Kaminsky        C  2730000
    ## 157        Miles Plumlee        C 12500000
    ## 165          Joakim Noah        C 17000000
    ## 168         Kyle O'Quinn        C  3900000
    ## 170     Marshall Plumlee        C   543471
    ## 175    Willy Hernangomez        C  1375000
    ## 177      Bismack Biyombo        C 17000000
    ## 187       Nikola Vucevic        C 11750000
    ## 189    Stephen Zimmerman        C   950000
    ## 194        Jahlil Okafor        C  4788840
    ## 196          Joel Embiid        C  4826160
    ## 199       Richaun Holmes        C  1025831
    ## 202           Shawn Long        C    89513
    ## 204       Tiago Splitter        C  8550000
    ## 208          Brook Lopez        C 21165675
    ## 213      Justin Hamilton        C  3000000
    ## 222         Damian Jones        C  1171560
    ## 223           David West        C  1551659
    ## 227         JaVale McGee        C  1403611
    ## 229         Kevon Looney        C  1182840
    ## 235        Zaza Pachulia        C  2898000
    ## 241       Dewayne Dedmon        C  2898000
    ## 242         Joel Anthony        C   165952
    ## 249            Pau Gasol        C 15500000
    ## 252       Chinanu Onuaku        C   543471
    ## 253         Clint Capela        C  1296240
    ## 259     Montrezl Harrell        C  1000000
    ## 271       DeAndre Jordan        C 21165675
    ## 272        Diamond Stone        C   543471
    ## 276    Marreese Speights        C  1403611
    ## 286          Jeff Withey        C  1015696
    ## 292          Rudy Gobert        C  2121288
    ## 299          Enes Kanter        C 17145838
    ## 307         Steven Adams        C  3140517
    ## 313        Deyonta Davis        C  1369229
    ## 317           Marc Gasol        C 21165675
    ## 332         Jusuf Nurkic        C  1921320
    ## 348        Mason Plumlee        C  2328530
    ## 350         Nikola Jokic        C  1358500
    ## 351          Roy Hibbert        C  5000000
    ## 354        Alexis Ajinca        C  4600000
    ## 355        Anthony Davis        C 22116750
    ## 359     DeMarcus Cousins        C 16957900
    ## 364            Omer Asik        C  9904494
    ## 368         A.J. Hammons        C   650000
    ## 373        Dwight Powell        C  8375000
    ## 377         Nerlens Noel        C  4384490
    ## 379          Salah Mejri        C   874636
    ## 389 Georgios Papagiannis        C  2202240
    ## 390         Kosta Koufos        C  8046500
    ## 397  Willie Cauley-Stein        C  3551160
    ## 401         Cole Aldrich        C  7643979
    ## 403          Jordan Hill        C  3911380
    ## 404   Karl-Anthony Towns        C  5960160
    ## 416          Ivica Zubac        C  1034956
    ## 423          Tarik Black        C  6191000
    ## 425       Timofey Mozgov        C 16000000
    ## 427        Alan Williams        C   874636
    ## 428             Alex Len        C  4823621
    ## 441       Tyson Chandler        C 12415000

-   Create a data frame `durant` with Kevin Durant's information (i.e. row).

``` r
subset(dat, player == "Kevin Durant")
```

    ##           player team position height weight age experience
    ## 228 Kevin Durant  GSW       SF     81    240  28          9
    ##                           college   salary games minutes points points3
    ## 228 University of Texas at Austin 26540100    62    2070   1555     117
    ##     points2 points1
    ## 228     434     336

-   Create a data frame `ucla` with the data of players from college UCLA ("University of California, Los Angeles").

``` r
subset(dat, college == "University of California, Los Angeles")
```

    ##                player team position height weight age experience
    ## 25         Kevin Love  CLE       PF     82    251  28          8
    ## 41      Norman Powell  TOR       SG     76    215  23          1
    ## 229      Kevon Looney  GSW        C     81    220  20          1
    ## 231       Matt Barnes  GSW       SF     79    226  36         13
    ## 245     Kyle Anderson  SAS       SG     81    230  23          2
    ## 263      Trevor Ariza  HOU       SF     80    215  31         12
    ## 275  Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 305 Russell Westbrook  OKC       PG     75    200  28          8
    ## 363      Jrue Holiday  NOP       PG     76    205  26          7
    ## 384     Arron Afflalo  SAC       SG     77    210  31          9
    ## 387   Darren Collison  SAC       PG     72    175  29          7
    ## 409  Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 411       Zach LaVine  MIN       SG     77    189  21          2
    ##                                   college   salary games minutes points
    ## 25  University of California, Los Angeles 21165675    60    1885   1142
    ## 41  University of California, Los Angeles   874636    76    1368    636
    ## 229 University of California, Los Angeles  1182840    53     447    135
    ## 231 University of California, Los Angeles   383351    20     410    114
    ## 245 University of California, Los Angeles  1192080    72    1020    246
    ## 263 University of California, Los Angeles  7806971    80    2773    936
    ## 275 University of California, Los Angeles  2203000    80    1787    484
    ## 305 University of California, Los Angeles 26540100    81    2802   2558
    ## 363 University of California, Los Angeles 11286518    67    2190   1029
    ## 384 University of California, Los Angeles 12500000    61    1580    515
    ## 387 University of California, Los Angeles  5229454    68    2063    900
    ## 409 University of California, Los Angeles  3046299    78    1516    772
    ## 411 University of California, Los Angeles  2240880    47    1749    889
    ##     points3 points2 points1
    ## 25      145     225     257
    ## 41       56     171     126
    ## 229       2      54      21
    ## 231      18      20      20
    ## 245      15      78      45
    ## 263     191     135      93
    ## 275      43     148      59
    ## 305     200     624     710
    ## 363     100     305     119
    ## 384      62     123      83
    ## 387      73     267     147
    ## 409      49     239     147
    ## 411     120     206     117

-   Create a data frame `rookies` with those players with 0 years of experience.

``` r
subset(dat, experience == 0)
```

    ##                      player team position height weight age experience
    ## 4         Demetrius Jackson  BOS       PG     73    201  22          0
    ## 9              Jaylen Brown  BOS       SF     79    225  20          0
    ## 24               Kay Felder  CLE       PG     69    176  21          0
    ## 36            Fred VanVleet  TOR       PG     72    195  22          0
    ## 37             Jakob Poeltl  TOR        C     84    248  21          0
    ## 43            Pascal Siakam  TOR       PF     81    230  22          0
    ## 50            Daniel Ochefu  WAS        C     83    245  23          0
    ## 57        Sheldon McClellan  WAS       SG     77    200  24          0
    ## 58         Tomas Satoransky  WAS       SG     79    210  25          0
    ## 60          DeAndre' Bembry  ATL       SF     78    210  22          0
    ## 67          Malcolm Delaney  ATL       PG     75    190  27          0
    ## 80          Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 86               Thon Maker  MIL        C     85    216  19          0
    ## 91            Georges Niang  IND       PF     80    230  23          0
    ## 106        Denzel Valentine  CHI       SG     78    212  23          0
    ## 114             Paul Zipser  CHI       SF     80    215  22          0
    ## 125             Okaro White  MIA       PF     80    204  24          0
    ## 126         Rodney McGruder  MIA       SG     76    205  25          0
    ## 136          Henry Ellenson  DET       PF     83    245  20          0
    ## 141         Michael Gbinije  DET       SG     79    200  24          0
    ## 160          Treveon Graham  CHO       SG     78    220  23          0
    ## 162          Chasson Randle  NYK       PG     74    185  23          0
    ## 170        Marshall Plumlee  NYK        C     84    250  24          0
    ## 171           Maurice Ndour  NYK       PF     81    200  24          0
    ## 172    Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173               Ron Baker  NYK       SG     76    220  23          0
    ## 175       Willy Hernangomez  NYK        C     83    240  22          0
    ## 185     Marcus Georges-Hunt  ORL       SG     77    216  22          0
    ## 188         Patricio Garino  ORL       SG     78    210  23          0
    ## 189       Stephen Zimmerman  ORL        C     84    240  20          0
    ## 191          Alex Poythress  PHI       PF     79    238  23          0
    ## 192             Dario Saric  PHI       PF     82    223  22          0
    ## 196             Joel Embiid  PHI        C     84    250  22          0
    ## 202              Shawn Long  PHI        C     81    255  24          0
    ## 205 Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 209            Caris LeVert  BRK       SF     79    203  22          0
    ## 210        Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 222            Damian Jones  GSW        C     84    245  21          0
    ## 232           Patrick McCaw  GSW       SG     79    185  21          0
    ## 236             Bryn Forbes  SAS       SG     75    190  23          0
    ## 239           Davis Bertans  SAS       PF     82    210  24          0
    ## 240         Dejounte Murray  SAS       PG     77    170  20          0
    ## 252          Chinanu Onuaku  HOU        C     82    245  20          0
    ## 255           Isaiah Taylor  HOU       PG     75    170  22          0
    ## 257            Kyle Wiltjer  HOU       PF     82    240  24          0
    ## 264           Troy Williams  HOU       SF     79    218  22          0
    ## 269           Brice Johnson  LAC       PF     82    230  22          0
    ## 272           Diamond Stone  LAC        C     83    255  19          0
    ## 289           Joel Bolomboy  UTA       PF     81    235  23          0
    ## 295            Alex Abrines  OKC       SG     78    190  23          0
    ## 297        Domantas Sabonis  OKC       PF     83    240  20          0
    ## 306          Semaj Christon  OKC       PG     75    190  24          0
    ## 310         Andrew Harrison  MEM       PG     78    213  22          0
    ## 313           Deyonta Davis  MEM        C     83    237  20          0
    ## 322            Wade Baldwin  MEM       PG     76    202  20          0
    ## 323            Wayne Selden  MEM       SG     77    230  22          0
    ## 331             Jake Layman  POR       SF     81    210  22          0
    ## 338          Tim Quarterman  POR       SG     78    195  22          0
    ## 343            Jamal Murray  DEN       SG     76    207  19          0
    ## 345        Juan Hernangomez  DEN       PF     81    230  21          0
    ## 347           Malik Beasley  DEN       SG     77    196  20          0
    ## 357           Cheick Diallo  NOP       PF     81    220  20          0
    ## 365              Quinn Cook  NOP       PG     74    184  23          0
    ## 368            A.J. Hammons  DAL        C     84    260  24          0
    ## 372     Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 376           Jarrod Uthoff  DAL       PF     81    221  23          0
    ## 378        Nicolas Brussino  DAL       SF     79    195  23          0
    ## 382            Yogi Ferrell  DAL       PG     72    180  23          0
    ## 386             Buddy Hield  SAC       SG     76    214  23          0
    ## 389    Georgios Papagiannis  SAC        C     85    240  19          0
    ## 392      Malachi Richardson  SAC       SG     78    205  21          0
    ## 394         Skal Labissiere  SAC       PF     83    225  20          0
    ## 405               Kris Dunn  MIN       PG     76    210  22          0
    ## 412          Brandon Ingram  LAL       SF     81    190  19          0
    ## 415             David Nwaba  LAL       SG     76    209  24          0
    ## 416             Ivica Zubac  LAL        C     85    265  19          0
    ## 430           Derrick Jones  PHO       SF     79    190  19          0
    ## 432           Dragan Bender  PHO       PF     85    225  19          0
    ## 437         Marquese Chriss  PHO       PF     82    233  19          0
    ## 440              Tyler Ulis  PHO       PG     70    150  21          0
    ##                                                      college  salary games
    ## 4                                   University of Notre Dame 1450000     5
    ## 9                                   University of California 4743000    78
    ## 24                                        Oakland University  543471    42
    ## 36                                  Wichita State University  543471    37
    ## 37                                        University of Utah 2703960    54
    ## 43                               New Mexico State University 1196040    55
    ## 50                                      Villanova University  543471    19
    ## 57                                       University of Miami  543471    30
    ## 58                                                           2870813    57
    ## 60                                 Saint Joseph's University 1499760    38
    ## 67       Virginia Polytechnic Institute and State University 2500000    73
    ## 80                                    University of Virginia  925000    75
    ## 86                                                           2568600    57
    ## 91                                     Iowa State University  650000    23
    ## 106                                Michigan State University 2092200    57
    ## 114                                                           750000    44
    ## 125                                 Florida State University  210995    35
    ## 126                                  Kansas State University  543471    78
    ## 136                                     Marquette University 1704120    19
    ## 141                                      Syracuse University  650000     9
    ## 160                         Virginia Commonwealth University  543471    27
    ## 162                                      Stanford University  143860    18
    ## 170                                          Duke University  543471    21
    ## 171                                          Ohio University  543471    32
    ## 172                                                          2898000    68
    ## 173                                 Wichita State University  543471    52
    ## 175                                                          1375000    72
    ## 185                          Georgia Institute of Technology   31969     5
    ## 188                             George Washington University   31969     5
    ## 189                          University of Nevada, Las Vegas  950000    19
    ## 191                                   University of Kentucky   31969     6
    ## 192                                                          2318280    81
    ## 196                                     University of Kansas 4826160    31
    ## 202                     University of Louisiana at Lafayette   89513    18
    ## 205                                                          1326960    69
    ## 209                                   University of Michigan 1562280    57
    ## 210                                    Seton Hall University 1074145    73
    ## 222                                    Vanderbilt University 1171560    10
    ## 232                          University of Nevada, Las Vegas  543471    71
    ## 236                                Michigan State University  543471    36
    ## 239                                                           543471    67
    ## 240                                 University of Washington 1180080    38
    ## 252                                 University of Louisville  543471     5
    ## 255                            University of Texas at Austin  255000     4
    ## 257                                       Gonzaga University  543471    14
    ## 264                                       Indiana University  150000     6
    ## 269                             University of North Carolina 1273920     3
    ## 272                                   University of Maryland  543471     7
    ## 289                                   Weber State University  600000    12
    ## 295                                                          5994764    68
    ## 297                                       Gonzaga University 2440200    81
    ## 306                                        Xavier University  543471    64
    ## 310                                   University of Kentucky  945000    72
    ## 313                                Michigan State University 1369229    36
    ## 322                                    Vanderbilt University 1793760    33
    ## 323                                     University of Kansas   83119    11
    ## 331                                   University of Maryland  600000    35
    ## 338                               Louisiana State University  543471    16
    ## 343                                   University of Kentucky 3210840    82
    ## 345                                                          1987440    62
    ## 347                                 Florida State University 1627320    22
    ## 357                                     University of Kansas  543471    17
    ## 365                                          Duke University   63938     9
    ## 368                                        Purdue University  650000    22
    ## 372                                    University of Florida  543471    81
    ## 376                                       University of Iowa   63938     9
    ## 378                                                           543471    54
    ## 382                                       Indiana University  207798    36
    ## 386                                   University of Oklahoma 3517200    25
    ## 389                                                          2202240    22
    ## 392                                      Syracuse University 1439880    22
    ## 394                                   University of Kentucky 1188840    33
    ## 405                                       Providence College 3872520    78
    ## 412                                          Duke University 5281680    79
    ## 415 California Polytechnic State University, San Luis Obispo   73528    20
    ## 416                                                          1034956    38
    ## 430                          University of Nevada, Las Vegas  543471    32
    ## 432                                                          4276320    43
    ## 437                                 University of Washington 2941440    82
    ## 440                                   University of Kentucky  918369    61
    ##     minutes points points3 points2 points1
    ## 4        17     10       1       2       3
    ## 9      1341    515      46     146      85
    ## 24      386    166       7      55      35
    ## 36      294    107      11      28      18
    ## 37      626    165       0      67      31
    ## 43      859    229       1     102      22
    ## 50       75     24       0      12       0
    ## 57      287     90       7      23      23
    ## 58      719    154       9      52      23
    ## 60      371    101       1      46       6
    ## 67     1248    391      26     119      75
    ## 80     1982    767      78     212     109
    ## 86      562    226      28      55      32
    ## 91       93     21       1       8       2
    ## 106     976    291      73      29      14
    ## 114     843    240      33      55      31
    ## 125     471     98      12      21      20
    ## 126    1966    497      73     117      44
    ## 136     146     60      10      13       4
    ## 141      32      4       0       1       2
    ## 160     189     57       9      10      10
    ## 162     225     95      10      18      29
    ## 170     170     40       0      16       8
    ## 171     331     98       1      38      19
    ## 172    1016    425      54     104      55
    ## 173     857    215      23      59      28
    ## 175    1324    587       4     242      91
    ## 185      48     14       1       1       9
    ## 188      43      0       0       0       0
    ## 189     108     23       0      10       3
    ## 191     157     64       6      19       8
    ## 192    2129   1040     106     275     172
    ## 196     786    627      36     164     191
    ## 202     234    148       7      54      19
    ## 205    1190    445      50      95     105
    ## 209    1237    468      59     112      67
    ## 210    1643    543      44     160      91
    ## 222      85     19       0       8       3
    ## 232    1074    282      41      65      29
    ## 236     285     94      17      19       5
    ## 239     808    303      69      34      28
    ## 240     322    130       9      41      21
    ## 252      52     14       0       5       4
    ## 255      52      3       0       1       1
    ## 257      44     13       4       0       1
    ## 264     139     58       8      14       6
    ## 269       9      4       0       2       0
    ## 272      24     10       0       3       4
    ## 289      53     22       1       8       3
    ## 295    1055    406      94      40      44
    ## 297    1632    479      51     141      44
    ## 306     973    183      12      65      17
    ## 310    1474    425      43      74     148
    ## 313     238     58       0      24      10
    ## 322     405    106       3      33      31
    ## 323     189     55       3      17      12
    ## 331     249     78      13      13      13
    ## 338      80     31       5       8       0
    ## 343    1764    811     115     180     106
    ## 345     842    305      46      55      57
    ## 347     165     83       9      24       8
    ## 357     199     87       0      36      15
    ## 365     111     52       6      16       2
    ## 368     163     48       5      12       9
    ## 372    1642    350      56      68      46
    ## 376     115     40       3      13       5
    ## 378     521    150      29      23      17
    ## 382    1046    408      60      82      64
    ## 386     727    378      59      83      35
    ## 389     355    124       0      56      12
    ## 392     198     79       8      20      15
    ## 394     612    289       3     114      52
    ## 405    1333    293      21      97      36
    ## 412    2279    740      55     221     133
    ## 415     397    120       1      46      25
    ## 416     609    284       0     126      32
    ## 430     545    168       3      65      29
    ## 432     574    146      28      29       4
    ## 437    1743    753      72     212     113
    ## 440    1123    444      21     163      55

-   Create a data frame `rookie_centers` with the data of Center rookie players.

``` r
rookies <- subset(dat, experience == 0)
subset(rookies, position == "C")
```

    ##                   player team position height weight age experience
    ## 37          Jakob Poeltl  TOR        C     84    248  21          0
    ## 50         Daniel Ochefu  WAS        C     83    245  23          0
    ## 86            Thon Maker  MIL        C     85    216  19          0
    ## 170     Marshall Plumlee  NYK        C     84    250  24          0
    ## 175    Willy Hernangomez  NYK        C     83    240  22          0
    ## 189    Stephen Zimmerman  ORL        C     84    240  20          0
    ## 196          Joel Embiid  PHI        C     84    250  22          0
    ## 202           Shawn Long  PHI        C     81    255  24          0
    ## 222         Damian Jones  GSW        C     84    245  21          0
    ## 252       Chinanu Onuaku  HOU        C     82    245  20          0
    ## 272        Diamond Stone  LAC        C     83    255  19          0
    ## 313        Deyonta Davis  MEM        C     83    237  20          0
    ## 368         A.J. Hammons  DAL        C     84    260  24          0
    ## 389 Georgios Papagiannis  SAC        C     85    240  19          0
    ## 416          Ivica Zubac  LAL        C     85    265  19          0
    ##                                  college  salary games minutes points
    ## 37                    University of Utah 2703960    54     626    165
    ## 50                  Villanova University  543471    19      75     24
    ## 86                                       2568600    57     562    226
    ## 170                      Duke University  543471    21     170     40
    ## 175                                      1375000    72    1324    587
    ## 189      University of Nevada, Las Vegas  950000    19     108     23
    ## 196                 University of Kansas 4826160    31     786    627
    ## 202 University of Louisiana at Lafayette   89513    18     234    148
    ## 222                Vanderbilt University 1171560    10      85     19
    ## 252             University of Louisville  543471     5      52     14
    ## 272               University of Maryland  543471     7      24     10
    ## 313            Michigan State University 1369229    36     238     58
    ## 368                    Purdue University  650000    22     163     48
    ## 389                                      2202240    22     355    124
    ## 416                                      1034956    38     609    284
    ##     points3 points2 points1
    ## 37        0      67      31
    ## 50        0      12       0
    ## 86       28      55      32
    ## 170       0      16       8
    ## 175       4     242      91
    ## 189       0      10       3
    ## 196      36     164     191
    ## 202       7      54      19
    ## 222       0       8       3
    ## 252       0       5       4
    ## 272       0       3       4
    ## 313       0      24      10
    ## 368       5      12       9
    ## 389       0      56      12
    ## 416       0     126      32

-   Create a data frame `top_players` for players with more than 50 games and more than 100 minutes played.

``` r
exp_players <- subset(dat, games > 50)
top_players <- subset(exp_players, minutes > 100)
top_players
```

    ##                       player team position height weight age experience
    ## 1                 Al Horford  BOS        C     82    245  30          9
    ## 2               Amir Johnson  BOS       PF     81    240  29         11
    ## 3              Avery Bradley  BOS       SG     74    180  26          6
    ## 6              Isaiah Thomas  BOS       PG     69    185  27          5
    ## 7                Jae Crowder  BOS       SF     78    235  26          4
    ## 9               Jaylen Brown  BOS       SF     79    225  20          0
    ## 10             Jonas Jerebko  BOS       PF     82    231  29          6
    ## 12              Kelly Olynyk  BOS        C     84    238  25          3
    ## 13              Marcus Smart  BOS       SG     76    220  22          2
    ## 14              Terry Rozier  BOS       PG     74    190  22          1
    ## 15              Tyler Zeller  BOS        C     84    253  27          4
    ## 16             Channing Frye  CLE        C     83    255  33         10
    ## 21             Iman Shumpert  CLE       SG     77    220  26          5
    ## 25                Kevin Love  CLE       PF     82    251  28          8
    ## 27              Kyrie Irving  CLE       PG     75    193  24          5
    ## 28              LeBron James  CLE       SF     80    250  32         13
    ## 29         Richard Jefferson  CLE       SF     79    233  36         15
    ## 30          Tristan Thompson  CLE        C     81    238  25          5
    ## 32               Cory Joseph  TOR       SG     75    193  25          5
    ## 34             DeMar DeRozan  TOR       SG     79    221  27          7
    ## 35           DeMarre Carroll  TOR       SF     80    215  30          7
    ## 37              Jakob Poeltl  TOR        C     84    248  21          0
    ## 38         Jonas Valanciunas  TOR        C     84    265  24          4
    ## 39                Kyle Lowry  TOR       PG     72    205  30         10
    ## 40            Lucas Nogueira  TOR        C     84    241  24          2
    ## 41             Norman Powell  TOR       SG     76    215  23          1
    ## 43             Pascal Siakam  TOR       PF     81    230  22          0
    ## 44         Patrick Patterson  TOR       PF     81    230  27          6
    ## 47              Bradley Beal  WAS       SG     77    207  23          4
    ## 52               Jason Smith  WAS        C     84    245  30          8
    ## 53                 John Wall  WAS       PG     76    195  26          6
    ## 54             Marcin Gortat  WAS        C     83    240  32          9
    ## 55           Markieff Morris  WAS       PF     82    245  27          5
    ## 56               Otto Porter  WAS       SF     80    198  23          3
    ## 58          Tomas Satoransky  WAS       SG     79    210  25          0
    ## 59                Trey Burke  WAS       PG     73    191  24          3
    ## 61           Dennis Schroder  ATL       PG     73    172  23          3
    ## 62             Dwight Howard  ATL        C     83    265  31         12
    ## 65             Kent Bazemore  ATL       SF     77    201  27          4
    ## 66            Kris Humphries  ATL       PF     81    235  31         12
    ## 67           Malcolm Delaney  ATL       PG     75    190  27          0
    ## 69              Mike Muscala  ATL        C     83    240  25          3
    ## 70              Paul Millsap  ATL       PF     80    246  31         10
    ## 72           Thabo Sefolosha  ATL       SF     79    220  32         10
    ## 73              Tim Hardaway  ATL       SG     78    205  24          3
    ## 74     Giannis Antetokounmpo  MIL       SF     83    222  22          3
    ## 75               Greg Monroe  MIL        C     83    265  26          6
    ## 76             Jabari Parker  MIL       PF     80    250  21          2
    ## 77               Jason Terry  MIL       SG     74    185  39         17
    ## 78               John Henson  MIL        C     83    229  26          4
    ## 80           Malcolm Brogdon  MIL       SG     77    215  24          0
    ## 81       Matthew Dellavedova  MIL       PG     76    198  26          3
    ## 82           Michael Beasley  MIL       PF     81    235  28          8
    ## 83           Mirza Teletovic  MIL       PF     81    242  31          4
    ## 86                Thon Maker  MIL        C     85    216  19          0
    ## 87                Tony Snell  MIL       SG     79    200  25          3
    ## 88              Aaron Brooks  IND       PG     72    161  32          8
    ## 89              Al Jefferson  IND        C     82    289  32         12
    ## 90                C.J. Miles  IND       SF     78    225  29         11
    ## 92               Jeff Teague  IND       PG     74    186  28          7
    ## 96               Lavoy Allen  IND       PF     81    260  27          5
    ## 97               Monta Ellis  IND       SG     75    185  31         11
    ## 98              Myles Turner  IND        C     83    243  20          1
    ## 99               Paul George  IND       SF     81    220  26          6
    ## 101           Thaddeus Young  IND       PF     80    221  28          9
    ## 103             Bobby Portis  CHI       PF     83    230  21          1
    ## 105        Cristiano Felicio  CHI        C     82    275  24          1
    ## 106         Denzel Valentine  CHI       SG     78    212  23          0
    ## 107              Dwyane Wade  CHI       SG     76    220  35         13
    ## 109             Jerian Grant  CHI       PG     76    195  24          1
    ## 110             Jimmy Butler  CHI       SF     79    220  27          5
    ## 113           Nikola Mirotic  CHI       PF     82    220  25          2
    ## 115              Rajon Rondo  CHI       PG     73    186  30         10
    ## 116              Robin Lopez  CHI        C     84    255  28          8
    ## 118             Goran Dragic  MIA       PG     75    190  30          8
    ## 119         Hassan Whiteside  MIA        C     84    265  27          4
    ## 120            James Johnson  MIA       PF     81    250  29          7
    ## 122          Josh Richardson  MIA       SG     78    200  23          1
    ## 124             Luke Babbitt  MIA       SF     81    225  27          6
    ## 126          Rodney McGruder  MIA       SG     76    205  25          0
    ## 127            Tyler Johnson  MIA       PG     76    186  24          2
    ## 129          Wayne Ellington  MIA       SG     76    200  29          7
    ## 130              Willie Reed  MIA        C     82    220  26          1
    ## 131           Andre Drummond  DET        C     83    279  23          4
    ## 132              Aron Baynes  DET        C     82    260  30          4
    ## 137                Ish Smith  DET       PG     72    175  28          6
    ## 138                Jon Leuer  DET       PF     82    228  27          5
    ## 139 Kentavious Caldwell-Pope  DET       SG     77    205  23          3
    ## 140            Marcus Morris  DET       SF     81    235  27          5
    ## 143           Reggie Jackson  DET       PG     75    208  26          5
    ## 144          Stanley Johnson  DET       SF     79    245  20          1
    ## 145            Tobias Harris  DET       PF     81    235  24          5
    ## 149              Cody Zeller  CHO       PF     84    240  24          3
    ## 150           Frank Kaminsky  CHO        C     84    242  23          1
    ## 151              Jeremy Lamb  CHO       SG     77    185  24          4
    ## 153             Kemba Walker  CHO       PG     73    172  26          5
    ## 154          Marco Belinelli  CHO       SG     77    210  30          9
    ## 155          Marvin Williams  CHO       PF     81    237  30         11
    ## 156   Michael Kidd-Gilchrist  CHO       SF     79    232  23          4
    ## 158            Nicolas Batum  CHO       SG     80    200  28          8
    ## 161          Carmelo Anthony  NYK       SF     80    240  32         13
    ## 163             Courtney Lee  NYK       SG     77    200  31          8
    ## 164             Derrick Rose  NYK       PG     75    190  28          7
    ## 166           Justin Holiday  NYK       SG     78    185  27          3
    ## 167       Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 168             Kyle O'Quinn  NYK        C     82    250  26          4
    ## 172     Mindaugas Kuzminskas  NYK       SF     81    215  27          0
    ## 173                Ron Baker  NYK       SG     76    220  23          0
    ## 175        Willy Hernangomez  NYK        C     83    240  22          0
    ## 176             Aaron Gordon  ORL       SF     81    220  21          2
    ## 177          Bismack Biyombo  ORL        C     81    255  24          5
    ## 178              C.J. Watson  ORL       PG     74    175  32          9
    ## 179            D.J. Augustin  ORL       PG     72    183  29          8
    ## 181            Elfrid Payton  ORL       PG     76    185  22          2
    ## 182            Evan Fournier  ORL       SG     79    205  24          4
    ## 183               Jeff Green  ORL       PF     81    235  30          8
    ## 186            Mario Hezonja  ORL       SF     80    215  21          1
    ## 187           Nikola Vucevic  ORL        C     84    260  26          5
    ## 192              Dario Saric  PHI       PF     82    223  22          0
    ## 193         Gerald Henderson  PHI       SG     77    215  29          7
    ## 198             Nik Stauskas  PHI       SG     78    205  23          2
    ## 199           Richaun Holmes  PHI        C     82    245  23          1
    ## 200         Robert Covington  PHI       SF     81    215  26          3
    ## 201         Sergio Rodriguez  PHI       PG     75    176  30          4
    ## 203           T.J. McConnell  PHI       PG     74    200  24          1
    ## 205  Timothe Luwawu-Cabarrot  PHI       SF     78    205  21          0
    ## 208              Brook Lopez  BRK        C     84    275  28          8
    ## 209             Caris LeVert  BRK       SF     79    203  22          0
    ## 210         Isaiah Whitehead  BRK       PG     76    213  21          0
    ## 212               Joe Harris  BRK       SG     78    219  25          2
    ## 213          Justin Hamilton  BRK        C     84    260  26          2
    ## 216               Randy Foye  BRK       SG     76    213  33         10
    ## 217  Rondae Hollis-Jefferson  BRK       SF     79    220  22          1
    ## 218          Sean Kilpatrick  BRK       SG     76    210  27          2
    ## 219        Spencer Dinwiddie  BRK       PG     78    200  23          2
    ## 220            Trevor Booker  BRK       PF     80    228  29          6
    ## 221           Andre Iguodala  GSW       SF     78    215  33         12
    ## 223               David West  GSW        C     81    250  36         13
    ## 224           Draymond Green  GSW       PF     79    230  26          4
    ## 225                Ian Clark  GSW       SG     75    175  25          3
    ## 226     James Michael McAdoo  GSW       PF     81    230  24          2
    ## 227             JaVale McGee  GSW        C     84    270  29          8
    ## 228             Kevin Durant  GSW       SF     81    240  28          9
    ## 229             Kevon Looney  GSW        C     81    220  20          1
    ## 230            Klay Thompson  GSW       SG     79    215  26          5
    ## 232            Patrick McCaw  GSW       SG     79    185  21          0
    ## 233         Shaun Livingston  GSW       PG     79    192  31         11
    ## 234            Stephen Curry  GSW       PG     75    190  28          7
    ## 235            Zaza Pachulia  GSW        C     83    270  32         13
    ## 237              Danny Green  SAS       SG     78    215  29          7
    ## 238                David Lee  SAS       PF     81    245  33         11
    ## 239            Davis Bertans  SAS       PF     82    210  24          0
    ## 241           Dewayne Dedmon  SAS        C     84    245  27          3
    ## 243         Jonathon Simmons  SAS       SG     78    195  27          1
    ## 244            Kawhi Leonard  SAS       SF     79    230  25          5
    ## 245            Kyle Anderson  SAS       SG     81    230  23          2
    ## 246        LaMarcus Aldridge  SAS       PF     83    260  31         10
    ## 247            Manu Ginobili  SAS       SG     78    205  39         14
    ## 248              Patty Mills  SAS       PG     72    185  28          7
    ## 249                Pau Gasol  SAS        C     84    250  36         15
    ## 250              Tony Parker  SAS       PG     74    185  34         15
    ## 253             Clint Capela  HOU        C     82    240  22          2
    ## 254              Eric Gordon  HOU       SG     76    215  28          8
    ## 256             James Harden  HOU       PG     77    220  27          7
    ## 259         Montrezl Harrell  HOU        C     80    240  23          1
    ## 260         Patrick Beverley  HOU       SG     73    185  28          4
    ## 261            Ryan Anderson  HOU       PF     82    240  28          8
    ## 262               Sam Dekker  HOU       SF     81    230  22          1
    ## 263             Trevor Ariza  HOU       SF     80    215  31         12
    ## 266            Austin Rivers  LAC       SG     76    200  24          4
    ## 267            Blake Griffin  LAC       PF     82    251  27          6
    ## 268             Brandon Bass  LAC       PF     80    250  31         11
    ## 270               Chris Paul  LAC       PG     72    175  31         11
    ## 271           DeAndre Jordan  LAC        C     83    265  28          8
    ## 273              J.J. Redick  LAC       SG     76    190  32         10
    ## 274           Jamal Crawford  LAC       SG     77    200  36         16
    ## 275         Luc Mbah a Moute  LAC       SF     80    230  30          8
    ## 276        Marreese Speights  LAC        C     82    255  29          8
    ## 278           Raymond Felton  LAC       PG     73    205  32         11
    ## 279           Wesley Johnson  LAC       SF     79    215  29          6
    ## 281               Boris Diaw  UTA       PF     80    250  34         13
    ## 282               Dante Exum  UTA       PG     78    190  21          1
    ## 285           Gordon Hayward  UTA       SF     80    226  26          6
    ## 286              Jeff Withey  UTA        C     84    231  26          3
    ## 287               Joe Ingles  UTA       SF     80    226  29          2
    ## 288              Joe Johnson  UTA       SF     79    240  35         15
    ## 291              Rodney Hood  UTA       SG     80    206  24          2
    ## 292              Rudy Gobert  UTA        C     85    245  24          3
    ## 293             Shelvin Mack  UTA       PG     75    203  26          5
    ## 294               Trey Lyles  UTA       PF     82    234  21          1
    ## 295             Alex Abrines  OKC       SG     78    190  23          0
    ## 296           Andre Roberson  OKC       SF     79    210  25          3
    ## 297         Domantas Sabonis  OKC       PF     83    240  20          0
    ## 299              Enes Kanter  OKC        C     83    245  24          5
    ## 300             Jerami Grant  OKC       SF     80    210  22          2
    ## 305        Russell Westbrook  OKC       PG     75    200  28          8
    ## 306           Semaj Christon  OKC       PG     75    190  24          0
    ## 307             Steven Adams  OKC        C     84    255  23          3
    ## 309           Victor Oladipo  OKC       SG     76    210  24          3
    ## 310          Andrew Harrison  MEM       PG     78    213  22          0
    ## 314              James Ennis  MEM       SF     79    210  26          2
    ## 315           JaMychal Green  MEM       PF     81    227  26          2
    ## 317               Marc Gasol  MEM        C     85    255  32          8
    ## 318              Mike Conley  MEM       PG     73    175  29          9
    ## 319               Tony Allen  MEM       SG     76    213  35         12
    ## 320             Troy Daniels  MEM       SG     76    205  25          3
    ## 321             Vince Carter  MEM       SF     78    220  40         18
    ## 324            Zach Randolph  MEM       PF     81    260  35         15
    ## 325          Al-Farouq Aminu  POR       SF     81    220  26          6
    ## 326             Allen Crabbe  POR       SG     78    210  24          3
    ## 327            C.J. McCollum  POR       SG     76    200  25          3
    ## 328           Damian Lillard  POR       PG     75    195  26          4
    ## 330              Evan Turner  POR       SF     79    220  28          6
    ## 333         Maurice Harkless  POR       SF     81    215  23          4
    ## 334           Meyers Leonard  POR       PF     85    245  24          4
    ## 335              Noah Vonleh  POR       PF     82    240  21          2
    ## 337           Shabazz Napier  POR       PG     73    175  25          2
    ## 339         Danilo Gallinari  DEN       SF     82    225  28          7
    ## 341          Emmanuel Mudiay  DEN       PG     77    200  20          1
    ## 342              Gary Harris  DEN       SG     76    210  22          2
    ## 343             Jamal Murray  DEN       SG     76    207  19          0
    ## 344            Jameer Nelson  DEN       PG     72    190  34         12
    ## 345         Juan Hernangomez  DEN       PF     81    230  21          0
    ## 346           Kenneth Faried  DEN       PF     80    228  27          5
    ## 350             Nikola Jokic  DEN        C     82    250  21          1
    ## 352              Will Barton  DEN       SG     78    175  26          4
    ## 353          Wilson Chandler  DEN       SF     80    225  29          8
    ## 355            Anthony Davis  NOP        C     82    253  23          4
    ## 358         Dante Cunningham  NOP       SF     80    230  29          7
    ## 361            E'Twaun Moore  NOP       SG     76    191  27          5
    ## 363             Jrue Holiday  NOP       PG     76    205  26          7
    ## 366             Solomon Hill  NOP       SF     79    225  25          3
    ## 367              Tim Frazier  NOP       PG     73    170  26          2
    ## 370             Devin Harris  DAL       PG     75    192  33         12
    ## 371            Dirk Nowitzki  DAL       PF     84    245  38         18
    ## 372      Dorian Finney-Smith  DAL       PF     80    220  23          0
    ## 373            Dwight Powell  DAL        C     83    240  25          2
    ## 374          Harrison Barnes  DAL       PF     80    210  24          4
    ## 378         Nicolas Brussino  DAL       SF     79    195  23          0
    ## 379              Salah Mejri  DAL        C     85    245  30          1
    ## 380               Seth Curry  DAL       PG     74    185  26          3
    ## 381          Wesley Matthews  DAL       SG     77    220  30          7
    ## 383         Anthony Tolliver  SAC       PF     80    240  31          8
    ## 384            Arron Afflalo  SAC       SG     77    210  31          9
    ## 385             Ben McLemore  SAC       SG     77    195  23          3
    ## 387          Darren Collison  SAC       PG     72    175  29          7
    ## 388           Garrett Temple  SAC       SG     78    195  30          6
    ## 390             Kosta Koufos  SAC        C     84    265  27          8
    ## 395                Ty Lawson  SAC       PG     71    195  29          7
    ## 397      Willie Cauley-Stein  SAC        C     84    240  23          1
    ## 399           Andrew Wiggins  MIN       SF     80    199  21          2
    ## 401             Cole Aldrich  MIN        C     83    250  28          6
    ## 402             Gorgui Dieng  MIN       PF     83    241  27          3
    ## 404       Karl-Anthony Towns  MIN        C     84    244  21          1
    ## 405                Kris Dunn  MIN       PG     76    210  22          0
    ## 406          Nemanja Bjelica  MIN       PF     82    240  28          1
    ## 408              Ricky Rubio  MIN       PG     76    194  26          5
    ## 409         Shabazz Muhammad  MIN       SF     78    223  24          3
    ## 410               Tyus Jones  MIN       PG     74    195  20          1
    ## 412           Brandon Ingram  LAL       SF     81    190  19          0
    ## 414         D'Angelo Russell  LAL       PG     77    195  20          1
    ## 417          Jordan Clarkson  LAL       SG     77    194  24          2
    ## 418            Julius Randle  LAL       PF     81    250  22          2
    ## 419          Larry Nance Jr.  LAL       PF     81    230  24          1
    ## 420                Luol Deng  LAL       SF     81    220  31         12
    ## 422               Nick Young  LAL       SG     79    210  31          9
    ## 423              Tarik Black  LAL        C     81    250  25          2
    ## 425           Timofey Mozgov  LAL        C     85    275  30          6
    ## 428                 Alex Len  PHO        C     85    260  23          3
    ## 429           Brandon Knight  PHO       SG     75    189  25          5
    ## 431             Devin Booker  PHO       SG     78    206  20          1
    ## 434             Eric Bledsoe  PHO       PG     73    190  27          6
    ## 435             Jared Dudley  PHO       PF     79    225  31          9
    ## 436          Leandro Barbosa  PHO       SG     75    194  34         13
    ## 437          Marquese Chriss  PHO       PF     82    233  19          0
    ## 439              T.J. Warren  PHO       SF     80    230  23          2
    ## 440               Tyler Ulis  PHO       PG     70    150  21          0
    ##                                                 college   salary games
    ## 1                                 University of Florida 26540100    68
    ## 2                                                       12000000    80
    ## 3                         University of Texas at Austin  8269663    55
    ## 6                              University of Washington  6587132    76
    ## 7                                  Marquette University  6286408    72
    ## 9                              University of California  4743000    78
    ## 10                                                       5000000    78
    ## 12                                   Gonzaga University  3094014    75
    ## 13                            Oklahoma State University  3578880    79
    ## 14                             University of Louisville  1906440    74
    ## 15                         University of North Carolina  8000000    51
    ## 16                                University of Arizona  7806971    74
    ## 21                      Georgia Institute of Technology  9700000    76
    ## 25                University of California, Los Angeles 21165675    60
    ## 27                                      Duke University 17638063    72
    ## 28                                                      30963450    74
    ## 29                                University of Arizona  2500000    79
    ## 30                        University of Texas at Austin 15330435    78
    ## 32                        University of Texas at Austin  7330000    80
    ## 34                    University of Southern California 26540100    74
    ## 35                               University of Missouri 14200000    72
    ## 37                                   University of Utah  2703960    54
    ## 38                                                      14382022    80
    ## 39                                 Villanova University 12000000    60
    ## 40                                                       1921320    57
    ## 41                University of California, Los Angeles   874636    76
    ## 43                          New Mexico State University  1196040    55
    ## 44                               University of Kentucky  6050000    65
    ## 47                                University of Florida 22116750    77
    ## 52                            Colorado State University  5000000    74
    ## 53                               University of Kentucky 16957900    78
    ## 54                                                      12000000    82
    ## 55                                 University of Kansas  7400000    76
    ## 56                                Georgetown University  5893981    80
    ## 58                                                       2870813    57
    ## 59                               University of Michigan  3386598    57
    ## 61                                                       2708582    79
    ## 62                                                      23180275    74
    ## 65                              Old Dominion University 15730338    73
    ## 66                              University of Minnesota  4000000    56
    ## 67  Virginia Polytechnic Institute and State University  2500000    73
    ## 69                                  Bucknell University  1015696    70
    ## 70                            Louisiana Tech University 20072033    69
    ## 72                                                       3850000    62
    ## 73                               University of Michigan  2281605    79
    ## 74                                                       2995421    80
    ## 75                                Georgetown University 17100000    81
    ## 76                                      Duke University  5374320    51
    ## 77                                University of Arizona  1551659    74
    ## 78                         University of North Carolina 12517606    58
    ## 80                               University of Virginia   925000    75
    ## 81                   Saint Mary's College of California  9607500    76
    ## 82                              Kansas State University  1403611    56
    ## 83                                                      10500000    70
    ## 86                                                       2568600    57
    ## 87                             University of New Mexico  2368327    80
    ## 88                                 University of Oregon  2700000    65
    ## 89                                                      10230179    66
    ## 90                                                       4583450    76
    ## 92                               Wake Forest University  8800000    82
    ## 96                                    Temple University  4000000    61
    ## 97                                                      10770000    74
    ## 98                        University of Texas at Austin  2463840    81
    ## 99                  California State University, Fresno 18314532    75
    ## 101                     Georgia Institute of Technology 14153652    74
    ## 103                              University of Arkansas  1453680    64
    ## 105                                                       874636    66
    ## 106                           Michigan State University  2092200    57
    ## 107                                Marquette University 23200000    60
    ## 109                            University of Notre Dame  1643040    63
    ## 110                                Marquette University 17552209    76
    ## 113                                                      5782450    70
    ## 115                              University of Kentucky 14000000    69
    ## 116                                 Stanford University 13219250    81
    ## 118                                                     15890000    73
    ## 119                                 Marshall University 22116750    77
    ## 120                              Wake Forest University  4000000    76
    ## 122                             University of Tennessee   874636    53
    ## 124                          University of Nevada, Reno  1227000    68
    ## 126                             Kansas State University   543471    78
    ## 127                 California State University, Fresno  5628000    73
    ## 129                        University of North Carolina  6000000    62
    ## 130                              Saint Louis University  1015696    71
    ## 131                           University of Connecticut 22116750    81
    ## 132                         Washington State University  6500000    75
    ## 137                              Wake Forest University  6000000    81
    ## 138                             University of Wisconsin 10991957    75
    ## 139                               University of Georgia  3678319    76
    ## 140                                University of Kansas  4625000    79
    ## 143                                      Boston College 14956522    52
    ## 144                               University of Arizona  2969880    77
    ## 145                             University of Tennessee 17200000    82
    ## 149                                  Indiana University  5318313    62
    ## 150                             University of Wisconsin  2730000    75
    ## 151                           University of Connecticut  6511628    62
    ## 153                           University of Connecticut 12000000    79
    ## 154                                                      6333333    74
    ## 155                        University of North Carolina 12250000    76
    ## 156                              University of Kentucky 13000000    81
    ## 158                                                     20869566    77
    ## 161                                 Syracuse University 24559380    74
    ## 163                         Western Kentucky University 11242000    77
    ## 164                               University of Memphis 21323250    64
    ## 166                            University of Washington  1015696    82
    ## 167                                                      4317720    66
    ## 168                            Norfolk State University  3900000    79
    ## 172                                                      2898000    68
    ## 173                            Wichita State University   543471    52
    ## 175                                                      1375000    72
    ## 176                               University of Arizona  4351320    80
    ## 177                                                     17000000    81
    ## 178                             University of Tennessee  5000000    62
    ## 179                       University of Texas at Austin  7250000    78
    ## 181                University of Louisiana at Lafayette  2613600    82
    ## 182                                                     17000000    68
    ## 183                               Georgetown University 15000000    69
    ## 186                                                      3909840    65
    ## 187                   University of Southern California 11750000    75
    ## 192                                                      2318280    81
    ## 193                                     Duke University  9000000    72
    ## 198                              University of Michigan  2993040    80
    ## 199                      Bowling Green State University  1025831    57
    ## 200                          Tennessee State University  1015696    67
    ## 201                                                      8000000    68
    ## 203                               University of Arizona   874636    81
    ## 205                                                      1326960    69
    ## 208                                 Stanford University 21165675    75
    ## 209                              University of Michigan  1562280    57
    ## 210                               Seton Hall University  1074145    73
    ## 212                              University of Virginia   980431    52
    ## 213                          Louisiana State University  3000000    64
    ## 216                                Villanova University  2500000    69
    ## 217                               University of Arizona  1395600    78
    ## 218                            University of Cincinnati   980431    70
    ## 219                              University of Colorado   726672    59
    ## 220                                  Clemson University  9250000    71
    ## 221                               University of Arizona 11131368    76
    ## 223                                   Xavier University  1551659    68
    ## 224                           Michigan State University 15330435    76
    ## 225                                  Belmont University  1015696    77
    ## 226                        University of North Carolina   980431    52
    ## 227                          University of Nevada, Reno  1403611    77
    ## 228                       University of Texas at Austin 26540100    62
    ## 229               University of California, Los Angeles  1182840    53
    ## 230                         Washington State University 16663575    78
    ## 232                     University of Nevada, Las Vegas   543471    71
    ## 233                                                      5782450    76
    ## 234                                    Davidson College 12112359    79
    ## 235                                                      2898000    70
    ## 237                        University of North Carolina 10000000    68
    ## 238                               University of Florida  1551659    79
    ## 239                                                       543471    67
    ## 241                   University of Southern California  2898000    76
    ## 243                               University of Houston   874636    78
    ## 244                          San Diego State University 17638063    74
    ## 245               University of California, Los Angeles  1192080    72
    ## 246                       University of Texas at Austin 20575005    72
    ## 247                                                     14000000    69
    ## 248                  Saint Mary's College of California  3578948    80
    ## 249                                                     15500000    64
    ## 250                                                     14445313    63
    ## 253                                                      1296240    65
    ## 254                                  Indiana University 12385364    75
    ## 256                            Arizona State University 26540100    81
    ## 259                            University of Louisville  1000000    58
    ## 260                              University of Arkansas  6000000    67
    ## 261                            University of California 18735364    72
    ## 262                             University of Wisconsin  1720560    77
    ## 263               University of California, Los Angeles  7806971    80
    ## 266                                     Duke University 11000000    74
    ## 267                              University of Oklahoma 20140838    61
    ## 268                          Louisiana State University  1551659    52
    ## 270                              Wake Forest University 22868828    61
    ## 271                                Texas A&M University 21165675    81
    ## 273                                     Duke University  7377500    78
    ## 274                              University of Michigan 13253012    82
    ## 275               University of California, Los Angeles  2203000    80
    ## 276                               University of Florida  1403611    82
    ## 278                        University of North Carolina  1551659    80
    ## 279                                 Syracuse University  5628000    68
    ## 281                                                      7000000    73
    ## 282                                                      3940320    66
    ## 285                                   Butler University 16073140    73
    ## 286                                University of Kansas  1015696    51
    ## 287                                                      2250000    82
    ## 288                              University of Arkansas 11000000    78
    ## 291                                     Duke University  1406520    59
    ## 292                                                      2121288    81
    ## 293                                   Butler University  2433334    55
    ## 294                              University of Kentucky  2340600    71
    ## 295                                                      5994764    68
    ## 296                              University of Colorado  2183072    79
    ## 297                                  Gonzaga University  2440200    81
    ## 299                                                     17145838    72
    ## 300                                 Syracuse University   980431    78
    ## 305               University of California, Los Angeles 26540100    81
    ## 306                                   Xavier University   543471    64
    ## 307                            University of Pittsburgh  3140517    80
    ## 309                                  Indiana University  6552960    67
    ## 310                              University of Kentucky   945000    72
    ## 314             California State University, Long Beach  2898000    64
    ## 315                               University of Alabama   980431    77
    ## 317                                                     21165675    74
    ## 318                               Ohio State University 26540100    69
    ## 319                           Oklahoma State University  5505618    71
    ## 320                    Virginia Commonwealth University  3332940    67
    ## 321                        University of North Carolina  4264057    73
    ## 324                           Michigan State University 10361445    73
    ## 325                              Wake Forest University  7680965    61
    ## 326                            University of California 18500000    79
    ## 327                                   Lehigh University  3219579    80
    ## 328                              Weber State University 24328425    75
    ## 330                               Ohio State University 16393443    65
    ## 333                               St. John's University  8988764    77
    ## 334          University of Illinois at Urbana-Champaign  9213484    74
    ## 335                                  Indiana University  2751360    74
    ## 337                           University of Connecticut  1350120    53
    ## 339                                                     15050000    63
    ## 341                                                      3241800    55
    ## 342                           Michigan State University  1655880    57
    ## 343                              University of Kentucky  3210840    82
    ## 344                           Saint Joseph's University  4540525    75
    ## 345                                                      1987440    62
    ## 346                           Morehead State University 12078652    61
    ## 350                                                      1358500    73
    ## 352                               University of Memphis  3533333    60
    ## 353                                   DePaul University 11200000    71
    ## 355                              University of Kentucky 22116750    75
    ## 358                                Villanova University  2978250    66
    ## 361                                   Purdue University  8081363    73
    ## 363               University of California, Los Angeles 11286518    67
    ## 366                               University of Arizona 11241218    80
    ## 367                       Pennsylvania State University  2090000    65
    ## 370                             University of Wisconsin  4228000    65
    ## 371                                                     25000000    54
    ## 372                               University of Florida   543471    81
    ## 373                                 Stanford University  8375000    77
    ## 374                        University of North Carolina 22116750    79
    ## 378                                                       543471    54
    ## 379                                                       874636    73
    ## 380                                     Duke University  2898000    70
    ## 381                                Marquette University 17100000    73
    ## 383                                Creighton University  8000000    65
    ## 384               University of California, Los Angeles 12500000    61
    ## 385                                University of Kansas  4008882    61
    ## 387               University of California, Los Angeles  5229454    68
    ## 388                          Louisiana State University  8000000    65
    ## 390                               Ohio State University  8046500    71
    ## 395                        University of North Carolina  1315448    69
    ## 397                              University of Kentucky  3551160    75
    ## 399                                University of Kansas  6006600    82
    ## 401                                University of Kansas  7643979    62
    ## 402                            University of Louisville  2348783    82
    ## 404                              University of Kentucky  5960160    82
    ## 405                                  Providence College  3872520    78
    ## 406                                                      3800000    65
    ## 408                                                     13550000    75
    ## 409               University of California, Los Angeles  3046299    78
    ## 410                                     Duke University  1339680    60
    ## 412                                     Duke University  5281680    79
    ## 414                               Ohio State University  5332800    63
    ## 417                              University of Missouri 12500000    82
    ## 418                              University of Kentucky  3267120    74
    ## 419                               University of Wyoming  1207680    63
    ## 420                                     Duke University 18000000    56
    ## 422                   University of Southern California  5443918    60
    ## 423                                University of Kansas  6191000    67
    ## 425                                                     16000000    54
    ## 428                              University of Maryland  4823621    77
    ## 429                              University of Kentucky 12606250    54
    ## 431                              University of Kentucky  2223600    78
    ## 434                              University of Kentucky 14000000    66
    ## 435                                      Boston College 10470000    64
    ## 436                                                      4000000    67
    ## 437                            University of Washington  2941440    82
    ## 439                     North Carolina State University  2128920    66
    ## 440                              University of Kentucky   918369    61
    ##     minutes points points3 points2 points1
    ## 1      2193    952      86     293     108
    ## 2      1608    520      27     186      67
    ## 3      1835    894     108     251      68
    ## 6      2569   2199     245     437     590
    ## 7      2335    999     157     176     176
    ## 9      1341    515      46     146      85
    ## 10     1232    299      45      69      26
    ## 12     1538    678      68     192      90
    ## 13     2399    835      94     175     203
    ## 14     1263    410      57      94      51
    ## 15      525    178       0      78      22
    ## 16     1398    676     137     101      63
    ## 21     1937    567      94     107      71
    ## 25     1885   1142     145     225     257
    ## 27     2525   1816     177     494     297
    ## 28     2794   1954     124     612     358
    ## 29     1614    448      62      91      80
    ## 30     2336    630       0     262     106
    ## 32     2003    740      48     251      94
    ## 34     2620   2020      33     688     545
    ## 35     1882    638     109     111      89
    ## 37      626    165       0      67      31
    ## 38     2066    959       1     390     176
    ## 39     2244   1344     193     233     299
    ## 40     1088    253       3     100      44
    ## 41     1368    636      56     171     126
    ## 43      859    229       1     102      22
    ## 44     1599    445      94      60      43
    ## 47     2684   1779     223     414     282
    ## 52     1068    420      37     137      35
    ## 53     2836   1805      89     558     422
    ## 54     2556    883       0     390     103
    ## 55     2374   1063      71     335     180
    ## 56     2605   1075     148     266      99
    ## 58      719    154       9      52      23
    ## 59      703    285      31      85      22
    ## 61     2485   1414     100     448     218
    ## 62     2199   1002       0     388     226
    ## 65     1963    801      92     203     119
    ## 66      689    257      19      68      64
    ## 67     1248    391      26     119      75
    ## 69     1237    435      46     124      49
    ## 70     2343   1246      75     355     311
    ## 72     1596    444      41     133      55
    ## 73     2154   1143     149     266     164
    ## 74     2845   1832      49     607     471
    ## 75     1823    951       0     387     177
    ## 76     1728   1025      65     334     162
    ## 77     1365    307      73      32      24
    ## 78     1123    392       0     159      74
    ## 80     1982    767      78     212     109
    ## 81     1986    577      79     129      82
    ## 82      935    528      18     198      78
    ## 83     1133    451     104      52      35
    ## 86      562    226      28      55      32
    ## 87     2336    683     144     102      47
    ## 88      894    322      48      73      32
    ## 89      931    535       0     235      65
    ## 90     1776    815     169     112      84
    ## 92     2657   1254      90     312     360
    ## 96      871    177       0      77      23
    ## 97     1998    630      43     204      93
    ## 98     2541   1173      40     404     245
    ## 99     2689   1775     195     427     336
    ## 101    2237    814      45     317      45
    ## 103    1000    437      32     151      39
    ## 105    1040    316       0     128      60
    ## 106     976    291      73      29      14
    ## 107    1792   1096      45     369     223
    ## 109    1028    370      49      79      65
    ## 110    2809   1816      91     479     585
    ## 113    1679    744     129     129      99
    ## 115    1843    538      50     179      30
    ## 116    2271    839       0     382      75
    ## 118    2459   1483     117     417     298
    ## 119    2513   1309       0     542     225
    ## 120    2085    975      87     281     152
    ## 122    1614    539      75     127      60
    ## 124    1065    324      87      26      11
    ## 126    1966    497      73     117      44
    ## 127    2178   1002      93     264     195
    ## 129    1500    648     149      82      37
    ## 130    1031    374       1     161      49
    ## 131    2409   1105       2     481     137
    ## 132    1163    365       0     143      79
    ## 137    1955    758      28     301      72
    ## 138    1944    767      49     261      98
    ## 139    2529   1047     153     217     154
    ## 140    2565   1105     118     303     145
    ## 143    1424    752      66     218     118
    ## 144    1371    339      45      84      36
    ## 145    2567   1321     109     402     190
    ## 149    1725    639       0     253     133
    ## 150    1954    874     116     204     118
    ## 151    1143    603      41     185     110
    ## 153    2739   1830     240     403     304
    ## 154    1778    780     102     162     150
    ## 155    2295    849     124     173     131
    ## 156    2349    743       1     294     152
    ## 158    2617   1164     135     258     243
    ## 161    2538   1659     151     451     304
    ## 163    2459    835     108     213      85
    ## 164    2082   1154      13     447     221
    ## 166    1639    629      97     136      66
    ## 167    2164   1196     112     331     198
    ## 168    1229    496       2     213      64
    ## 172    1016    425      54     104      55
    ## 173     857    215      23      59      28
    ## 175    1324    587       4     242      91
    ## 176    2298   1019      77     316     156
    ## 177    1793    483       0     179     125
    ## 178    1012    281      32      64      57
    ## 179    1538    616      95     100     131
    ## 181    2412   1046      40     390     146
    ## 182    2234   1167     128     280     223
    ## 183    1534    638      53     167     145
    ## 186     960    317      43      74      40
    ## 187    2163   1096      23     460     107
    ## 192    2129   1040     106     275     172
    ## 193    1667    662      61     173     133
    ## 198    2188    756     132     119     122
    ## 199    1193    559      27     203      72
    ## 200    2119    864     137     155     143
    ## 201    1518    530      92     118      18
    ## 203    2133    556      11     225      73
    ## 205    1190    445      50      95     105
    ## 208    2222   1539     134     421     295
    ## 209    1237    468      59     112      67
    ## 210    1643    543      44     160      91
    ## 212    1138    428      85      69      35
    ## 213    1177    442      55     119      39
    ## 216    1284    357      67      51      54
    ## 217    1761    675      15     220     190
    ## 218    1754    919     105     200     204
    ## 219    1334    432      38      96     126
    ## 220    1754    709      25     280      74
    ## 221    1998    574      64     155      72
    ## 223     854    316       3     132      43
    ## 224    2471    776      81     191     151
    ## 225    1137    527      61     150      44
    ## 226     457    147       2      60      21
    ## 227     739    472       0     208      56
    ## 228    2070   1555     117     434     336
    ## 229     447    135       2      54      21
    ## 230    2649   1742     268     376     186
    ## 232    1074    282      41      65      29
    ## 233    1345    389       1     172      42
    ## 234    2638   1999     324     351     325
    ## 235    1268    426       0     164      98
    ## 237    1807    497     118      58      27
    ## 238    1477    576       0     248      80
    ## 239     808    303      69      34      28
    ## 241    1330    387       0     161      65
    ## 243    1392    483      30     147      99
    ## 244    2474   1888     147     489     469
    ## 245    1020    246      15      78      45
    ## 246    2335   1243      23     477     220
    ## 247    1291    517      89      82      86
    ## 248    1754    759     147     126      66
    ## 249    1627    792      56     247     130
    ## 250    1587    638      23     242      85
    ## 253    1551    818       0     362      94
    ## 254    2323   1217     246     166     147
    ## 256    2947   2356     262     412     746
    ## 259    1064    527       1     224      76
    ## 260    2058    639     110     118      73
    ## 261    2116    979     204     119     129
    ## 262    1419    504      60     143      38
    ## 263    2773    936     191     135      93
    ## 266    2054    889     111     212     132
    ## 267    2076   1316      38     441     320
    ## 268     577    292       1     106      77
    ## 270    1921   1104     124     250     232
    ## 271    2570   1029       0     412     205
    ## 273    2198   1173     201     195     180
    ## 274    2157   1008     116     243     174
    ## 275    1787    484      43     148      59
    ## 276    1286    711     103     141     120
    ## 278    1700    538      46     175      50
    ## 279     810    186      29      44      11
    ## 281    1283    338      20     126      26
    ## 282    1228    412      44     111      58
    ## 285    2516   1601     149     396     362
    ## 286     432    146       0      55      36
    ## 287    1972    581     123      81      50
    ## 288    1843    715     106     167      63
    ## 291    1593    748     114     158      90
    ## 292    2744   1137       0     413     311
    ## 293    1205    430      37     133      53
    ## 294    1158    440      65      94      57
    ## 295    1055    406      94      40      44
    ## 296    2376    522      45     170      47
    ## 297    1632    479      51     141      44
    ## 299    1533   1033       5     397     224
    ## 300    1490    421      43     103      86
    ## 305    2802   2558     200     624     710
    ## 306     973    183      12      65      17
    ## 307    2389    905       0     374     157
    ## 309    2222   1067     127     285     116
    ## 310    1474    425      43      74     148
    ## 314    1501    429      51      95      86
    ## 315    2101    689      55     195     134
    ## 317    2531   1446     104     428     278
    ## 318    2292   1415     171     293     316
    ## 319    1914    643      15     259      80
    ## 320    1183    551     138      47      43
    ## 321    1799    586     112      81      88
    ## 324    1786   1028      21     412     141
    ## 325    1773    532      70     113      96
    ## 326    2254    845     134     169     105
    ## 327    2796   1837     185     507     268
    ## 328    2694   2024     214     447     488
    ## 330    1658    586      31     204      85
    ## 333    2223    773      68     246      77
    ## 334    1222    401      74      72      35
    ## 335    1265    327       7     123      60
    ## 337     512    218      34      39      38
    ## 339    2134   1145     126     209     349
    ## 341    1406    603      56     152     131
    ## 342    1782    851     107     213     104
    ## 343    1764    811     115     180     106
    ## 344    2045    687     106     162      45
    ## 345     842    305      46      55      57
    ## 346    1296    587       0     228     131
    ## 350    2038   1221      45     449     188
    ## 352    1705    820      87     208     143
    ## 353    2197   1117     110     323     141
    ## 355    2708   2099      40     730     519
    ## 358    1649    435      71     103      16
    ## 361    1820    700      77     206      57
    ## 363    2190   1029     100     305     119
    ## 366    2374    563      94      89     103
    ## 367    1525    464      40     123      98
    ## 370    1087    437      58      78     107
    ## 371    1424    769      79     217      98
    ## 372    1642    350      56      68      46
    ## 373    1333    516      21     173     107
    ## 374    2803   1518      78     521     242
    ## 378     521    150      29      23      17
    ## 379     905    213       1      87      36
    ## 380    2029    898     137     201      85
    ## 381    2495    986     174     159     146
    ## 383    1477    461      90      65      61
    ## 384    1580    515      62     123      83
    ## 385    1176    495      65     115      70
    ## 387    2063    900      73     267     147
    ## 388    1728    506      82     101      58
    ## 390    1419    470       0     216      38
    ## 395    1732    681      34     203     173
    ## 397    1421    611       0     255     101
    ## 399    3048   1933     103     606     412
    ## 401     531    105       0      45      15
    ## 402    2653    816      16     316     136
    ## 404    3030   2061     101     701     356
    ## 405    1333    293      21      97      36
    ## 406    1190    403      56      95      45
    ## 408    2469    836      60     201     254
    ## 409    1516    772      49     239     147
    ## 410     774    209      26      49      33
    ## 412    2279    740      55     221     133
    ## 414    1811    984     135     216     147
    ## 417    2397   1205     117     360     134
    ## 418    2132    975      17     360     204
    ## 419    1442    449      10     180      59
    ## 420    1486    425      51     113      46
    ## 422    1556    791     170     102      77
    ## 423    1091    383       1     149      82
    ## 425    1104    401       0     169      63
    ## 428    1560    613       3     227     150
    ## 429    1140    595      45     164     132
    ## 431    2730   1726     147     459     367
    ## 434    2176   1390     104     345     388
    ## 435    1362    434      77      80      43
    ## 436     963    419      35     137      40
    ## 437    1743    753      72     212     113
    ## 439    2048    951      26     377     119
    ## 440    1123    444      21     163      55

-   What's the largest height value?

``` r
height_sorted <- sort(dat$height, decreasing = TRUE)
height_sorted[1]
```

    ## [1] 87

-   What's the minimum height value?

``` r
height_sorted <- sort(dat$height, decreasing = FALSE)
height_sorted[1]
```

    ## [1] 69

-   What's the overall average height?

``` r
avg_height <- sum(dat$height)/441
avg_height
```

    ## [1] 79.1542

-   Who is the tallest player?

``` r
height_sorted <- sort(dat$height, decreasing = TRUE)
table <- dat
subset(dat, height == height_sorted[1])
```

    ##                 player team position height weight age experience college
    ## 20         Edy Tavares  CLE        C     87    260  24          1        
    ## 134   Boban Marjanovic  DET        C     87    290  28          1        
    ## 167 Kristaps Porzingis  NYK       PF     87    240  21          1        
    ##      salary games minutes points points3 points2 points1
    ## 20     5145     1      24      6       0       3       0
    ## 134 7000000    35     293    191       0      72      47
    ## 167 4317720    66    2164   1196     112     331     198

-   Who is the shortest player?

``` r
height_sorted <- sort(dat$height, decreasing = FALSE)
subset(dat, height == height_sorted[1])
```

    ##           player team position height weight age experience
    ## 6  Isaiah Thomas  BOS       PG     69    185  27          5
    ## 24    Kay Felder  CLE       PG     69    176  21          0
    ##                     college  salary games minutes points points3 points2
    ## 6  University of Washington 6587132    76    2569   2199     245     437
    ## 24       Oakland University  543471    42     386    166       7      55
    ##    points1
    ## 6      590
    ## 24      35

-   How many different teams?

-   Who is the oldest player?

``` r
age_sorted <- sort(dat$age, decreasing = TRUE)
subset (dat, age == age_sorted[1])
```

    ##           player team position height weight age experience
    ## 321 Vince Carter  MEM       SF     78    220  40         18
    ##                          college  salary games minutes points points3
    ## 321 University of North Carolina 4264057    73    1799    586     112
    ##     points2 points1
    ## 321      81      88

-   What is the median salary of all players?

``` r
salary_sorted <- sort(dat$salary, decreasing = TRUE)
median_salary <- (salary_sorted[220] + salary_sorted[221])/2
median_salary
```

    ## [1] 3508600

-   What is the median salary of the players with 10 years of experience or more?

``` r
salary_sorted2 <- subset(dat, experience > 10)
salary_sorted2 <- sort(salary_sorted2$salary, decreasing = TRUE)
median_salary2 <- (salary_sorted2[length(salary_sorted2)/2])
median_salary2
```

    ## [1] 5239437

-   What is the median salary of Power Forwards (PF), 29 years or older, and 74 inches tall or less?

``` r
salary_sorted4 <- subset(dat, position = "PF")
salary_sorted4 <- subset(dat, age > 28)
salary_sorted4 <- subset(dat, height < 75)
salary_sorted4 <- sort(salary_sorted4$salary, decreasing = TRUE)
median_salary4 <- (salary_sorted4[length(salary_sorted4)/2])
median_salary4
```

    ## [1] 2700000

-   How many players scored 4 points or less?

``` r
length(subset(dat, points < 5))
```

    ## [1] 15

-   Who are those players who scored 4 points or less?

``` r
low_score <- subset(dat, points < 5)
low_score
```

    ##               player team position height weight age experience
    ## 49  Chris McCullough  WAS       PF     83    200  21          1
    ## 141  Michael Gbinije  DET       SG     79    200  24          0
    ## 188  Patricio Garino  ORL       SG     78    210  23          0
    ## 255    Isaiah Taylor  HOU       PG     75    170  22          0
    ## 269    Brice Johnson  LAC       PF     82    230  22          0
    ## 351      Roy Hibbert  DEN        C     86    270  30          8
    ## 433   Elijah Millsap  PHO       SG     78    225  29          2
    ##                                 college  salary games minutes points
    ## 49                  Syracuse University 1191480     2       8      1
    ## 141                 Syracuse University  650000     9      32      4
    ## 188        George Washington University   31969     5      43      0
    ## 255       University of Texas at Austin  255000     4      52      3
    ## 269        University of North Carolina 1273920     3       9      4
    ## 351               Georgetown University 5000000     6      11      4
    ## 433 University of Alabama at Birmingham   23069     2      23      3
    ##     points3 points2 points1
    ## 49        0       0       1
    ## 141       0       1       2
    ## 188       0       0       0
    ## 255       0       1       1
    ## 269       0       2       0
    ## 351       0       2       0
    ## 433       0       1       1

-   Who is the player with 0 points?

``` r
low_score_player <- subset(dat, points == 0)
low_score_player
```

    ##              player team position height weight age experience
    ## 188 Patricio Garino  ORL       SG     78    210  23          0
    ##                          college salary games minutes points points3
    ## 188 George Washington University  31969     5      43      0       0
    ##     points2 points1
    ## 188       0       0

-   How many players are from "University of California, Berkeley"?

``` r
cal_alumni <- nrow(subset(dat, college == "University of California, Los Angeles"))
cal_alumni
```

    ## [1] 13

-   Are there any players from "University of Notre Dame"? If so how many and who are they?

``` r
subset(dat, college == "University of Notre Dame")
```

    ##                player team position height weight age experience
    ## 4   Demetrius Jackson  BOS       PG     73    201  22          0
    ## 109      Jerian Grant  CHI       PG     76    195  24          1
    ## 336   Pat Connaughton  POR       SG     77    206  24          1
    ##                      college  salary games minutes points points3 points2
    ## 4   University of Notre Dame 1450000     5      17     10       1       2
    ## 109 University of Notre Dame 1643040    63    1028    370      49      79
    ## 336 University of Notre Dame  874636    39     316     98      17      20
    ##     points1
    ## 4         3
    ## 109      65
    ## 336       7

-   Are there any players with weight greater than 260 pounds? If so how many and who are they?

``` r
subset(dat, college == "University of Notre Dame")
```

    ##                player team position height weight age experience
    ## 4   Demetrius Jackson  BOS       PG     73    201  22          0
    ## 109      Jerian Grant  CHI       PG     76    195  24          1
    ## 336   Pat Connaughton  POR       SG     77    206  24          1
    ##                      college  salary games minutes points points3 points2
    ## 4   University of Notre Dame 1450000     5      17     10       1       2
    ## 109 University of Notre Dame 1643040    63    1028    370      49      79
    ## 336 University of Notre Dame  874636    39     316     98      17      20
    ##     points1
    ## 4         3
    ## 109      65
    ## 336       7

-   How many players did not attend a college in the US?

``` r
nrow(subset(dat, college == ""))
```

    ## [1] 85

-   Who is the player with the maximum rate of points per minute?

``` r
dat$ppm <- dat$points / dat$minutes
ppm <- sort(dat$ppm, decreasing = TRUE)
ppm_max <- subset(dat, ppm == max(ppm))
ppm_max
```

    ##                player team position height weight age experience
    ## 305 Russell Westbrook  OKC       PG     75    200  28          8
    ##                                   college   salary games minutes points
    ## 305 University of California, Los Angeles 26540100    81    2802   2558
    ##     points3 points2 points1       ppm
    ## 305     200     624     710 0.9129193

-   Who is the player with the maximum rate of three-points per minute?

``` r
dat$ppm3 <- dat$points3 / dat$minutes
ppm3 <- sort(dat$ppm3, decreasing = TRUE)
ppm3_max <- subset(dat, ppm3 == max(ppm3))
ppm3_max
```

    ##            player team position height weight age experience
    ## 234 Stephen Curry  GSW       PG     75    190  28          7
    ##              college   salary games minutes points points3 points2 points1
    ## 234 Davidson College 12112359    79    2638   1999     324     351     325
    ##          ppm      ppm3
    ## 234 0.757771 0.1228203

-   Who is the player with the maximum rate of two-points per minute?

``` r
dat$ppm2 <- dat$points2 / dat$minutes
ppm2 <- sort(dat$ppm2, decreasing = TRUE)
ppm2_max <- subset(dat, ppm2 == max(ppm2))
ppm2_max
```

    ##           player team position height weight age experience
    ## 227 JaVale McGee  GSW        C     84    270  29          8
    ##                        college  salary games minutes points points3
    ## 227 University of Nevada, Reno 1403611    77     739    472       0
    ##     points2 points1       ppm ppm3      ppm2
    ## 227     208      56 0.6387009    0 0.2814614

-   Who is the player with the maximum rate of one-points (free-throws) per minute?

``` r
dat$ppm1 <- dat$points1 / dat$minutes
ppm1 <- sort(dat$ppm1, decreasing = TRUE)
ppm1_max <- subset(dat, ppm1 == max(ppm1))
ppm1_max
```

    ##                player team position height weight age experience
    ## 305 Russell Westbrook  OKC       PG     75    200  28          8
    ##                                   college   salary games minutes points
    ## 305 University of California, Los Angeles 26540100    81    2802   2558
    ##     points3 points2 points1       ppm       ppm3      ppm2      ppm1
    ## 305     200     624     710 0.9129193 0.07137759 0.2226981 0.2533904

-   Create a data frame `gsw` with the name, height, weight of Golden State Warriors (GSW)

``` r
gsw <- subset(dat, team == 'GSW')
gsw  <- data.frame(name = gsw$player, height = gsw$height, weight = gsw$weight)
gsw
```

    ##                    name height weight
    ## 1        Andre Iguodala     78    215
    ## 2          Damian Jones     84    245
    ## 3            David West     81    250
    ## 4        Draymond Green     79    230
    ## 5             Ian Clark     75    175
    ## 6  James Michael McAdoo     81    230
    ## 7          JaVale McGee     84    270
    ## 8          Kevin Durant     81    240
    ## 9          Kevon Looney     81    220
    ## 10        Klay Thompson     79    215
    ## 11          Matt Barnes     79    226
    ## 12        Patrick McCaw     79    185
    ## 13     Shaun Livingston     79    192
    ## 14        Stephen Curry     75    190
    ## 15        Zaza Pachulia     83    270

-   Display the data in `gsw` sorted by height in increasing order (hint: see `?sort` and `?order`)

``` r
gsw[order(gsw$height),]
```

    ##                    name height weight
    ## 5             Ian Clark     75    175
    ## 14        Stephen Curry     75    190
    ## 1        Andre Iguodala     78    215
    ## 4        Draymond Green     79    230
    ## 10        Klay Thompson     79    215
    ## 11          Matt Barnes     79    226
    ## 12        Patrick McCaw     79    185
    ## 13     Shaun Livingston     79    192
    ## 3            David West     81    250
    ## 6  James Michael McAdoo     81    230
    ## 8          Kevin Durant     81    240
    ## 9          Kevon Looney     81    220
    ## 15        Zaza Pachulia     83    270
    ## 2          Damian Jones     84    245
    ## 7          JaVale McGee     84    270

-   Display the data in gsw by weight in decreasing order (hint: see `?sort` and `?order`)

``` r
gsw[order(gsw$weight, decreasing = TRUE), ]
```

    ##                    name height weight
    ## 7          JaVale McGee     84    270
    ## 15        Zaza Pachulia     83    270
    ## 3            David West     81    250
    ## 2          Damian Jones     84    245
    ## 8          Kevin Durant     81    240
    ## 4        Draymond Green     79    230
    ## 6  James Michael McAdoo     81    230
    ## 11          Matt Barnes     79    226
    ## 9          Kevon Looney     81    220
    ## 1        Andre Iguodala     78    215
    ## 10        Klay Thompson     79    215
    ## 13     Shaun Livingston     79    192
    ## 14        Stephen Curry     75    190
    ## 12        Patrick McCaw     79    185
    ## 5             Ian Clark     75    175

-   Display the player name, team, and salary, of the top 5 highest-paid players (hint: see `?sort` and `?order`)

``` r
top_earners <- data.frame("player" = dat$player, "team" = dat$team, "salary" = dat$salary)
top_earners <- top_earners[order(top_earners$salary, decreasing = TRUE), ]
head(top_earners, 5)
```

    ##            player team   salary
    ## 28   LeBron James  CLE 30963450
    ## 1      Al Horford  BOS 26540100
    ## 34  DeMar DeRozan  TOR 26540100
    ## 228  Kevin Durant  GSW 26540100
    ## 256  James Harden  HOU 26540100

-   Display the player name, team, and points3, of the top 10 three-point players (hint: see `?sort` and `?order`)

``` r
top_3shooters <- data.frame("player" = dat$player, "team" = dat$team, "points3" = dat$points3)
top_3shooters <- top_3shooters[order(top_3shooters$points3, decreasing = TRUE), ]
head(top_3shooters, 10)
```

    ##             player team points3
    ## 234  Stephen Curry  GSW     324
    ## 230  Klay Thompson  GSW     268
    ## 256   James Harden  HOU     262
    ## 254    Eric Gordon  HOU     246
    ## 6    Isaiah Thomas  BOS     245
    ## 153   Kemba Walker  CHO     240
    ## 47    Bradley Beal  WAS     223
    ## 328 Damian Lillard  POR     214
    ## 261  Ryan Anderson  HOU     204
    ## 273    J.J. Redick  LAC     201

Group By
--------

Group-by operations are very common in data analytics. Without dedicated functions, these operations tend to be very hard (labor intensive).

**Quick try**: Using just bracket notation, try to create a data frame with two columns: the team name, and the team payroll (addition of all player salaries).

So what functions can you use in R to perform group by operations? In base R, the main function for group-by operations is `aggregate()`.

Here's an example using `aggregate()` to get the median salary, grouped by team:

``` r
aggregate(dat$salary, by = list(dat$team), FUN = median)
```

    ##    Group.1       x
    ## 1      ATL 3279291
    ## 2      BOS 4743000
    ## 3      BRK 1790902
    ## 4      CHI 2112480
    ## 5      CHO 6000000
    ## 6      CLE 5239437
    ## 7      DAL 2898000
    ## 8      DEN 3500000
    ## 9      DET 4625000
    ## 10     GSW 1551659
    ## 11     HOU 1508400
    ## 12     IND 4000000
    ## 13     LAC 3500000
    ## 14     LAL 5281680
    ## 15     MEM 3332940
    ## 16     MIA 3449000
    ## 17     MIL 4184870
    ## 18     MIN 3650000
    ## 19     NOP 3789125
    ## 20     NYK 2898000
    ## 21     OKC 3140517
    ## 22     ORL 5000000
    ## 23     PHI 2318280
    ## 24     PHO 2941440
    ## 25     POR 4943123
    ## 26     SAC 5200000
    ## 27     SAS 2898000
    ## 28     TOR 5300000
    ## 29     UTA 2433334
    ## 30     WAS 4365326

The same example above can also be obtained with `aggreagte()` using formula notation like this:

``` r
aggregate(salary ~ team, data = dat, FUN = median)
```

    ##    team  salary
    ## 1   ATL 3279291
    ## 2   BOS 4743000
    ## 3   BRK 1790902
    ## 4   CHI 2112480
    ## 5   CHO 6000000
    ## 6   CLE 5239437
    ## 7   DAL 2898000
    ## 8   DEN 3500000
    ## 9   DET 4625000
    ## 10  GSW 1551659
    ## 11  HOU 1508400
    ## 12  IND 4000000
    ## 13  LAC 3500000
    ## 14  LAL 5281680
    ## 15  MEM 3332940
    ## 16  MIA 3449000
    ## 17  MIL 4184870
    ## 18  MIN 3650000
    ## 19  NOP 3789125
    ## 20  NYK 2898000
    ## 21  OKC 3140517
    ## 22  ORL 5000000
    ## 23  PHI 2318280
    ## 24  PHO 2941440
    ## 25  POR 4943123
    ## 26  SAC 5200000
    ## 27  SAS 2898000
    ## 28  TOR 5300000
    ## 29  UTA 2433334
    ## 30  WAS 4365326

Here's another example using `aggregate()` to get the average height and average weight, grouped by position:

``` r
aggregate(dat[ ,c('height', 'weight')], by = list(dat$position), FUN = mean)
```

    ##   Group.1   height   weight
    ## 1       C 83.25843 250.7978
    ## 2      PF 81.50562 235.8539
    ## 3      PG 74.30588 188.5765
    ## 4      SF 79.63855 220.4699
    ## 5      SG 77.02105 204.7684

The same example above can also be obtained with `aggreagte()` using formula notation like this:

``` r
aggregate(. ~ position, data = dat[ ,c('position', 'height', 'weight')],
          FUN = mean)
```

    ##   position   height   weight
    ## 1        C 83.25843 250.7978
    ## 2       PF 81.50562 235.8539
    ## 3       PG 74.30588 188.5765
    ## 4       SF 79.63855 220.4699
    ## 5       SG 77.02105 204.7684

### Your turn

-   Create a data frame with the average height, average weight, and average age, grouped by position

``` r
aggregate(dat[ ,c('height', 'weight', 'age')], by = list(dat$position), FUN = mean)
```

    ##   Group.1   height   weight      age
    ## 1       C 83.25843 250.7978 25.93258
    ## 2      PF 81.50562 235.8539 25.93258
    ## 3      PG 74.30588 188.5765 26.38824
    ## 4      SF 79.63855 220.4699 27.07229
    ## 5      SG 77.02105 204.7684 26.20000

-   Create a data frame with the average height, average weight, and average age, grouped by team

``` r
avg <- aggregate(dat[ ,c('height', 'weight', 'age')], by = list(dat$team), FUN = mean)
avg
```

    ##    Group.1   height   weight      age
    ## 1      ATL 79.14286 219.9286 28.42857
    ## 2      BOS 78.20000 219.8667 25.26667
    ## 3      BRK 78.66667 222.4000 25.46667
    ## 4      CHI 78.53333 215.6000 25.80000
    ## 5      CHO 78.80000 212.8000 25.86667
    ## 6      CLE 78.86667 226.4000 29.60000
    ## 7      DAL 79.13333 215.6667 26.93333
    ## 8      DEN 79.40000 220.2667 25.80000
    ## 9      DET 79.53333 228.0000 25.46667
    ## 10     GSW 79.86667 223.5333 27.73333
    ## 11     HOU 78.28571 214.8571 25.64286
    ## 12     IND 78.50000 226.0714 27.00000
    ## 13     LAC 78.80000 225.0667 29.53333
    ## 14     LAL 80.00000 224.3333 25.53333
    ## 15     MEM 79.26667 221.7333 27.40000
    ## 16     MIA 79.00000 219.2857 26.71429
    ## 17     MIL 80.35714 224.1429 25.71429
    ## 18     MIN 79.71429 221.5714 25.07143
    ## 19     NOP 79.50000 218.9286 25.78571
    ## 20     NYK 80.00000 218.3333 26.60000
    ## 21     OKC 79.26667 219.2000 25.73333
    ## 22     ORL 78.93333 216.2000 25.20000
    ## 23     PHI 79.33333 225.0000 24.73333
    ## 24     PHO 78.53333 213.8000 25.40000
    ## 25     POR 79.42857 217.9286 24.21429
    ## 26     SAC 78.46667 216.6000 25.86667
    ## 27     SAS 79.13333 217.3333 28.86667
    ## 28     TOR 79.06667 222.6000 25.20000
    ## 29     UTA 79.46667 222.1333 26.20000
    ## 30     WAS 79.50000 215.1429 25.85714

-   Create a data frame with the average height, average weight, and average age, grouped by team and position.

``` r
avg2 <- data.frame(aggregate(dat[ ,c('height', 'weight', 'age')], by = list(dat$team), FUN = mean), aggregate(dat[ ,c('height', 'weight', 'age')], by = list(dat$position), FUN = mean))
avg2
```

    ##    Group.1   height   weight      age Group.1.1 height.1 weight.1    age.1
    ## 1      ATL 79.14286 219.9286 28.42857         C 83.25843 250.7978 25.93258
    ## 2      BOS 78.20000 219.8667 25.26667        PF 81.50562 235.8539 25.93258
    ## 3      BRK 78.66667 222.4000 25.46667        PG 74.30588 188.5765 26.38824
    ## 4      CHI 78.53333 215.6000 25.80000        SF 79.63855 220.4699 27.07229
    ## 5      CHO 78.80000 212.8000 25.86667        SG 77.02105 204.7684 26.20000
    ## 6      CLE 78.86667 226.4000 29.60000         C 83.25843 250.7978 25.93258
    ## 7      DAL 79.13333 215.6667 26.93333        PF 81.50562 235.8539 25.93258
    ## 8      DEN 79.40000 220.2667 25.80000        PG 74.30588 188.5765 26.38824
    ## 9      DET 79.53333 228.0000 25.46667        SF 79.63855 220.4699 27.07229
    ## 10     GSW 79.86667 223.5333 27.73333        SG 77.02105 204.7684 26.20000
    ## 11     HOU 78.28571 214.8571 25.64286         C 83.25843 250.7978 25.93258
    ## 12     IND 78.50000 226.0714 27.00000        PF 81.50562 235.8539 25.93258
    ## 13     LAC 78.80000 225.0667 29.53333        PG 74.30588 188.5765 26.38824
    ## 14     LAL 80.00000 224.3333 25.53333        SF 79.63855 220.4699 27.07229
    ## 15     MEM 79.26667 221.7333 27.40000        SG 77.02105 204.7684 26.20000
    ## 16     MIA 79.00000 219.2857 26.71429         C 83.25843 250.7978 25.93258
    ## 17     MIL 80.35714 224.1429 25.71429        PF 81.50562 235.8539 25.93258
    ## 18     MIN 79.71429 221.5714 25.07143        PG 74.30588 188.5765 26.38824
    ## 19     NOP 79.50000 218.9286 25.78571        SF 79.63855 220.4699 27.07229
    ## 20     NYK 80.00000 218.3333 26.60000        SG 77.02105 204.7684 26.20000
    ## 21     OKC 79.26667 219.2000 25.73333         C 83.25843 250.7978 25.93258
    ## 22     ORL 78.93333 216.2000 25.20000        PF 81.50562 235.8539 25.93258
    ## 23     PHI 79.33333 225.0000 24.73333        PG 74.30588 188.5765 26.38824
    ## 24     PHO 78.53333 213.8000 25.40000        SF 79.63855 220.4699 27.07229
    ## 25     POR 79.42857 217.9286 24.21429        SG 77.02105 204.7684 26.20000
    ## 26     SAC 78.46667 216.6000 25.86667         C 83.25843 250.7978 25.93258
    ## 27     SAS 79.13333 217.3333 28.86667        PF 81.50562 235.8539 25.93258
    ## 28     TOR 79.06667 222.6000 25.20000        PG 74.30588 188.5765 26.38824
    ## 29     UTA 79.46667 222.1333 26.20000        SF 79.63855 220.4699 27.07229
    ## 30     WAS 79.50000 215.1429 25.85714        SG 77.02105 204.7684 26.20000

-   Difficult: Create a data frame with the minimum salary, median salary, mean salary, and maximum salary, grouped by team and position.

------------------------------------------------------------------------
