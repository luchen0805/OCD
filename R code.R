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
  if (day == "Tuesday" && weather == TRUE) {
    "I will take the bus to the school."
  } else if (day == "Tuesday" && weather == FALSE) {
    "I will walk to school."
  } else if (day != "Tuesday" && weather == TRUE) {
    "I will stay at home."
  } else {
    "I will do grocery shopping."
  }
}
hello_world(day = "Tuesday", weather = TRUE)
hello_world(day = "Tuesday", weather = FALSE)
hello_world(day = "Monday", weather = TRUE)
hello_world(day = "Monday", weather = FALSE)
