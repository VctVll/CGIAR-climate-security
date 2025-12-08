
install.packages("ggmap")
library(ggmap)
# Register your Google Maps API key
register_google(key = "AIzaSyAnQwzavCPk5v__fclLBo2Dl6v7XHdRLj8")

setwd("D:/OneDrive - CGIAR/FCM/Countries/IOM project/New Analysis/IOM_climate_conflict")

# Read city names and countries from a CSV file
city_data <- read.csv("IOM_ALL.csv")

# Geocode the locations (include the country)
geocoded <- geocode(paste(city_data$CityCleaned, city_data$DepartedfromwhichcountryCl, sep = ", "))

# Create a scatter plot
plot(geocoded$lon, geocoded$lat, pch=16, col="blue", main="Centroids of Cities/Villages")

# Combine city names, countries, and coordinates into a dataframe
city_coordinates <- data.frame(City = city_data$CityCleaned, Country = city_data$DepartedfromwhichcountryCl, Latitude = geocoded$lat, Longitude = geocoded$lon)

# Save to a CSV file
write.csv(city_coordinates, "city_village_coordinates.csv", row.names = FALSE)


#  FMP - IOM 
#install.packages("ggmap")
library(ggmap)
# Register your Google Maps API key
register_google(key = "AIzaSyAnQwzavCPk5v__fclLBo2Dl6v7XHdRLj8")

setwd("D:/OneDrive - CGIAR/FCM/Countries/IOM project/Village level analysis/Migrants_location")

# Read city names and countries from a CSV file
city_data <- read.csv("FMP_locations.csv")

# Geocode the locations (include the country)
geocoded <- geocode(paste(city_data$City, city_data$Country, sep = ", "))

# Create a scatter plot
plot(geocoded$lon, geocoded$lat, pch=16, col="blue", main="Centroids of Cities/Villages")

# Combine city names, countries, and coordinates into a dataframe
city_coordinates <- data.frame(City = city_data$City, Country = city_data$Country, Latitude = geocoded$lat, Longitude = geocoded$lon)

# Save to a CSV file
write.csv(city_coordinates, "FMP_coordinates.csv", row.names = FALSE)

