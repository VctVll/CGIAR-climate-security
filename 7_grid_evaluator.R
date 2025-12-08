# ------------------------ #
# Automatic grid evaluator #
# ------------------------ #

rm(list=ls()) # Clean environment

# ---------------- #
# Import libraries #
# ---------------- #

pacman::p_load(rgdal, raster, haven, tidyverse, sf) # Load libs

# -------------- #
# Set parameters #
# -------------- #

shp_source <- 'gadm41_ZWE_shp/gadm41_ZWE_2.shp' # Location of shape file
data_source <- "ZIMBABWE_QUARTER_FOOD_CLIMATE_CONFLICTS.dta" # Location of .dta file with cluster coordinates
grid_size <- 0.2 # Size of squared grids
output_plot <- T # Choose among T or F; expensive operation if shp is very detailed

# --------- #
# Load data #
# --------- #

shp <- readOGR(dsn = shp_source)

data <- read_dta(data_source)
data <- data %>%
  drop_na(LONGNUM, LATNUM)
coordinates(data) <- ~LONGNUM + LATNUM

# --------------- #
# Perform geo ops #
# --------------- #

grid <- raster(extent(shp), resolution = c(grid_size, grid_size), crs = proj4string(shp))
grid <- raster::extend(grid, c(1,1))
values(grid) <- 1:ncell(grid)
gridPolygon <- rasterToPolygons(grid)

intersectGridClipped <- raster::intersect(gridPolygon, shp)

data <- raster::intersect(intersectGridClipped, data)
data <- st_as_sf(data)
data <- data[, -c(2:14)]
coordinates_to_paste <- as.data.frame(st_coordinates(data$geometry))
data <- as.data.frame(data)
data <- data[, -dim(data)[2]]
data <- bind_cols(data, coordinates_to_paste)
colnames(data)[dim(data)[2] - 1] <- 'LONGNUM'
colnames(data)[dim(data)[2]] <- 'LATNUM'

write_csv(data, "geo_enriched_data.csv")

# ---- #
# Plot # 
# ---- #

if (output_plot == T) {
  plot(intersectGridClipped)
  plot(data, 
       pch = 1,
       col = "red",
       cex = 0.5,
       add = TRUE)
}