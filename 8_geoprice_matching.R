# ----------------- #
# GeoPrice matching #
# ----------------- #

rm(list=ls()) # Clean environment

# ---------------- #
# Import libraries #
# ---------------- #

pacman::p_load(haven, tidyverse, reshape) # Load libs

# -------------- #
# Set parameters #
# -------------- #

price_source <- 'wfp_food_prices_zwe.csv' # Location of .csv price data
data_source <- 'geo_enriched_data.csv' # Location of .dta file with cluster coordinates
curr_currency <- 'USD' # 'ZWL'
commodity_used <- c('Maize')
output_file <- 'ZIMBABWE_final_data.dta' # name of file to save

# --------- #
# Load data #
# --------- #

data <- read_csv(data_source)
data <- data %>%
  drop_na(LONGNUM, LATNUM) # drop NA in latitude and longitude

price <- read_csv(price_source)
price <- price[-1,] # remove first row of junk
price <- price %>%
  drop_na(latitude, longitude, date) %>% # drop NA in latitude, longitude and date
  filter(currency == curr_currency) %>% # filter rows by currency condition
  select(date, latitude, longitude, category, commodity, unit, price, usdprice) # keep only relevant cols
price['date'] <- as_datetime(price$date)
price['longitude'] <- as.numeric(price$longitude)
price['latitude'] <- as.numeric(price$latitude)
price['usdprice'] <- as.numeric(price$usdprice)
price['price'] <- as.numeric(price$price)

price[month(price$date) <= 3, 'quarter'] <- 1
price[month(price$date) > 3 & month(price$date) <= 6, 'quarter'] <- 2
price[month(price$date) > 6 & month(price$date) <= 9, 'quarter'] <- 3
price[month(price$date) > 9, 'quarter'] <- 4
price['year'] <- year(price$date)

table(price$commodity)

price <- merge(data, price, by = c('year', 'quarter'))

price['l2_distance'] <- sqrt((price$latitude - price$LATNUM)^2 + (price$longitude - price$LONGNUM)^2) # Compute l2 distance among points

price_over_quarter <- price %>% 
  filter(commodity %in% commodity_used) %>% # pulses and nuts, oil and fats, cereals and tubers
  group_by(DHSCLUST, quarter, year, commodity) %>%
  slice_min(order_by = l2_distance) %>% # take minimum distance couple
  summarise(usdprice_over_quarter=mean(as.numeric(usdprice), na.rm=T),
            price_over_quarter=mean(as.numeric(price), na.rm=T)) # average across months in same quarter/year

price <- cast(price_over_quarter, DHSCLUST + quarter + year ~ commodity, value = 'price_over_quarter')
usdprice <- cast(price_over_quarter, DHSCLUST + quarter + year ~ commodity, value = 'usdprice_over_quarter')
colnames(usdprice)[4:dim(usdprice)[2]] <- paste0('usd_', colnames(usdprice)[4:dim(usdprice)[2]])

data <- merge(data, price, by = c('DHSCLUST', 'year', 'quarter'), all.x = T)
data <- merge(data, usdprice, by = c('DHSCLUST', 'year', 'quarter'), all.x = T)

write_dta(data, output_file)