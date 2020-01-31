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
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(x = displ, y = cty), col = "red")
## the same can be extended ... playing with rguments
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), col = "red")

## but more interestingly ...
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = class, size  = cyl))

## what aesthetics could I use?
## another time ....

?geom_point


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, col = class, size  = cyl/2)) + 
  facet_wrap(~class, scales = "free") + 
  theme_light() + theme(aspect.ratio = 1)


## Some more plots ####################################################################

## histograms, scales free
ggplot(data = mpg) +
  geom_histogram(mapping = aes(x = displ)) + 
  facet_wrap(~class)

## or jitter!
myplot <- ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = class, y = displ, col = class), width = 0.1) +
  theme_light()


## where could I put some additional characteristics?
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = class, y = displ, col = manufacturer), width = 0.1) + 
  theme_minimal()



## Read tables in ###################################################################

library(readr)
camera <- read_csv("camera_dataset.csv")

## can we see check the number of suicides 

ggplot(data = camera) + 
  geom_point(mapping = aes(x = `Release date`, y = `Max resolution`))

## something interesting here!! 
## look how names with white spaces should be used...

## as you can see we have to use the ` character, which is neither ' ... nor " ...
## look on the web to find it in your operating system

## Just to see the power of plotting let's look to some other characteristics

ggplot(data = camera) + 
  geom_point(mapping = aes(x = `Zoom wide (W)`, y = `Zoom tele (T)`))

## Let's do some science ...
## - why do we have points on 0,0?
## - why do we have points arranged in lines???


## PIPING and data carpentry ###################
## Objective: select only some columns and focus on CANON models

camera %>% 
  select(Model,`Release date`,`Max resolution`) %>% 
  filter(grepl("Canon",Model)) %>% 
  ggplot() + 
  geom_point(mapping = aes(x = `Release date`, y = `Max resolution`)) + 
  theme_minimal()


camera %>% 
  filter(grepl("Canon",Model)) %>% 
  mutate(ratio = `Zoom tele (T)`/`Zoom wide (W)`) %>% 
  ggplot() + 
  geom_point(mapping = aes(x = `Release date`, y = ratio)) + 
  theme_minimal()

## let's jus look to the grepl function
?grepl
grepl("Canon",camera_dataset$Model)

## Everything tpgether!!

camera_dataset%>% 
  select(-`Effective pixels`, -`Macro focus range`,-`Storage included` ) %>% 
  mutate(myratio = `Weight (inc. batteries)`/Dimensions) %>% 
  ggplot() + 
  geom_point(mapping = aes(x = `Release date`, y = myratio)) + 
  theme_minimal()

#

pippo <- camera%>% 
  separate(Model, c("Producer","Model1","Model2")," ") %>% 
  mutate(M = paste(Model1,Model2)) %>%  ggplot() + 
  geom_point(mapping = aes(x = `Release date`, y = `Max resolution`)) + 
  facet_wrap(~Producer) + 
  theme_minimal()
  

## faceting

camera <- camera %>% 
  separate(Model, c("Producer","Model1","Model2")," ") %>% 
  mutate(M = paste(Model1,Model2))


camera %>% 
  ggplot() +
  geom_jitter(aes(x = Producer, y = `Zoom wide (W)`), width = 0.1)


## Gather
camera %>% 
  gather(Parameter, value, `Release date`:Price) %>% 
  ggplot() +
  geom_jitter(aes(x = Producer, y = value), width = 0.1) +
  facet_wrap(~Parameter,scales = "free")


camera %>% 
  group_by(`Release date`, Producer) %>% 
  summarise(avg_res = mean(`Max resolution`))




  mutate(myratio = `Zoom wide (W)`/`Zoom tele (T)`) %>% 
  ggplot() +
  geom_jitter(aes(x = Producer, y = myratio), width = 0.05, size = 0.5)





## Summary statistics ....
## suppose you are interested in calculating the average hwy per class of cars ...
## let's do it with pipes!!!

mpg %>% select(hwy,class) %>% 
  group_by(class) %>% 
  summarise(mhwy = mean(hwy)) %>%
  ggplot() + 
  geom_bar(mapping = aes(x = class, y = mhwy), stat = "identity") + 
  coord_flip()
  
## many new things!!!

## one could also use two grouping factors .... 
mpg %>% select(hwy,class,manufacturer) %>% 
  group_by(class, manufacturer) %>% 
  summarise(mhwy = mean(hwy))


data(iris)
iris %>% 
  mutate(sepratio = Sepal.Width/Sepal.Length) %>% 












