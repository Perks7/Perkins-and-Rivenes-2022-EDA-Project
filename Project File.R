library(tidyverse)

file_url<-"https://esajournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1002%2Fecy.2647&file=ecy2647-sup-0001-DataS1.zip"
file_name <- basename(file_url)

if (!dir.exists("bird_data")) dir.create("bird_data")

#if (!file.exists(file_name))
download.file(file_url, destfile = "bird_data/bird_data.zip", mode = "wb")
unzip("bird_data/bird_data.zip", overwrite = TRUE, exdir = "bird_data")

#reading and renaming data
bird_data<-read_csv("bird_data/ATLANTIC_BIRD_TRAITS_completed_2018_11_d05.csv")

#renaming variables 
bird_data <- rename(bird_data, 
                    body_mass_g = Body_mass.g., 
                    body_length_mm = Body_length.mm., 
                    altitude = Altitude, 
                    wing_length_mm = Wing_length.mm.
                    )

#new variable
length_vs_mass <- select(bird_data, body_length_mm, body_mass_g)

length_vs_mass <- mutate(bird_data, 
                         length_mass_ratio = body_length_mm / body_mass_g)

#ggplot Length Mass Ratio vs Altitude 
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = altitude)
  )

#ggplot Length Mass Ratio vs Altitude (color) 
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = altitude, 
    color = Order), 
    alpha = 0.1
  )

#ggplot mass vs altitude (color)
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = body_mass_g, 
    y = altitude, 
    color = Order), 
    alpha = 0.1
  )


#ggplot Wing Length vs Altitude (color)
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = wing_length_mm, 
    y = altitude,
    color = Order),
    alpha = 0.1
  )


#table of order frequency
order_freq<-length_vs_mass%>%
  group_by(Order)%>%
  summarize(n = n())

#facet wrap graph by order
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = altitude))+
  facet_wrap(~Order)

#density plot by order
ggplot(data = length_vs_mass) +
  geom_density(mapping = aes(
    x = length_mass_ratio, 
    y = altitude))+
  facet_wrap(~Order)

#log of length_mass_ratio to correct right skew 
length_vs_mass <-mutate(length_vs_mass, ln_lmr = log(length_mass_ratio))

#testing for normal distribution of length_mass_ratio
ggplot(data = length_vs_mass) +
  geom_histogram(mapping = aes(
    x = ln_lmr), bins = 100)+ 
  facet_wrap(~Order)

#testing for normal distribution of length_mass_ratio
ggplot(data = length_vs_mass) +
  geom_histogram(mapping = aes(
    x = ln_lmr), bins = 100) + 
  facet_wrap(~Order,scales = "free_y")

#length mass plot of Anseriformes 
length_vs_mass %>% 
  filter(Order=="Anseriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = body_length_mm, 
    y = body_mass_g)
  )
#length mass plot for Passeriformes
length_vs_mass %>% 
  filter(Order=="Passeriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = body_length_mm, 
    y = body_mass_g)
  )

#length mass ratio vs altitude Passeriformes
length_vs_mass %>% 
  filter(Order=="Passeriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = altitude)
  )

#length mass ratio vs altitude Anseriformes
length_vs_mass %>% 
  filter(Order=="Anseriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = altitude)
  )

#ln_lmr vs altitude for Anseriformes
length_vs_mass %>% 
  filter(Order=="Anseriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = ln_lmr, 
    y = altitude)
  )

#ln_lmr vs altitude for Passeriformes
length_vs_mass %>% 
  filter(Order=="Passeriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = ln_lmr, 
    y = altitude)
  )

