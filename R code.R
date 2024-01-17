## 1.4 in class
# install tidyverse
options(repos=c(CRAN="https://cran.rstudio.com"))
library(tidyverse)
require("tidyverse") # cannot continue unless you have installed this package

## 1.4 hw
# install TinyTex
library(tinytex)

# install Tinylabels
library(tinylabels)

# install papaja
# install latest CRAN release
library(papaja)
# install remotes package if necessary
if(!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
# install the stable development version from GitHub
remotes::install_github("crsh/papaja")

# install ggplot for data visualization
library(ggplot2)

# install readrR for reading data from different types of files
library(readr)

# assign numeric variable
numeric_variable1 <- 5
numeric_variable2 <- 8
# check the value
print(numeric_variable1)
print(numeric_variable2)

# assign string/character variable
string_variable1 <- "hello world"
string_variable2 <- "I love R"
# check the value
print(string_variable1)
print(string_variable2)

# create a dataframe
data <- data.frame(
  Name = c("Jon","Bill","Maria","Tina"),
  Age = c(12,23,34,45)
)
# check and print the dataframe
print(data)

# create a hello_world function
helloworld <- function(name) {
  # Print a greeting based on `name`
  paste0("Hello", name, "!")
}

# example demo from class
# if there are eggs
eggs <- TRUE
# number of milk for buying
n.milk <- ifelse(eggs == TRUE, yes = 6, no = 1)

shop2 <- function(milk, eggs) {
  if (milk == TRUE && eggs == TRUE) {
    n.milk <- 3
  } else if (milk == FALSE && eggs == TRUE) {
    n.milk <- 0
  } else if (milk == TRUE && eggs == FALSE) {
    n.milk <- 1
  } else {
    n.milk <- 0
  }
  return(n.milk)
} # shop2(FALSE, FALSE) will return n.milk value of 0

# assignment 4
# create a hello_world function
snow <- TRUE

hello_world <- function(day, weather) {
  if (day == "Tuesday" && weather == TRUE) { # if it is Tuesday and it snows
    "I will take the bus to the school."
  } else if (day == "Tuesday" && weather == FALSE) { # if it is Tuesday and it dose not snow
    "I will walk to school."
  } else if (day != "Tuesday" && weather == TRUE) { # if it is not Tuesday and it snows
    "I will stay at home."
  } else { # if it is not Tuesday and it does not snow
    "I will do grocery shopping."
  }
}

hello_world(day = "Tuesday", weather = TRUE) # Tuesday and snow
hello_world(day = "Tuesday", weather = FALSE) # Tuesday and no snow
hello_world(day = "Monday", weather = TRUE) # not Tuesday and snow
hello_world(day = "Monday", weather = FALSE) # not Tuesday and no snow

# create a while loop
i <- 1
while (i <= 9) { # while i is equal to and smaller than 8
  print(i)
  i <- i+2 # add 2 to the value of i
}

## 1.16 in class
# clone d2m-2024 repo
# find excel spreadsheet
library(readxl)
mmdata <- read_excel("iCloud Drive/Desktop/UChicago/Winter 2024/MAPS 30550/OCD")
read_excel("MM Data.xlsx")
# what about this file creates problems when you read-in & how would you fix the issue
# escape row 1?
# magrittr %>% is used to create some data/change it with function X/Y...
# tidy transformation dplyr (filter(), select(), arrange(), mutate(), group_by(), summarize())

## assignment 6
# load readr package
library(readr)
# read in the dataset
OCD.data <- read.csv("ocd_patient_dataset.csv")
OCD.data
# examine the dataset
str(OCD.data)
# each column is either a character or numeric number
# each row is a single observation for one patient
# each cell is a single measurement
# for research questions about the association of the prevalence of OCD with education level, family history of OCD, and previously diagnosed disorders,
# only the column "Education Level", "Family History of OCD", and "Previous Diagnoses" are needed, all the other columns are extraneous
# create an intermediate dataset
# choose specific columns that are related to my research questions
library(dplyr)
filter(OCD.data, Education.Level == "High School" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")
filter(OCD.data, Education.Level == "Some College" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")
filter(OCD.data, Education.Level == "College Degree" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")
filter(OCD.data, Education.Level == "Graduate Degree" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")
# select only the columns I need
select(OCD.data, Education.Level, Family.History.of.OCD, Previous.Diagnoses)
# intermediate dataset for High school educated patients with family history of OCD and does not be diagnosed with other disorders before
intermediate.OCD.data <- OCD.data %>%
  select(Education.Level, Family.History.of.OCD, Previous.Diagnoses) %>%
  filter(Education.Level == "High School" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")
csv_file_path <- "intermediate_ocd_data.csv"
write.csv(intermediate.OCD.data, csv_file_path)
