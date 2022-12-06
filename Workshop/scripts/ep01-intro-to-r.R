#    ___       _               _          ____  
#   |_ _|_ __ | |_ _ __ ___   | |_ ___   |  _ \ 
#    | || '_ \| __| '__/ _ \  | __/ _ \  | |_) |
#    | || | | | |_| | | (_) | | || (_) | |  _ < 
#   |___|_| |_|\__|_|  \___/   \__\___/  |_| \_\
# 
#   Derived from: https://datacarpentry.org/R-ecology-lesson/01-intro-to-r.html

#
# Topic: Basic Calculations and using Objects
#


# R can do sums ...
3 + 5
12 / 7
3 ** 2 # power of
3 ^ 2 # power of

# other operators
#
# - * / ** ^ ( )


# 
# Exercises
#

# What does: 11 + 1 / 6  evaluate to ?
11 + 1 / 6

# Solution: 11.16667 - its a double or floating point number


# Calculate 10 plus 2 all divided by 3 and then squared
((10 + 2)/3)^2
# Solution: 16


# Storing values
a <- 3              # assign the number 3 to OBJECT (variable) called "a"
b <- 5              # assign 5 to b

a                   # so what's the value of OBJECT "a"
b                   # ... and what's b

a + b               # we can add them together just like numbers

# --------
# Exercise
# --------
#
# What happens if we change a and then re-add a and b? [Hint: Try it now]
#
# Does it work if you just change a in the script and then add a and b? [Hint: Try it]
#
# Did you still get the same answer after you changed a? 
# If so, why do you think that might be?
#
# We can also assign the result of a + b to a new variable, c. 
# How would you do this?
#
# Solution:
c <- a + b
a <- 100
# changing a does not automatically change c, c needs to be re-run to change

# Logical operators - T or F
#
# == != < > >= <= !
1 < 124
! 1 > 4 # 1 is NOT bigger than 4 = T

#
# Sensible object names are sensible ...
#
date_of_birth <- 7
z <- 19.5
THEMOL <- 42
camelCaseIsGenerallyNotRecommended <- "Unless you follow Google's Style guide"
names_that_are_unreasonably_long_are_not_a_good_idea <- "correct"
nouns_are_good <- TRUE
TRUE <- 17
ekljre2jklwef023ijlefj93jkl23rj90f32k <- 1
1_good_name <-  "cannot start with numbers"

# 
# Exercise
# 
#
# Assign the name of this workshop to an object with a good name.
#
# Solution: [Hint:       <- "Introduction to R"]
workshop_name <- "Introduction to R"

# Assign the name of video conferencing tool to an object
#
# Solution: [Hint:      <- "Zoom"]


# Which of these are valid object names: [Hint: Try them out]
#
#  min_height
#  max.height
#  _age             INVALID
#  .mass            Creates sub-object, not variable object
#  MaxLength
#  min-length       INVALID (R thinks min and length are being subtracted)
#  2widths          INVALID
#  celsius2kelvin


#
# Topic: Displaying results
#

weight_lb <- 55    # doesn't print anything
(weight_lb <- 55)  # but putting parenthesis () around and expression makes it display
weight_lb          # and so does typing the name of the object

# There are 2 and a bit pounds in a kilogram 
#
# 2.20462 * weight_lb
# weight_lb <- 57.5
# weight_kg <- 2.20462 * weight_lb
#

# 
# Exercise
# 
# 
# What are the values after each statement in the following?
# 
mass <- 47.5            # mass is: 47.5
age  <- 122             # age is: 122
mass <- mass * 2.0      # mass is: 95
age  <- age - 20        # age is: 102
mass_index <- mass/age  # mass_index is: 0.9313725
#
# How do we do we know if our answers are correct ? 
# [Hint: <highlight> [ALT][ENTER]

#
# Topic: Comments
#

# Comments (like this one) are usually helpful

     # they can also be indented

# They should be supportive (not redundant e.g. "this is a comment")

# 
# Exercise
# 
#
# Add explanatory comments to the following lines of code
#

ft <- 3 # 3 feet
in <- ft * 12 # convert to inches
cms <- in * 2.54 # convert to cm
m = cms / 100 # convert to m

#
# Topic: Functions and Arguments
#
# Square Root:  sqrt()
#

# arguments can be constants of objects

# Absolute Value: abs()
# 
# Decimal rounding: round(3.14159)


# Built-in constants: eg, pi

# Getting help about particular functions 
#
# Question: Mark followed by function name, eg: ?round

# or if we just want to know about the arguments, use: args()
args(round)
round(pi, digits = 8)
round(456.54466, digits = -1)
round(456.54466, digits = -2)

# Argument have default order - but can re-ordered using names
#
# round(3.14159, 2)
# round(digits = 2, x = 3.14159)

#
# Exercise
#
# what does the function called log10() do ?  Can you test it ?
#
# Answer:
?log10
log10(1000)

#
# Topic: Vectors and Data Types

