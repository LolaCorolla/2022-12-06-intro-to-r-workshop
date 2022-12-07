#
#   __        __         _    _                        _ _   _       ____        _        
#   \ \      / /__  _ __| | _(_)_ __   __ _  __      _(_) |_| |__   |  _ \  __ _| |_ __ _ 
#    \ \ /\ / / _ \| '__| |/ / | '_ \ / _` | \ \ /\ / / | __| '_ \  | | | |/ _` | __/ _` |
#     \ V  V / (_) | |  |   <| | | | | (_| |  \ V  V /| | |_| | | | | |_| | (_| | || (_| |
#      \_/\_/ \___/|_|  |_|\_\_|_| |_|\__, |   \_/\_/ |_|\__|_| |_| |____/ \__,_|\__\__,_|
#                                     |___/                                               
#
#          _   _     _               _____ _     _                               
#         | | | |___(_)_ __   __ _  |_   _(_) __| |_   ___   _____ _ __ ___  ___ 
#         | | | / __| | '_ \ / _` |   | | | |/ _` | | | \ \ / / _ \ '__/ __|/ _ \
#         | |_| \__ \ | | | | (_| |   | | | | (_| | |_| |\ V /  __/ |  \__ \  __/
#          \___/|___/_|_| |_|\__, |   |_| |_|\__,_|\__, | \_/ \___|_|  |___/\___|
#                            |___/                 |___/                         
#
#   Based on: https://datacarpentry.org/R-ecology-lesson/03-dplyr.html


#
# Learning Objectives
#

#    Get started with dplyr and tidyr packages from the TidyVerse
#    Extract columns from data frames using select()
#    Extract rows data frames filter()
#    Link the output of one dplyr function to the input of another function with the ‘pipe’ operator
#    Add new columns to data frames using functions of existing columns with mutate()
#    Use summarize(), group_by(), and count() to split a data frame into groups of observations, 
#    Apply summary statistics to groups
#    Understand wide vs long table formats and why these formats are useful
#    Describe key-value pairs
#    Reshape a data frame from long to wide format and back with the pivot_wider() and pivot_longer()
#    Save a data frames to .csv files



# Data is available from the following link (we should already have it)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")


# Read some data from a CSV file
s <- read.csv("data_raw/portal_data_joined.csv")

# lets remind ourselves what the data frame looks like with str(), view() etc ...
str(s)


#        _       _            
#     __| |_ __ | |_   _ _ __ 
#    / _` | '_ \| | | | | '__|
#   | (_| | |_) | | |_| | |   
#    \__,_| .__/|_|\__, |_|   
#         |_|      |___/      
#
# https://dplyr.tidyverse.org/


# Load up the required "dplyr" library from the TidyVerse
library(dplyr)

#
# Some common dplyr functions - select(), filter(), mutate(), group_by(), summarize()
#

#
# select() - subset of columns (variables)
#
select(s, year)

# include particular columns: eg plot_id, species_id and weight
select(s, plot_id, species_id, weight)
select(s, c(plot_id, species_id, weight))

# exclude particular columns, eg record_id and species_id using a '-'
select(s, -record_id, -species_id)


#
# filter() - subset of rows (observations)
#

# all rows where year is 1995
filter(s, year == 1995)

# oldest year observation rows (hint max(year, ))
filter(s, year == max(year))
filter(s, max(year) == year) # also works in reverse
filter(s, year >= mean(year))

# longest hindfoot_length
max(s$hindfoot_length, na.rm = T)
max(s$hindfoot_length[!is.na(s$hindfoot_length)])
# !is.na gives T or F results, getting the max of that will be T == 1
# so the T needed to be indexed [], giving the max of all the rows that are T

#
# Pipes - plumbing thing together to create pipelines
#

# using temp data frames, get rows where weight greater than 5 and
# show only species_id, sex and weight
filter(s, weight > 5)
select(s, species_id, sex, weight)

select(filter(s, weight > 5), species_id, sex, weight)
# and we can store/assign the final result to an object
f <- select(filter(s, weight > 5), species_id, sex, weight)

#
# CHALLENGE 1
#

# Using pipes, subset 's' data frame to extract animals collected
# before 1995 and retain only the columns called year, sex, and weight.
filter(s, year < 1995) %>%
  select(year, sex, weight)

s %>%
  filter(year < 1995) %>%
  select(year, sex, weight)

subset <- s %>%
  filter(year < 1995) %>%
  select(year, sex, weight)

#
# mutate() - add columns to a data frame
#


# lets add a column called weight_kg by dividing the weight by 1000
mutate(s, weight_kg = weight/1000)

s %>% 
  mutate(weight_kg = weight/1000)

# we can also add multiple columns at the same time
# ie, we cloud also add weight_lb by multiplying by 2.2
s %>%
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2)
# can modify new columns within pipe,
# provided that they already exists/are in a line above

# using head() can be useful now
s %>%
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  head() # first 6 records

s %>%
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  head(10) # first 10 records

s %>%
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2) %>% 
  tail(10) %>% # last 10 records
  head(1) # only shows the first records of those last 10 records above

# NA means "not available". We check is a data value is NA with the
# function is.na() and ! means 'not'
is.na(s$weight)

#
# CHALLENGE 2
#

