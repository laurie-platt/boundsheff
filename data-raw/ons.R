# HEADER ---------------------
# Description: Get boundaries from the ONS Open Geography Portal
# Author: Laurie Platt

# SETUP -------------------------
library(tidyverse); library(sf); library(esri2sf)

## Local variables --------------

# Base URL for ONS Open Geography Portal
ons_geog_base_url <- "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/"

# wardFullResolution <- "Wards_December_2020_UK_BFC_V3"
wardGeneralised <- "Wards_December_2020_UK_BGC_V3"
# wardSuperGeneralised <- "Wards_December_2020_UK_BSC_V3"

# msoaFullResolution <- "Middle_Layer_Super_Output_Areas_December_2011_EW_BFC_V2"
msoaGeneralised <- "Middle_Layer_Super_Output_Areas_DEC_2011_EW_BGC_V3"
# msoaSuperGeneralised <- "Middle_Layer_Super_Output_Areas_DEC_2011_EW_BSC_V3"

# lsoaFullResolution <- "Lower_Layer_Super_Output_Areas_December_2011_Boundaries_EW_BFC_V2"
lsoaGeneralised <- "Lower_Layer_Super_Output_Areas_DEC_2011_EW_BGC_V3"
# lsoaSuperGeneralised <- "Lower_Layer_Super_Output_Areas_DEC_2011_EW_BSC_V3"

oaGeneralised <- "Output_Areas_December_2011_Boundaries_EW_BGC"

# READ --------------------------

# Data frame of Sheffield Ward codes
df_ward_codes <- esri2df(url = str_c(ons_geog_base_url, 
                                     "WD20_LAD20_UK_LU_v2/FeatureServer/0"),
                         where = "LAD20NM='Sheffield'")  %>%
  select(WD20CD, WD20NM) %>% 
  mutate(WD20CD = str_c("'", WD20CD, "'"))

# Build a where clause of Sheffield Ward codes
s_ward_codes <- str_c(df_ward_codes$WD20CD, collapse = ",")
clause = str_c("WD20CD IN (", s_ward_codes, ")")

# Ward generalised boundaries as simple features
sf_ward <- esri2sf(url = str_c(ons_geog_base_url, wardGeneralised, "/FeatureServer/0"),
                   where = clause,
                   geomType = "esriGeometryPolygon")  

# MSOA generalised boundaries as simple features
sf_msoa <- esri2sf(url = str_c(ons_geog_base_url, msoaGeneralised, "/FeatureServer/0"),
                   where = "MSOA11NM LIKE'Sheffield%'",
                   geomType = "esriGeometryPolygon")

# LSOA generalised boundaries as simple features
sf_lsoa <- esri2sf(url = str_c(ons_geog_base_url, lsoaGeneralised, "/FeatureServer/0"),
                   where = "LSOA11NM LIKE'Sheffield%'",
                   geomType = "esriGeometryPolygon")

# Output Areas generalised boundaries as simple features
sf_oa <- esri2sf(url = str_c(ons_geog_base_url, oaGeneralised, "/FeatureServer/0"),
                 where = "LAD11CD = 'E08000019'",
                 geomType = "esriGeometryPolygon")

# TRANSFORM ---------------------
# X Y coordinates already there as LONG LAT [useful for geom_text()]

sf_ward <- sf_ward %>% 
  st_cast("MULTIPOLYGON") %>% # so works with plotly too
  select(-OBJECTID, -WD20NMW, -starts_with("BNG"), -starts_with("Shape"))

sf_msoa <- sf_msoa %>% 
  st_cast("MULTIPOLYGON") %>% # so works with plotly too
  select(-OBJECTID, -MSOA11NMW, -starts_with("BNG"), -starts_with("Shape"))

sf_lsoa <- sf_lsoa %>% 
  st_cast("MULTIPOLYGON") %>% 
  select(-OBJECTID, -LSOA11NMW, -starts_with("BNG"), -starts_with("Shape"))

sf_oa <- sf_oa %>% 
  st_cast("MULTIPOLYGON") %>% # so works with plotly too
  select(-OBJECTID, -LAD11CD, -starts_with("Shape"))

# WRITE --------------------------

usethis::use_data(sf_ward, compress = "xz", overwrite = T)

usethis::use_data(sf_msoa, compress = "xz", overwrite = T)

usethis::use_data(sf_lsoa, compress = "xz", overwrite = T)

usethis::use_data(sf_oa, compress = "xz", overwrite = T)