# Combine some values in a 'vector'
#
# c(value, value, value ...)
#
# Let's assign the following numbers to an object called glengths:
#
#  4.6, 3000, 50000
glengths <- c(4.6, 3000, 50000)

# and repeat to create a vector of species
#
#  "ecoli", "human", "corn"
species <- c("ecoli", "human", "corn")

# use length() to obtain how many elements a vector contains
length(species)

# we can also ask what structure of our vectors look like with str()
str(species)

# and also see what class they are with class()
class(species)

# and btw, there are other classes as well ...
#
# sqrt_of_minus_one <- sqrt(-1+0i)
# true_or_false_value <- TRUE
# decimal_number = 54.0
# whole_number = -54L

#
# Once we have some vectors, we can apply operations to them as a whole
#

# multiply glengths by 5
glengths * 5
# add glength to itself
glengths + glengths

# appending and prepending elements to a vector
#
# c(vector, value)
# c(value, vector)
#
c(glengths, 100) # add element
c(-500, glengths, 100) # add element in certain order


# note all the elements of a vector must be the same type
length_species <- c(4.5, "ecoli") # all will be character class
length_species

# This automatic conversion is called 'coercion' or 'casting' ..

# --------
# Exercise
# --------
#
# We’ve seen that vectors can be of type character, 
# numeric (or double), integer, and logical. 
#
# But what happens if we try to mix these types in a single vector?
#
# eg:
#
#   thing <- c("some characters", 3.141, 100, TRUE)
#   thing
#   class(thing)
#


# What will happen in each of these examples?
#
#   num_char <- c(1, 2, 3, "a") # all char
#   num_logical <- c(1, 2, 3, TRUE) # T = 1
#   char_logical <- c("a", "b", "c", TRUE) # all char
#   tricky <- c(1, 2, 3, "4") # all char
#
# [Hint: use class() to check the data type of your objects]
#
# Can you explain why you think it happens?

# --------
# Exercise
# --------
# How many values in combined_logical are "TRUE" (ie character 4 characters)
# in the following example:
#   
#   num_logical <- c(1, 2, 3, TRUE)
#   char_logical <- c("a", "b", "c", TRUE)
#   combined_logical <- c(num_logical, char_logical)


#
# Topic: Subsetting vectors
#

# create a vector
animals <- c("mouse", "rat", "dog", "cat")

# reference (access) the second element using [] 
animals[2]
animals[c(1, 4)] # gives multiple elements
animals[-2] # removes 2nd element
animals[c(-1, -4)] # removes multiple elements

# access the subset consisting of element 3 and element 2

# we can reference each element more than once
#
# six animal names refencered by indexes 1,2,3,3,2,1


# Conditional subsetting
#
weight_g <- c(21,   34,    39,   54,   55)
weight_g[   c(TRUE, FALSE, TRUE, TRUE, FALSE)] #only selected T
# 

# using comparison operators to generate a 'logical' vector 
#
# vector of which weight are greater then 50
weight_g > 50 # only last 2 are T
weight_g[weight_g > 50] # only indexes the desired numbers with T

# ... and the use this to subset the data vector

# and we can get more fancy with comparisons 
#
#  weight_g < 30 | weight_g > 50
#  weight_g >= 30 & weight_g == 21

# another example with animals
#
# animals <- c("mouse", "rat", "dog", "cat")
# animals == "cat" | animals == "rat"


# %in% operator 
#
# animals %in% c("rat", "cat", "dog", "duck", "goat")
# animals[animals %in% c("rat", "cat", "dog", "duck", "goat")]

# Challenge
#
# Can you explain  why 
#
#  "four" > "five" 
#
# returns TRUE?
#
# Answer:


# Topic: Missing data (NA - Not Available)

# heights <- c(2, 4, 4, NA, 6)
#
# lets look at the mean(), max() with and withoout na.rm = TRUE

# other ways to exclude NAs - is.na(),  na.omit(), copmlete.cases()



#
# Exercise (extended)
#
#
# Using this vector of heights in inches, create a new vector 
# with the NAs removed.
# 
#   heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)
#
# Solution


# Use the function median() to calculate the median of the heights vector.
#
# Solution


# Use R to figure out how many people in the set are taller than 67 inches.
#


# [Hint: R has a builtin function called length() that tells you 
# how many values are in a vector


#    ____                       ____                          _ _       ____            _     
#   / ___|  __ ___   _____     / ___|___  _ __ ___  _ __ ___ (_) |_    |  _ \ _   _ ___| |__  
#   \___ \ / _` \ \ / / _ \   | |   / _ \| '_ ` _ \| '_ ` _ \| | __|   | |_) | | | / __| '_ \ 
#    ___) | (_| |\ V /  __/_  | |__| (_) | | | | | | | | | | | | |_ _  |  __/| |_| \__ \ | | |
#   |____/ \__,_| \_/ \___( )  \____\___/|_| |_| |_|_| |_| |_|_|\__( ) |_|    \__,_|___/_| |_|
#                         |/                                       |/                         
