# HEADER ---------------------
# Description: Get boundaries from the SCC Portal.
# Note: Requires local ArcGIS Pro installation and license
# Author: Laurie Platt

# SETUP -------------------------
library(tidyverse); library(sf)

# Requires local ArcGIS Pro and license
library(arcgisbinding); arc.check_product() 

## Local variables --------------

# URL for ASC localities from the Council's Portal
asc_localities_url <- str_c(
  "https://sheffieldcitycouncil.cloud.esriuk.com/portal/sharing/servers/",
  "dbfe34dca2b242ea8c13bbdd3cfa632b/rest/services/AGOL/Boundaries/MapServer/2")

# URL for neighbourhoods on Portal
nhood_url <- str_c(
  "https://sheffieldcitycouncil.cloud.esriuk.com/portal/sharing/servers/",
  "1f70fe34009e4967a0b6290807f46df1/rest/services/AGOL/Boundaries/MapServer/13")

# READ --------------------------

# Get ASC localities as simple features with WSG84 coordinates
sf_asc_localities <- arc.open(asc_localities_url) %>% 
  arc.select() %>% 
  arc.data2sf() %>% 
  st_transform(crs = 4326)

# Get neighbourhood as simple features with WSG84 coordinates
sf_nhood <- arc.open(nhood_url) %>% 
  arc.select() %>% 
  arc.data2sf() %>% 
  st_transform(crs = 4326)

# TRANSFORM ---------------------

# Get X Y coordinates of ASC locality centroids [useful for geom_text()]
xy <- sf_asc_localities %>% 
  st_centroid() %>% 
  st_coordinates() %>% 
  as_tibble() 

# Add X Y coordinates to ASC locality data
sf_asc_localities <- sf_asc_localities %>% 
  bind_cols(xy) %>% 
  select(-starts_with("st_"))

# Get X Y coordinates of neighbourhood centroids [useful for geom_text()]
xy <- sf_nhood %>% 
  st_centroid() %>% 
  st_coordinates() %>% 
  as_tibble() 

# Add X Y coordinates to neighbourhood data
sf_nhood <- bind_cols(sf_nhood, xy) %>% 
  select(-starts_with("st_")) %>% 
  st_cast("MULTIPOLYGON") # so works with plotly too

# Remove variables that are superfluous or out-of-date 
sf_nhood <- sf_nhood %>%
  select(-1) %>% 
  # select(-(1:3)) %>% 
  relocate(oa_ward, .after = nhood_name)

# WRITE --------------------------

usethis::use_data(sf_asc_localities, compress = "xz", overwrite = T)

usethis::use_data(sf_nhood, compress = "xz", overwrite = T)