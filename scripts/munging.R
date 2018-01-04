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


  
