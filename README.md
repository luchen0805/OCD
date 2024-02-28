# OCD Patients Information Analysis

# **Brief description of the dataset**

The dataset is about the mixed information for OCD patients. It collects information on 1500 patients with obsessive-compulsive disorder (OCD), including variables like age, gender, race, marital status, education level, family history, medications, etc.. At the same time, the dataset also includes the classification of OCD symptoms. All these information can be used to analyze how OCD manifests itself in different patient groups.

# **Brief overview of the project**

## ***Abstract***

Chatacteristics of OCD patients are complicated. Their demographic information include a family history of OCD and education level, and their clinical diagnostic information include the occurrence of anxiety disorder and the Y-BOCS scores. In this paper, I examined how these factors are correlated. And more specifically, can education level and family history of OCD be used as factors to predict anxiety disorder? Is there a correlation between education level and Y-BOCS score? The findings showed that education level and family history of OCD cannot be used to predict anxiety disorder, and education level and Y-BOCS score are not correlated. The previous one is consistent with the results from other studies, but as another study shows, Y-BOCS score decreases with increasing education level. To further test the second finding, more studies are needed. And as this paper does not show any statistically significant correlation for these factors, genetic information may play a role. Future research could also look at the genes that associate with OCD.

## ***Research questions***

1. Can education level and family history of OCD predict the likelihood of having anxiety disorder?
2. Is there a pattern of Y-BOCS score distribution in different education levels?

# **Hypothetical file tree**

```{r}  
-- R  
   -- R code.R   
-- data  
   -- ocd_patient_dataset.csv  
-- docs  
   -- README.md
   -- OCD patients information analysis.Rmd  
-- plots  
   -- plot1 for anxiety-diagnosis-plot-1.png  
   -- plot2 for correlation-plot-1.png
   -- plot3 for score-plot-1.png
-- reference
   -- r-references.bib
-- .gitignore  
-- OCD.Rproj  
