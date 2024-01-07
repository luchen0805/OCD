## 1.4 in class
# install tidyverse
install.packages("tidyverse")
library(tidyverse)
require("tidyverse") # cannot continue unless you have installed this package

## 1.4 hw
# install TineyTex
if(!requireNamespace("tinytex", quietly = TRUE)) install.packages("tinytex")
tinytex::install_tinytex()
library(tinytex)

# install papaja
# install latest CRAN release
install.packages("papaja")
library(papaja)
# install remotes package if necessary
if(!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
# install the stable development version from GitHub
remotes::install_github("crsh/papaja")

# install ggplot for data visualization
install.packages("ggplot2")
library(ggplot2)

# install readrR for reading data from different types of files
install.packages("readr")
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
