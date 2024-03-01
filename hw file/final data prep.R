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
data <- read.csv("ocd_patient_dataset.csv")

# examine the dataset
str(data)

# It includes many variable columns that I don't need, and I don't want Patient.ID to represent patients, I want ordered patient numbers

# select specific variable columns that are related to my research questions
library(dplyr)
data <- select(data, Patient.ID, Education.Level, Family.History.of.OCD, Previous.Diagnoses)
data

# Now I have only these three variable columns that I need for the project with patient ID column
# For a more clear looking dataset, I want to replace these non-ordered patient ID with integers 1-1500
# I will remove Patient.ID column and create Patient.Number column as the first variable column

# create a new patient id column with ordered integers from 1 to 1500
new_patients_id <- 1:1500
data$Patient.ID <- new_patients_id
data

# export this new dataset
csv_file_path <- "final_data_prep.csv"
write.csv(data, csv_file_path)

# Now it's a concise dataset with every variable I need and ordered with patient numbers
# And I think it's good now for the next data analysis part

# Below is from Assignment 6 about creating sub-datasets based on subgroups of variables, I will leave it here for now, but may not need for data analysis
# keep rows based on certain column values
# High school as education level, has family history of OCD, and does not be previously diagnosed
filter(data, Education.Level == "High School" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")

# combine the two
# intermediate dataset for High school educated patients with family history of OCD and does not be diagnosed with other disorders before
intermediate.data <- data %>%
  select(Education.Level, Family.History.of.OCD, Previous.Diagnoses) %>%
  filter(Education.Level == "High School" & Family.History.of.OCD == "Yes" & Previous.Diagnoses == "None")
intermediate.data

# write into csv filetype
csv_file_path <- "intermediate_data.csv"
write.csv(intermediate.data, csv_file_path)

## plot
# calculate frequency of each education level
education_table <- table(data$Education.Level)
education_table

# calculate proportion of each education level
proportion_education_level <- prop.table(education_table)
proportion_education_level

# draw
library(ggplot2)
ggplot(data, aes(x = Education.Level)) +
  geom_bar()

# calculate frequency of with/without family history
family_history_table <- table(data$Family.History.of.OCD)
family_history_table

# calculate proportion
proportion_family_history <- prop.table(family_history_table)
proportion_family_history

# draw
pie(proportion_family_history, labels = data$Family.History.of.OCD, main = "Family history of OCD distribution")

ggplot(data) + 
  geom_bar(aes(x = Education.Level)) + 
  theme_minimal()

# frequency of OCD by education level and family history
ggplot(data, aes(x = Education.Level, fill = Family.History.of.OCD)) +
  geom_bar(position = "dodge", color = "black") +
  scale_fill_manual(values = c("Yes" = "purple", "No" = "blue")) + 
  labs(
    x = "Education Level",
    y = "Frequency",
    fill = "Family History of OCD",
    title = "Distribution of OCD by Education Level"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# frequency of OCD by education level and previous diagnoses
diagnoses_count <- table(data$Previous.Diagnoses)
ggplot(data, aes(x = Education.Level, fill = Previous.Diagnoses)) +
  geom_bar() +
  labs(
    x = "Education Level",
    y = "Frequency of OCD",
    fill = "Previous Diagnoses",
    title = "Frequency of OCD by Education Level and Previous Diagnoses"
  ) +
  theme_minimal()

# ANOVA for each individual diagnoses

data$Previous.Diagnoses_Group <- ifelse(data$Previous.Diagnoses == "none", "none", "other diseases")
ggplot(data, aes(x = Education.Level, fill = Previous.Diagnoses_Group)) +
  geom_bar() +
  labs(
    x = "Education Level",
    y = "Frequency of OCD",
    fill = "Previous Diagnoses",
    title = "Frequency of OCD by Education Level and Previous Diagnoses"
  ) +
  theme_minimal()

## questions to ask
# is this frequency of OCD by education level and family history okay? informative?
# for a second type of graph, what to plot? if scatterplot for association, there's no numeric values
# 3 plots in total, can the two be the same type? check if frequency of OCD by education level and previous diagnoses plot is fine
