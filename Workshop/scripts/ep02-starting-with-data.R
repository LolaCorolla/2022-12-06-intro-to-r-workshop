#   _____ _             _   _                        _ _   _       _____        _        
#  / ____| |           | | (_)                      (_| | | |     |  __ \      | |       
# | (___ | |_ __ _ _ __| |_ _ _ __   __ _  __      ___| |_| |__   | |  | | __ _| |_ __ _ 
#  \___ \| __/ _` | '__| __| | '_ \ / _` | \ \ /\ / | | __| '_ \  | |  | |/ _` | __/ _` |
#  ____) | || (_| | |  | |_| | | | | (_| |  \ V  V /| | |_| | | | | |__| | (_| | || (_| |
# |_____/ \__\__,_|_|   \__|_|_| |_|\__, |   \_/\_/ |_|\__|_| |_| |_____/ \__,_|\__\__,_|
#                                    __/ |                                               
#                                   |___/                                                
#
# Based on: https://datacarpentry.org/R-ecology-lesson/02-starting-with-data.html


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Downloading, reading, and inspecting the data
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Lets download some data (make sure the data folder exists)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

#load the tidyverse library
library(tidyverse)

# now we will read this "csv" into an R object called "surveys"
surveys <- read_csv("data_raw/portal_data_joined.csv")


# and take a look at it
head(surveys) # first 6 rows
tail(surveys) # last 6 rows
view(surveys) # shows data frame

# BTW, we assumed our data was comma separated, however this might not
# always be the case. So we may been to tell read.csv more about our file.



# So what kind of an R object is "surveys" ?
class(surveys)


# ok - so what are dataframes ?
str(surveys)


# --------------------
# Exercise/Challenge
# --------------------
#
# What is the class of the object surveys?
#
# Answer: Data frame


# How many rows and how many columns are in this survey ?
#
# Answer:
nrow(surveys)


# Bonus functions 
names(surveys)
colnames(surveys)
summary(surveys) # basic stats per column

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Sub-setting
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# data_frame[row, column]
# first element in the first column of the data frame (as a vector)
surveys[1, 1]

# first element in the 6th column (as a vector)
surveys[1, 6]

# first column of the data frame (as a vector)
surveys[ , 1]

# first column of the data frame (as a data frame)
surveys$record_id # same as surveys[[record_id]]

# first row (as a data frame)
surveys[1, ]

# first three elements in the 7th column (as a vector)
surveys[1:3, 7]

# the 3rd row of the data frame (as a data.frame)
surveys[3, ]

# equivalent to head(metadata)
surveys[1:6, ]

# looking at the 1:6 more closely
1:6

# we also use other objects to specify the range
surveys[c(2, 4, 6), ] # even rows

# We can omit (leave out) columns using '-'
surveys[, -1 ] # omits first column

# --------------------
# Exercise/Challenge
# --------------------
#Using slicing, see if you can produce the same result as:
#
#   head(surveys)
#
# i.e., print just first 6 rows of the surveys dataframe
#
# Solution:
surveys[1:6, ]
surveys[- (7:nrow(surveys)), ]

# column "names" can be used in place of the column numbers and $ operator to isolate
surveys["month"]
date_1 <- surveys[ , c("month", "year")]

surveys[["species_id"]] # same as surveys$species_id
surveys["species_id"]

# --------------------
# Exercise/Challenge
# --------------------

#Bonus functions:
mean()
table()

# What's the average weight of survey animals
mean(surveys$weight) # not working due to NAs
mean(surveys$weight, na.rm = T) # also can do with summary()

# Answer: 42.67243



# Are there more Birds than Rodents ?
table(surveys$taxa)

# Answer: Y



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic: Factors (for categorical data)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

summary(surveys$sex) # is a character
# Turning characters into levels
surveys$sex <-  factor(surveys$sex) # 2 levels, F and M
summary(surveys$sex) # now a factor

# factors that have an order
temperature <- factor(c("hot", "cold", "hot", "warm"))
levels(temperature) # "cold" "hot"  "warm"

temperature <- factor(temperature, levels = c("hot", "cold", "warm"))
levels(temperature) # "hot"  "cold" "warm"
nlevels(temperature)

# --------------------
# Exercise/Challenge
# --------------------
#   1. Change the columns taxa and genus in the surveys data frame into a factor.
#   2. Using the functions you learned before, can you find out…
#        a. How many rabbits were observed? 75
#        b. How many different genera are in the genus column? 26

surveys$taxa <- factor(surveys$taxa)
surveys$genus <- factor(surveys$genus)

table(surveys$taxa) # 75
nlevels(surveys$genus) # 26

summary(surveys)

# Converting factors to numeric
year <- factor(c(1990, 1983, 1977, 1998, 1990))
# can be tricky if the levels are numbers
as.numeric(year) # assigned numbers in order of earlier to latest
as.character(year)

as.numeric(as.character(year))
as.numeric(levels(year))

# so does our survey data have any factors

# Renaming factors
plot(surveys$sex) # does not show NAs
summary(surveys$sex)

sex <- surveys$sex
sex <- addNA(sex) # adds NAs to empty space
levels(sex) # now has NAs
head(sex)

levels(sex)[3] <-  "Undetermined" # renames NA level to undetermined
levels(sex)[2] <-  "Male"
levels(sex)[1] <-  "Female"

levels(sex) <- c("F", "M", "U") # to rename all at once

levels(sex)

plot(sex)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Topic:  Dealing with Dates
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# R has a whole library for dealing with dates ...
library(lubridate)


# R can concatenated things together using paste()


# 'sep' indicates the character to use to separate each component


# paste() also works for entire columns


# let's save the dates in a new column of our dataframe surveys$date 


# and ask summary() to summarise 


# but what about the "Warning: 129 failed to parse"


