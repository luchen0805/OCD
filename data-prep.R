# Research question 1 "Is there a significant difference in the prevalence of OCD among individuals with varying levels of education?"
# Potential graph: bar chart for the prevalence of OCD among individuals with 4 education level groups
# Statistical analysis: chi-square test p-value to assess whether the differences in OCD prevalence across education levels are statistically significant

# Research question 2 "Does the family history of OCD contribute to the development of the OCD disorder?"
# Potential graph: pie chart for the distribution of individuals with and without a family history of OCD
# Statistical analysis: logistic regression analysis p-value to assess the statistical significance of the association

# Research question 3 "Are patients previously diagnosed with other disorders more likely to develop OCD?"
# Potential graph: pie chart for the distribution of individuals with and without a history of other disorders
# Statistical analysis: logistic regression analysis p-value to assess the statistical significance of the association

# load readr package
library(readr)

# read in the dataset
OCD.data <- read.csv("ocd_patient_dataset.csv")

# examine the dataset
str(OCD.data)

# It includes many variable columns that I don't need and I don't want Patient.ID to represent patients, I want ordered patient numbers

# select specific variable columns that are related to my research questions
library(dplyr)
OCD.data <- select(OCD.data, Patient.ID, Education.Level, Family.History.of.OCD, Previous.Diagnoses)
OCD.data

# Now I have only these three variable columns that I need for the project with patient ID column
# For a more clear looking dataset, I want to replace these non-ordered patient ID with integers 1-1500
# I will remove Patient.ID column and create Patient.Number column as the first variable column

# create a new variable "patient number" with ordered integers
OCD.data <- OCD.data %>%
  mutate(Patient.Number = match(Patient.ID, unique(Patient.ID))) %>%
  select(Patient.Number, everything(), -Patient.ID)
OCD.data

# export this new dataset
csv_file_path <- "exact_OCD_data.csv"
write.csv(OCD.data, csv_file_path)

# Now it's a concise dataset with every variable I need and ordered with patient numbers
# And I think it's good now for the next data analysis part

# Below is from Assignment 6 about creating sub-datasets based on subgroups of variables, I will leave it here for now, but may not need for data analysis
# keep rows based on certain column values
# High school as education level, has family history of OCD, and does not be previously diagnosed
filter(OCD.data, Education.Level == "High School" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")

# combine the two
# intermediate dataset for High school educated patients with family history of OCD and does not be diagnosed with other disorders before
intermediate.OCD.data <- OCD.data %>%
  select(Education.Level, Family.History.of.OCD, Previous.Diagnoses) %>%
  filter(Education.Level == "High School" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")
intermediate.OCD.data

# write into csv filetype
csv_file_path <- "intermediate_ocd_data.csv"
write.csv(intermediate.OCD.data, csv_file_path)