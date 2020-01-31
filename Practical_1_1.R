### Practical_1_1

## The objective here is to start familaiarizing with R, and Rstudio
## As you see the characetr '#' is udes to idetify lines of comments
## they are not interpreted and are useful for us to kee track of the process 
## of analysis

## As discussed assignment (sending somethingin the workspace) is done using '<-'
## the shrotcut to insert it is 'ALT' + '-'
## a complete list of shortcut can be found in the menu under 'tools'

## BASIC ASSIGNMENTS  #########################
a <- 1
A <- 2
mystring <- "fmach"   ## note the double quotes
myboolean <- TRUE

## run the code and ispect your workspace (environnment)
## as you see R is case sensitive ...

## MULTIDIMENSIONAL OBJECTS #####################

## a multidimensional object is created by a function c()
myvector <- c(1,2,3,4)

## how the help looks like?
?c

## assignment by name
u <- c("carlo" = 2, "due" = 10)

## how can I look inside a multidimensional object?
myvector[3]

## or only change the second element of my object
myvector[2] <- 30

## this gives me the third element of the  vector, remember that the first element in the 
## remember that R is counting from one and not zero
## if I want to construct a 2d array ...

myarray <- matrix(seq(1,25,1), nrow = 5, ncol = 5)

myarray

## now I would like you to comment the previous command

## Key ideas:
## - what is a function
## - function arguments
## - function default arguments

## the content can be accessed
myarray[2,3] ## one element
myarray[1,]  ## one row!

## square brakets can be used in a quite flexible way to select elements
## matching specific properties

myarray[myarray > 10]
myarray[myarray[1,] >3,]

## when you have multidimensional objects it is often useful give
## a name to the eleents

vector.with.names <- c("one" = 1, "two" = 2, "three" = 3)

## in this way I can access the second element either as
vector.with.names[2]
##or
vector.with.names["two"]

## with two dimensional or more dimensional objects rownames and colum names are usefule
## exactly as in excel


###### Your First assignment 

mymonths <- c("Jan","Feb","Mar",
              "Apr","May","Jun",
              "Jul","Aug","Sep",
              "Oct","Nov","Dec")
days <- c(31,28,31,30,31,30,31,31,30,31,30,31)
season <- c(rep(c("winter","spring","summer","autumn"), each = 3))

yeardf <- data.frame("month" = mymonths, "length" = days, "season" = season,
                     stringsAsFactors = FALSE)

factor(yeardf$season)


## if I want to use a list ...
yearlist <- list("month" = mymonths, "length" = days, "season" = season)
yearlist[["length"]]




#######################################################################################
#######################################################################################

library(tidyverse)
data(mpg)

# Description
# This dataset contains a subset of the fuel economy data that the EPA makes available on 
# http://fueleconomy.gov. It contains only models which had a new release every year between 1999 and 2008 - 
# this was used as a proxy for the popularity of the car.

summary(mpg)


## my first plot .... engine displacement, miles per gallon
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = hwy))

## the same can be extended ... playing with arguments
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), col = "red")

## but more interestingly ...
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = class)) 
#  theme_light() +
  xlim(c(5,7))            ## set x limits

## what aesthetics could I use?
## another time ....

?geom_point


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = class)) + 
  facet_wrap(~class, scales ="free")


## Some more plots ####################################################################

## histograms, scales free
ggplot(data = mpg) +
  geom_histogram(mapping = aes(x = displ)) + 
  facet_wrap(~class)

## or jitter!
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = class, y = displ, col = class), width = 0.1)



## Pay attention to the apex!
## "ciao"
## 'ciao'
## `ciao`

## Read tables in ###################################################################

## From a csv file
library(readr)
camera <- read_csv("camera_dataset.csv")
 

ggplot(data = camera) + 
  geom_point(mapping = aes(x = `Release date`, y = `Max resolution`)) + 
  theme_light()
















