# Project-Analyzing-Students-Mental-Health

### Project Overview

Does going to university in a different country affect your mental health?

A Japanese international university surveyed its students in 2018 and published a study the following year that was approved by several ethical and regulatory boards.
The study found that **international students have a higher risk of mental health difficulties than the general population**, and that social connectedness (belonging to a social group) and acculturative stress (stress associated with joining a new culture) are predictive of depression.

To investigate these findings, I utilized PostgreSQL to analyze the study's data, focusing on the potential correlation between international students' length of stay and their average mental health diagnostic scores.

### Data Sources

The primary dataset used for this analysis is the "Student's mental.csv" file.

### Tools

SQL - Data Analysis

### EDA

EDA involved exploring the data to answer key question:

Does the length of stay impact the mental health of international students?

### Results/Finding

In conclusion, the analysis reveals that the length of stay does not significantly contribute to these factors. The correlation coefficients between "stay" and "avg_phq" (depression) and "avg_scs" (social connectedness) are 0.27 and 0.14, respectively. These values indicate weak correlations, suggesting that the length of stay does not strongly influence feelings of belonging to the native social group or levels of depression.

Conversely, the correlation coefficient between "stay" and "avg_as" (acculturative stress) is -0.64, reflecting a strong negative relationship. This implies that as the length of stay increases, acculturative stress tends to decrease. In other words, international students generally experience less stress related to cultural adjustment as they become more acclimated to their new environment over time.
