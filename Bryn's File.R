#New Variable
length_width <- select(bird_data, body_length_mm, body_mass_g)

length_width

mutate(length_width, length_mass_ratio = body_length_mm / body_mass)

##Graphs
#ggplot length-mass by altitude
ggplot(data = length_width) +
  geom_point(mapping = aes(x = length_mass_ratio, y = altitude))

#Wing Length
rename(bird_data, wing_length_mm = Wing_length.mm.)


