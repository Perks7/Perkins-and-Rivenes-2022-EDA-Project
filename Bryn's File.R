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

#ggplot Wing Length vs Altitude 
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = wing_length_mm, 
    y = altitude)
  )

#ggplot Wing Length vs Altitude (color)
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = wing_length_mm, 
    y = altitude,
    color = Order),
    alpha = 0.1
  )

#Order Freq Table (?)
order_freq_table <- count(length_vs_mass, Order)
order_freq_table

#frequency table of authors
bird_data%>%
  count(ID_Res, name = "author_freq")%>% 
  print(n = Inf)
geom_point(mapping = aes(
  x = length_mass_ratio, 
  y = altitude)
  )

#length mass ratio vs Latitude
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = Latitude_decimal_degrees,
    color = Order),
    alpha = 0.1
  )

#length mass ratio vs Annual Temp
ggplot(data = length_vs_mass) +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = Annual_mean_temperature,
    color = Order),
    alpha = 0.1
  )
#NOTE: Maybe we should look at Annual_mean_temperature ? 
#we could also look at latitude? (Latitude_decimal_degrees)

#~~~ 
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
length_vs_mass <-mutate(length_vs_mass, 
                        ln_lmr = log(length_mass_ratio))

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
#~~~~

#ggplot freqpoly
ggplot(data = length_vs_mass) +
  geom_freqpoly(mapping = aes(
    x = length_mass_ratio, 
    color = Order)
  )

#ggplot geom_tile
length_vs_mass %>%
  count(length_mass_ratio)

length_vs_mass %>%        #<- doesn't work
  ggplot(mapping = aes(
    x = length_mass_ratio, 
    y = altitude)) +
  geom_tile(mapping = aes(fill = n))

#geom_bin2d
ggplot(data = length_vs_mass) +
  geom_bin2d(mapping = aes(
    x = length_mass_ratio, 
    y = altitude))

# install.packages("hexbin")
ggplot(data = length_vs_mass) +
  geom_hex(mapping = aes(
    x = length_mass_ratio, 
    y = altitude))

#length mass plot of anseriforms 
length_vs_mass %>% 
  filter(Order=="Anseriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = body_length_mm, 
    y = body_mass_g)
  )

#length mass plot of passeriformes 
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
    y = altitude,
    alpha = .001,
    color = Family)
  )

#length mass ratio vs altitude Anseriformes        <- shows Amazonetta brasiliensis being weird
length_vs_mass %>% 
  filter(Order=="Anseriformes") %>% 
  ggplot() +
  geom_point(mapping = aes(
    x = length_mass_ratio, 
    y = altitude,
    alpha = .001,
    color = Species)
  )


#Hex density plot passeriformes
length_vs_mass %>% 
  filter(Order=="Passeriformes") %>%
  ggplot() +
    geom_hex(mapping = aes(
      x = length_mass_ratio, 
      y = altitude))


#ln_lmr vs altitude for Passeriformes
length_vs_mass %>% 
  filter(Order=="Passeriformes") %>% 
  ggplot(mapping = aes(
    y = ln_lmr, 
    x = altitude,
    alpha = 0.01,
    color = Family)) +
  geom_point(
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
  geom_point() +
  geom_smooth(method = "lm")

#New --------------------------------------------------


