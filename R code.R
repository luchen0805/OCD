options(repos = c(CRAN = "https://cran.rstudio.com/"))

# load necessary packages
library(Require)
library(papaja)
library(readr)
library(dplyr)
library(tidyr)
library(car)

Require("ggplot2")
Require("devtools")
Require("car")

# read in the dataset
data <- read.csv("ocd_patient_dataset.csv")

# examine the dataset
# str(data)

# It includes many variable columns that I don't need, and I don't want Patient.ID to represent patients, I want ordered patient numbers

# select specific variable columns that are related to my research questions
data <- select(data, Patient.ID, Education.Level, Family.History.of.OCD, Previous.Diagnoses, Y.BOCS.Score..Obsessions., Y.BOCS.Score..Compulsions., Anxiety.Diagnosis, Depression.Diagnosis)

# Now I have only these three variable columns that I need for the project with patient ID column
# For a more clear looking dataset, I want to replace these non-ordered patient ID with integers 1-1500
# I will remove Patient.ID column and create Patient.Number column as the first variable column

# create a new patient id column with ordered integers from 1 to 1500
new_patients_id <- 1:1500
data$Patient.ID <- new_patients_id

# export this new dataset
csv_file_path <- "final_data_prep.csv"
write.csv(data, csv_file_path)

# Now it's a concise dataset with every variable I need and ordered with patient numbers
# And I think it's good now for the next data analysis part

# each column is either a character or numeric number
# each row is a single observation for one patient
# each cell is a single measurement

## anxiety diagnosis plot
data %>%
  mutate(Education.Level = factor(Education.Level, levels = c("High School", "Some College", "College Degree", "Graduate Degree"))) %>%
  ggplot(aes(x = Education.Level, fill = Anxiety.Diagnosis)) +
  geom_bar(position = "fill") +
  facet_grid(Family.History.of.OCD ~ .) +
  labs(title = "Anxiety Diagnosis by Education Level and Family History of OCD",
       subtitle = "A prediction for anxiety disorder",
       x = "Education Level",
       y = "Proportion",
       fill = "Anxiety Diagnosis",
       caption = "Predict anxiety disorder through education Level and family history of OCD"
  ) +
  scale_fill_manual(values = c("Yes" = "purple", "No" = "blue")) +
  theme_minimal() +
  theme(axis.text = element_text(size = 8), # decrease the font size for axis labels
        axis.title.x = element_text(margin = margin(t = 10)), # increase the space between x-axis label and name
        axis.title.y = element_text(margin = margin(r = 10)), # increase the space between y-axis label and name
        plot.caption = element_text(hjust = 1, size = 5),
        plot.subtitle = element_text(hjust = 0.5), # in the middle
        plot.title = element_text(hjust = 0.5),
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 10))

# descriptive analysis
# calculate proportions for the facet where Family.History.of.OCD == "Yes"
proportions <- data %>%
  mutate(Education.Level = factor(Education.Level, levels = c("High School", "Some College", "College Degree", "Graduate Degree"))) %>%
  filter(Family.History.of.OCD == "Yes") %>%
  group_by(Education.Level, Anxiety.Diagnosis) %>%
  summarize(Count = n(), .groups = "drop") %>%
  group_by(Education.Level) %>%
  mutate(Proportion = Count / sum(Count))

# make an apa table
proportions_table <- apa_table(proportions,
                               caption = "Proportions of Anxiety Diagnosis by Education Level and Family History of OCD",
                               note = "Under the situation of having a family history of OCD",
                               align = c("l", "c", "c", "c"),  # Align columns
                               row.names = FALSE,  # Exclude row names
                               table.number = 1)
proportions_table

# calculate proportions for the facet where Family.History.of.OCD == "No"
proportions2 <- data %>%
  mutate(Education.Level = factor(Education.Level, levels = c("High School", "Some College", "College Degree", "Graduate Degree"))) %>%
  filter(Family.History.of.OCD == "No") %>%
  group_by(Education.Level, Anxiety.Diagnosis) %>%
  summarize(Count2 = n(), .groups = "drop") %>%
  group_by(Education.Level) %>%
  mutate(Proportion2 = Count2 / sum(Count2))

