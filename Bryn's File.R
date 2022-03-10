#New Variable
length_width <- select(bird_data, body_length_mm, body_mass_g)

length_width

mutate(length_width, length_mass_ratio = body_length_mm / body_mass_g)