# Create a new data frame from the surveys data frame that meets the following criteria:
#
# contains only the species_id column and a new column called hindfoot_cm containing 
# the hindfoot_length  values in millimeters converted to centimeters.
#
# The hindfoot_cm column, should have no NA's and all values need to be less than 3.
#
# Hint: think about how the commands should be ordered to produce this data frame!
f <- s %>% 
  mutate(hindfoot_cm = hindfoot_length / 10) %>% 
  filter(hindfoot_cm != is.na(hindfoot_cm), # not needed
         hindfoot_cm < 3) %>% 
  select(species_id, hindfoot_cm)

f <- s %>% 
  mutate(hindfoot_cm = hindfoot_length / 10) %>% 
  filter(!is.na(hindfoot_cm),
         hindfoot_cm < 3) %>% 
  select(species_id, hindfoot_cm)

f <- s %>% 
  mutate(hindfoot_cm = hindfoot_length / 10) %>% 
  filter(hindfoot_cm < 3) %>% # is.na redundant because NAs cannot be < 3
  select(species_id, hindfoot_cm)

#
# group_by() - collect like things together to allow us to summarise them
#
s %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# we can include multiple group_by variables, eg species_id
s %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# NaN = not a number, impossible calculation

#
# count() - how many observerations for each (or combinations of) variables(s)
#

# count how many observations of each year

# equivalent to a group_by() and then using the n() function as a summary

# and it also has a sort = TRUE option

# or we could use the arrange() instead


#
# CHALLENGE 3
#

# 1. How many animals were caught in each plot_type surveyed? 


# 2. Use group_by() and summarize() to find the mean, min, and max hindfoot length 
#    for each species (using species_id). 
#
#    Also include the number of observations for each group (hint: see ?n )


# 3. What was the heaviest animal measured in each year? 
#    Return the columns ```year```, ```genus```, ```species_id```, and ```weight```.




#    _   _     _            
#   | |_(_) __| |_   _ _ __ 
#   | __| |/ _` | | | | '__|
#   | |_| | (_| | |_| | |   
#    \__|_|\__,_|\__, |_|   
#                |___/      
#
# https://tidyr.tidyverse.org/

library(tidyr)

#
# Reshaping Data frames - wide vs tall and pivoting between them
#

# A "Wide" data frame
#
#
#     day   tesla  ford   kia mazda    <---- Names
#     -----------------------------
#     sat       2     1     3     6    <---- Values
#     sun      63    71    95    12    <---- Values
#          
#

cars_wide <- data.frame (
  day   = c("sat", "sun"),
  tesla = c(2, 63),
  ford  = c(1,71),
  kia   = c(3, 95),
  mazda = c(6,12)
) 
  

# Same information represented in a "Long" dataframe
#
#          Key   Value
#
#     day  make  qty
#    +----+-----+----+
#     sat  tesla  2
#     sun  tesla  63
#
#

# tidyr's pivot_longer() can do this for us
# flips data frame too so that x also becomes a variable
cars_long <- cars_wide %>%
  pivot_longer(names_to = "make",
               # names are the column names
               # put the col names as another variable in a new column
               # "make" is a new column, so it needs ""
               values_to = "qty",
               # values are the values inside
               # puts them all in a new column called qty
               # also needs "" due to new column name
               cols = -day)
# excludes the column day from the pivoting process
# so it is still its own column, does not need "" as it already exists

# and the reverse 
cars_long %>%
  pivot_wider(names_from = make,
              # the values in column make are going to be column names
              values_from = qty,
              # the values in column qty are going to become the values
              )

# now we can apply to our surveys data
surveys_long <- s %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarize(mean_weight = mean(weight))

# and reshape wider


#
# CHALLENGE 4 
#

# 1. Spread the surveys data frame with year as columns, plot_id as rows, 
#    and the number of genera per plot as the values. You will need to summarize before reshaping, 
#    and use the function n_distinct() to get the number of unique genera within a particular chunk of data. 
#    It’s a powerful function! See ?n_distinct for more.


# 2. Now take that data frame and pivot_longer() it again, so each row is a unique plot_id by year combination.


# 3. The surveys data set has two measurement columns: hindfoot_length and weight. 
#    This makes it difficult to do things like look at the relationship between mean values of each 
#    measurement per year in different plot types. Let’s walk through a common solution for this type of problem. 
#    First, use pivot_longer() to create a dataset where we have a key column called measurement and a value column that 
#    takes on the value of either hindfoot_length or weight. 
#    Hint: You’ll need to specify which columns are being pivoted.


# 4. With this new data set, calculate the average of each measurement in each year for each different plot_type. 
#    Then pivot_wider() them into a data set with a column for hindfoot_length and weight. 
#    Hint: You only need to specify the key and value columns for pivot_wider().




#
# Exporting data
#

# lets use write_csv() to save data in our data_out folder




#    _____           _          __   _____ ____   ___ _____ 
#   | ____|_ __   __| |   ___  / _| | ____|  _ \ / _ \___ / 
#   |  _| | '_ \ / _` |  / _ \| |_  |  _| | |_) | | | ||_ \ 
#   | |___| | | | (_| | | (_) |  _| | |___|  __/| |_| |__) |
#   |_____|_| |_|\__,_|  \___/|_|   |_____|_|    \___/____/ 
#                                                           




# save files

# commit files to git

# push commit to github