proportions2_table <- apa_table(proportions2,
                                caption = "Proportions of Anxiety Diagnosis by Education Level and Family History of OCD",
                                note = "Under the situation of not having a family history of OCD",
                                align = c("l", "c", "c", "c"),
                                row.names = FALSE,
                                table.number = 2)
proportions2_table

# test analysis
# recode Anxiety.Diagnosis to binary (0 and 1)
data$Anxiety.Diagnosis <- ifelse(data$Anxiety.Diagnosis == "Yes", 1, 0)

# convert 'Education.Level' to a factor with specified levels
data2 <- data %>%
  mutate(Education.Level = factor(Education.Level, levels = c("High School", "Some College", "College Degree", "Graduate Degree")))
data2$Education.Level <- factor(data2$Education.Level)
data2$Family.History.of.OCD <- factor(data2$Family.History.of.OCD)

# fit logistic regression model
logistic_model <- glm(Anxiety.Diagnosis ~ Education.Level + Family.History.of.OCD, data = data2, family = binomial) 
# anxiety is classified into yes or no, it fits the binary outcome, so it follows the binomial distribution

# summarize the logistic regression model
summary(logistic_model)
Anova(logistic_model)

## score correlation plot
data %>% 
  ggplot(aes(x = Y.BOCS.Score..Obsessions., y = Y.BOCS.Score..Compulsions.)) +
  geom_jitter() +
  geom_smooth() +
  labs(
    x = "Y-BOCS Score for Obsessions",
    y = "Y-BOCS Score for Compulsions",
    title = "Correlation Between Y-BOCS Scores for Obsessions and Compulsions"
  ) +
  theme_apa() +
  theme(text = element_text(size = 10),
        plot.title = element_text(size = 12, hjust = 0.5),
        plot.margin = unit(c(1, 1, 1, 1), "cm"))

## score education plot
# reshape data into long format, gather the variables "Y-BOCS Score Obsessions" and "Y-BOCS Score Compulsions" into one single column named "Score_Value", and a new column named "Score_Type" is created to indicate the type of score.
# convert data into long format
data_long <- data %>%
  pivot_longer(cols = c(Y.BOCS.Score..Obsessions., Y.BOCS.Score..Compulsions.), names_to = "Score_Type", values_to = "Score_Value")

# Create boxplots
data_long %>%
  mutate(Education.Level = factor(Education.Level, levels = c("High School", "Some College", "College Degree", "Graduate Degree"))) %>%
  ggplot(aes(x = Education.Level, y = Score_Value, fill = Education.Level)) +
  geom_boxplot() +
  facet_wrap(~ Score_Type, scales = "free_y", labeller = labeller(Score_Type = c("Y.BOCS.Score..Compulsions." = "Y-BOCS Score Compulsions", "Y.BOCS.Score..Obsessions." = "Y-BOCS Score Obsessions"))) +
  labs(
    x = "Education Level",
    y = "Y-BOCS Score",
    title = "Y-BOCS Scores for Different Education Levels",
    subtitle = "Subdivided into obsession score and compulsion score",
    caption = "Y-BOCS score and education levels"
  ) +
  theme_apa() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
        axis.text = element_text(size = 10),
        strip.text = element_text(size = 6),
        plot.caption = element_text(hjust = 1, size = 5))

# descriptive analysis
# Calculate summary statistics for each Score_Type and Education Level
summary_stats <- data_long %>%
  mutate(Education.Level = factor(Education.Level, levels = c("High School", "Some College", "College Degree", "Graduate Degree"))) %>%
  group_by(Score_Type, Education.Level) %>%
  summarize(
    mean_score = mean(Score_Value),
    median_score = median(Score_Value),
    min_score = min(Score_Value),
    max_score = max(Score_Value),
    sd_score = sd(Score_Value),
    .groups = "drop"  # Override grouped output
  )
summary_stats

# test analysis
# ANOVA
# Perform ANOVA for Obsessions
obsessions_anova <- aov(Score_Value ~ Education.Level, data = data_long[data_long$Score_Type == "Y.BOCS.Score..Obsessions.", ])

# Perform ANOVA for Compulsions
compulsions_anova <- aov(Score_Value ~ Education.Level, data = data_long[data_long$Score_Type == "Y.BOCS.Score..Compulsions.", ])

# Summarize ANOVA results
summary(obsessions_anova)
summary(compulsions_anova)
