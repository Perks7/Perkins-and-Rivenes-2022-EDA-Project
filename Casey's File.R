
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

bird_data <- rename(bird_data, body_mass_g = Body_mass.g., body_length_mm = Body_length.mm.,
       altitude = Altitude, species = Species)

#new variable
length_width <- select(bird_data, body_length_mm, body_mass_g)

length_width<-mutate(bird_data, length_mass_ratio = body_length_mm / body_mass_g)

#ggplot

ggplot(data = length_width) +
  geom_point(mapping = aes(y = length_mass_ratio, x = altitude))

#table of species frequency
species_freq<-length_width%>%
  group_by(species)%>%
  summarize(n = n())

#table of genus frequency
genus_freq<-length_width%>%
  group_by(Genus)%>%
  summarize(n = n())

#table of order frequency
order_freq<-length_width%>%
  group_by(Order)%>%
  summarize(n = n())

#facet wrap graph by order
ggplot(data = length_width) +
  geom_point(mapping = aes(x = length_mass_ratio, y = altitude))+
               facet_wrap(~Order)

#density plot by order
ggplot(data = length_width) +
  geom_density(mapping = aes(x = length_mass_ratio, y = altitude))+
  facet_wrap(~Order)

#testing for normal distribution of length_mass_ratio
ggplot(data = length_width) +
  geom_histogram(mapping = aes(x = ln_lmr), bins = 100)+ 
  facet_wrap(~Order)+

#testing for normal distribution of length_mass_ratio
ggplot(data = length_width) +
  geom_histogram(mapping = aes(x = ln_lmr), bins = 100)+ 
  facet_wrap(~Order,scales = "free_y")

#log of length_mass_ratio to correct right skew 
length_width<-mutate(length_width, ln_lmr = log(length_mass_ratio))

#grouped table Anseriforms
anseriforms_grouped <- group_by(length_width, Order)


#length mass plot of anseriforms 
length_vs_mass %>% 
  filter(Order=="Anseriforms") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = body_length_mm, 
    y = body_mass_g)
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
  ggplot(mapping = aes(
    y = ln_lmr, 
    x = altitude)) +
  geom_point() +
  geom_smooth(method = "loess")

#fit line with altitude > 1000 Passeriformes
length_vs_mass %>% 
  filter(Order=="Passeriformes",
         altitude >= 1000) %>% 
  ggplot(mapping = aes(
    y = ln_lmr, 
    x = altitude)) +
  geom_point(mapping = aes(color = Family)) +
  geom_smooth(method = "loess") +
  geom_text_repel(
    mapping = aes(label = Family), 
    data = length_vs_mass %>% 
      filter(Order=="Passeriformes",
             altitude >= 2000)
  )

# fit line of passeriformes: furnariidea altitude >1000 (color)
length_vs_mass %>% 
  filter(Order=="Passeriformes",
         Family=="Furnariidae",
         altitude >= 1000) %>% 
  ggplot(mapping = aes(
    y = ln_lmr, 
    x = altitude)) +
  geom_point(mapping = aes(color = Species)) +
  geom_smooth(method = "lm")

#fit line of passeriformes: furnariidea altitude >1000 
length_vs_mass %>% 
  filter(
    Order=="Passeriformes",
    Family=="Furnariidae",
    altitude > 1000
  ) %>% 
  ggplot(mapping = aes(
    y = ln_lmr, 
    x = altitude)) +
  geom_point() +
  geom_smooth(method = "lm")

# frequency distribution of mean ln_lmr in passeriformes
length_vs_mass %>% 
  filter(Order == "Passeriformes")%>% 
  group_by(Order, Family, Genus, Species) %>% 
  summarize(ln_lmr = mean(ln_lmr),
            altitude = mean(altitude)) %>% 
  ggplot() +
  geom_histogram(aes(x = ln_lmr))

#mean of ln_lmr vs altitude 
length_vs_mass %>% 
  group_by(Order, Family, Genus, Species) %>% 
  summarize(ln_lmr = mean(ln_lmr),
            altitude = mean(altitude)) %>% 
  ggplot(mapping = aes(
    y = ln_lmr, 
    x = altitude)) +
  geom_point(size=2) +
  geom_smooth(method = "lm", size=2) +
  theme_gray(base_size = 24) +
  labs(
    x = "Altitude",
    y = "Mean ln(Length:Mass)"
  )
ggsave("species_altitude_scatter.png", units="in", height=8, width=12, dpi = 300)

#table of means above and below 1000 
mean_table<-length_vs_mass%>% mutate(mean_ln_lmr = mean)

# t-test for mean ln_lmr
t.test()

length_vs_mass %>% 
  ggplot() +
  geom_histogram(mapping = aes(
    x = ln_lmr), bins = 100) + 
  facet_wrap(~ Order)
    
#notes
#
#take means of species ln_lmr and compare lower and higher elevations (1000)
#do t-test on means above and below 1000
