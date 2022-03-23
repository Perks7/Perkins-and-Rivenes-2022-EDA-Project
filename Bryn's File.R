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