library(dplyr)

titanic <- read.csv("titanic_original.csv", header = TRUE)
names(titanic)

## Replace blank embarkations with "S"
titanic <- titanic %>% mutate(embarked = replace(embarked, embarked=="", "S"))

# Calculate median age and use that to populate missing values
medianAge <- median(titanic$age, na.rm = TRUE)
is.na(titanic$age)
library(Hmisc)
titanic$age <- impute(titanic$age, median)

# Fill empty lifeboat values with "NA"
is.na(titanic$boat)
titanic$boat[titanic$boat==""] <- NA
titanic$boat

# Create new variable to establish whether cabin number exists
is.na(titanic$cabin)
titanic$has_cabin_number <- ifelse(titanic$cabin=="", 0, 1)

write.csv(titanic, "titanic_clean.csv")
