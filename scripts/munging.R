# Author: Paula Andrea Martinez
# Date: January 4th, 2018
# Description: Here I am playing with R to solve some day to day munging 

# Using dplyr from tidyverse
library(dplyr)

# I am using here the mtcars dataset
str(mtcars)

## How to replace a value from a given column?
mtcars %>%
   mutate(cyl = replace(cyl, cyl == 6, NA))

# so, this works but then I noticed that the rownames were gone :/ 

## How to replace a value from a given column but maintaining the rownames?
# we need the package tibble
library(tibble)
# bit more verbose, but works very nicely. We save the rownames in a new column and then we add it back again as rownames.
# when using tibbles we do not need this, this is helpful when using data.frames, like the mtcars

mtcars %>%
    rownames_to_column("rnames") %>%
    mutate(cyl = replace(cyl, cyl == 6, NA)) %>%
    column_to_rownames("rnames")

## How to replace a value from a given column based on the value of another column?
# Use tibble again if you care to preserve rownames

mtcars %>%
    rownames_to_column("rnames") %>%
    mutate(mpg = replace(mpg, cyl == 4, NA)) %>%
    column_to_rownames("rnames")

## How to replace two values from a given column at the same time?

mtcars %>%
    rownames_to_column("rnames") %>%
    mutate(vs = ifelse(vs == 0, "No", "Yes")) %>%
    column_to_rownames("rnames")

## How to add explicit values to NA

library(forcats) 
fct_explicit_na(a_df$col, na_level = "None")

## How to replace multiple values of a vector, like if it was a factor

# initially I tried this with forcats
library(forcats)
replacement_vector <- LETTERS[1:3]
replacement_vector
# [1] "A" "B" "C"
mtcars$gear
# [1] 4 4 4 3 3 3 3 4 4 4 4 3 3 3 3 3 3 4 4 4 3 3 3 3 3 4 5 5 5 5 5 4

forcats::lvls_revalue(factor(mtcars$gear), replacement_vector)
# [1] B B B A A A A B B B B A A A A A A B B B A A A A A B C C C C C B
# Levels: A B C

# note: the column has not been substituted, the result is a factor, the order is something you might want to be caeful about

# using this line to mutate a column

mtcars %>%
     mutate(gear = as.character(lvls_revalue(factor(gear), replacement_vector)))

# I am thinking that there might be a better way (another function) to convert the factor, but this works well




  
