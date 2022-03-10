library(tidyverse)

file_url<-"https://esajournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1002%2Fecy.2647&file=ecy2647-sup-0001-DataS1.zip"
file_name <- basename(file_url)

if (!dir.exists("bird_data")) dir.create("bird_data")

#if (!file.exists(file_name))
download.file(file_url, destfile = "bird_data/bird_data.zip", mode = "wb")

unzip("bird_data/bird_data.zip", overwrite = TRUE, exdir = "bird_data")

read_csv("bird_data/ATLANTIC_BIRD_TRAITS_completed_2018_11_d05.csv")

