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

# Assignment 11 part 1: recreate three plots
library(ggplot2)

# recreate dataset code from answer
sw.wrangled2 <- starwars %>% 
  # Select only needed columns & rename height (to height_cm) and hair_color (to hair)
  select(name, height_cm = height, mass, hair = hair_color, gender, species, homeworld) %>% 
  # Filter out any rows where height data is missing
  filter(!is.na(height_cm)) %>% 
  # Break names into two columns (first_name, last_name); use first space " " as delimiter
  ## too_many="merge": if more than one delim (space) is found, merge everything after the space into the second column
  ## too_few="align_start": if less than one delim is found, treat the name like a first name and make last_name NA
  ## notice where in the column order the new columns appear vs if you did this with a mutate 
  separate_wider_delim(name, delim=" ", names = c("first_name", "last_name"), too_many="merge", too_few = "align_start") %>% 
  # Change categorical variables (but currently character) to factors
  mutate(
    ## for the 2 detected levels of gender (feminine, masculine) relabel (i.e., rename/replace those values) with f & m
    gender = factor(gender, levels = c("feminine", "masculine"), labels = c("f", "m")),
    ## convert character values in species to all upper case before creating factor levels
    species = factor(str_to_upper(species)),
    homeworld = factor(homeworld)) %>% 
  # create a second height column by converting cm to inches
  mutate(height_in = height_cm*.3937) %>% 
  # where there is no value in hair, use value "bald"
  mutate(hair = factor(replace_na(hair, "bald"))) %>% 
  # create a logical variable that returns true if "brown" is anywhere in the string value for hair 
  mutate(brown_hair = str_detect(hair, "brown")) %>% 
  # create an initials column by concatenating the first characters of the first and last name
  ## str_sub(colname, 1, 1) -- the '1,1' bit means the first character to include is the one in position 1
  ## and the last is in position 1 (so just the first character)
  mutate(initials = paste0(str_sub(first_name, 1, 1), str_sub(last_name, 1, 1))) %>% 
  # move the new height_in column to be immediately left of the height_cm column 
  relocate(height_in, .before = height_cm) %>% 
  # move the new initials column to be immediately right of the last_name column
  relocate(initials, .after = last_name) %>% 
  # sort by last_name and then (when last_name matches) by first_name 
  arrange(last_name, first_name)

# this recreated dataset is a little different from mine

## Assignment 11
# plot 1
# check stats for height_cm
summary(sw.wrangled$height_cm)

# from my recreated dataset
ggplot(sw.wrangled) + 
  geom_histogram(aes(x = height_cm), binwidth = 10) + 
  labs(x = "height_cm", y = "count") +
  coord_cartesian(ylim = c(0,20)) +
  scale_y_continuous(breaks = seq(0,20, by = 5)) +
  coord_cartesian(xlim = c(50,275)) +
  scale_x_continuous(breaks = seq(50, 275, by = 50)) +
  theme_minimal()

# based on the recreated dataset given from answer
ggplot(sw.wrangled2) + 
  geom_histogram(aes(x = height_cm), binwidth = 10) + 
  labs(x = "height_cm", y = "count") +
  coord_cartesian(ylim = c(0,20)) +
  scale_y_continuous(breaks = seq(0,20, by = 5)) +
  coord_cartesian(xlim = c(50,275)) +
  scale_x_continuous(breaks = seq(50, 275, by = 50)) +
  theme_minimal()

# plot 2
# based on my recreated dataset
sw.wrangled %>%
  filter(!is.na(hair)) %>%
  group_by(hair) %>%
  ggplot(aes(x = forcats::fct_infreq(hair))) + 
  geom_bar() + 
  labs(x = "sorted_hair")

# based on the recreated dataset given from the answer
sw.wrangled2 %>%
  filter(!is.na(hair)) %>%
  group_by(hair) %>%
  ggplot(aes(x = forcats::fct_infreq(hair))) + 
  geom_bar() + 
  labs(x = "sorted_hair")
# this bar plot is exactly the same from the given plot 2

# plot 3
# based on my recreated dataset
sw.wrangled %>%
  filter(!is.na(height_in)) %>%
  filter(!is.na(mass)) %>%
  filter(mass < 160) %>%
  ggplot(aes(x = height_in, y = mass)) + 
  geom_point(shape = 17, size = 2) + 
  coord_cartesian(ylim = c(0,160)) +
  scale_y_continuous(breaks = seq(0,160, by = 40)) +
  coord_cartesian(xlim = c(20,90)) +
  scale_x_continuous(breaks = seq(20, 90, by = 20)) + 
  theme_minimal()

# based on the recreated dataset given from the answer
sw.wrangled2 %>%
  filter(!is.na(height_in)) %>%
  filter(!is.na(mass)) %>%
  filter(mass < 160) %>%
  ggplot(aes(x = height_in, y = mass)) + 
  geom_point(shape = 17, size = 2) + 
  coord_cartesian(ylim = c(0,160)) +
  scale_y_continuous(breaks = seq(0,160, by = 40)) +
  coord_cartesian(xlim = c(20,90)) +
  scale_x_continuous(breaks = seq(20, 90, by = 20)) + 
  theme_minimal()

## Assignment 12
# plot 1
sw.wrangled2 %>%
  filter(!is.na(mass)) %>%
  ggplot(aes(x = fct_infreq(hair), y = mass, fill = fct_infreq(hair))) +
  geom_boxplot() +
  scale_y_continuous(limits = c(10, 160)) +
  geom_point() +
  labs(x = "Hair color(s)", y = "Mass (kg)", fill = "Colorful hair") +
  theme_minimal()

# plot 2
sw.wrangled2 %>%
  filter(!is.na(height_in)) %>%
  mutate(brown_hair = factor(brown_hair)) %>%
  mutate(brown_hair = fct_recode(brown_hair, "No brown hair" = "FALSE", "Has brown hair" = "TRUE")) %>%
  mutate(brown_hair = fct_relevel(brown_hair, "Has brown hair")) %>%
  ggplot(aes(x = mass, y = height_in)) +
  geom_point() +
  facet_wrap(~ brown_hair, labeller = labeller(brown_hair = c("No brown hair" = "No brown hair", "Has brown hair" = "Has brown hair"))) +
  geom_smooth(method = "lm") +
  coord_cartesian(ylim = c(-10, 200)) +
  scale_y_continuous(breaks = c(-4, 20, 23, 80, 100, 200)) +
  scale_x_continuous(limits = c(-200, 200)) +
  labs(x = "mass", y = "height_in", title = "Mass vs. height by brown-hair-havingness", subtitle = "A critically important analysis") +
  theme_minimal()

# plot 3
sw.wrangled2 %>%
  filter(!is.na(gender)) %>%
  mutate(species_first_letter = substr(species, 1, 1)) %>%
  mutate(species_first_letter = reorder(species_first_letter, -as.numeric(factor(species_first_letter, levels = sort(unique(species_first_letter)))))) %>%
  group_by(gender, species_first_letter) %>%
  count() %>%
  ggplot(aes(x = n, y = species_first_letter, fill = gender)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(x = "count", y = "species_first_letter", caption = "A clear male human bias") +
  coord_cartesian(xlim = c(0,30)) +
  scale_x_continuous(breaks = seq(0, 30, by = 10)) +
  theme_classic()

