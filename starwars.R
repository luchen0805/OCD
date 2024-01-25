library(tidyverse)
library(dplyr)
library(tidyr)

## Create your goal tibble to replicate

# Run this line to see what your end product should look like
sw.wrangled.goal <- read_csv("sw-wrangled.csv") %>% 
  mutate(across(c(hair, gender, species, homeworld), factor)) # this is a quick-and-dirty fix to account for odd importing behavior

# View in console
sw.wrangled.goal 

# Examine the structure of the df and take note of data types
# Look closely at factors (you may need another function to do so) to see their levels
str(sw.wrangled.goal) 

## Use the built-in starwars dataset to replicate the tibble above in a tbl called sw.wrangled
# If you get stuck, use comments to "hold space" for where you know code needs to go to achieve a goal you're not sure how to execute
sw.wrangled <- starwars %>%
  select(-skin_color, -eye_color, -birth_year, -sex, -films, -vehicles, -starships) %>% # delete the columns "skin_color", "eye_color", "birth_year", "sex", "films", "vehicles", "starships"
  separate(name, into = c("first_name", "last_name"), sep = " ", extra = "merge") %>% # separate "name" column into "first name" column and "last name" column
  mutate(initials = paste0(substr(first_name, 1, 1), substr(last_name, 1, 1))) %>% # add one column for "initials"
  mutate(
    height_cm = height,
    height_in = height * 0.3937
  ) %>% # for "height" column, add another "height_in" column which converts the original cm to inch, and change the original "height" column name to "height_cm"
  select(-height) %>% # delete the original "height" column
  rename(hair = hair_color) %>% # change the column name "hair_color" to "hair"
  mutate(gender = substr(gender, 1, 1)) %>% # shows only the first letter for "gender" column
  mutate(species = toupper(species)) %>% # capitalize all letters in "species" column
  mutate(brown_hair = ifelse(is.na(hair) | hair =="brown", TRUE, FALSE)) %>% # add one column "brown_hair", return "TRUE/FALSE" according to "hair" column, if it's "NA" for hair, return FALSE too
  arrange(last_name) %>% # arrange "last_name" column according to alphabetic order
  filter(!is.na(height_cm) | !is.na(height_in)) %>% # filter out rows where "height_cm" and "height_in" are "NA"
  select(first_name, last_name, initials, height_in, height_cm, mass, hair, gender, species, homeworld, brown_hair) %>% # rearrange column orders
  slice(c(1:2, 4, 3, 5:21, 23, 22, 24:38, 40, 39, 41:81)) %>% # reorder row orders
  mutate(hair = ifelse(first_name == "Jabba", "bald", hair),
         brown_hair = ifelse(first_name == "Jabba", "FALSE", brown_hair)) %>% # change "hair" value and "brown_hair" value for Jabba
  mutate(brown_hair = ifelse(first_name == "Owen", "TRUE", brown_hair)) # change "brown_hair" value for Owen
# one problem left, don't know what to do: for last name is "NA", rearrange first name in alphabetic order

## Step-by-step
# delete the columns "skin_color", "eye_color", "birth_year", "sex", "films", "vehicles", "starships"
# separate "name" column into "first name" column and "last name" column
# add one column for "initials"
# for "height" column, add another "height_in" column which converts the original cm to inch, and change the original "height" column name to "height_cm"
# delete the original "height" column
# change the column name "hair_color" to "hair"
# shows only the first letter for "gender" column
# capitalize all letters in "species" column
# add one column "brown_hair", return "TRUE/FALSE" according to "hair" column, if it's "NA" for hair, return FALSE too
# arrange "last_name" column according to alphabetic order
# filter out rows where "height_cm" and "height_in" are "NA"
# rearrange column orders
# reorder row orders
# change "hair" value and "brown_hair" value for Jabba
# change "brown_hair" value for Owen

## Check that your sw.wrangled df is identical to the goal df
# Use any returned information about mismatches to adjust your code as needed
all.equal(sw.wrangled, sw.wrangled.goal)
