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

## 1.9 hw
# create a hypothetical file tree
# Define the file tree structure
# for R, data, and docs section, I reduced the file number into what I have on my computer
# for other sections, I keep these hypothetical files which I do not have for now, but I will have later on
file_tree <- "
/OCD
|-- R/
|   |-- R code.R
|-- data/
|   |-- ocd_patient_dataset.csv
|-- docs/
|   |-- README.md
|-- plots/
|   |-- OCD patients information analysis/
|       |-- plot1.png
|       |-- plot2.png
|-- results/
|   |-- OCD patients information analysis results.txt
|-- tests/
|   |-- test_script1.R
|   |-- test_script2.R
|-- .gitignore
|-- OCD.Rproj
"
# Specify the output file
output_file <- "README.md"
# Write the file tree to the README.md file
writeLines(file_tree, con = output_file)
# Print a message indicating success
cat("File tree has been written to", output_file, "\n")
