#' Sheffield's 7 ASC (Adult Social Care) locality boundaries.
#'
#' Combination of four Wards in each and the same as the Sheffield LAC 
#' (Local Area Committee) boundaries. From the SCC Portal.
#'
#' @format A simple feature with seven variables: \code{objectid}, 
#' \code{ca_number}, \code{ca_name}, \code{asc_name}, \code{X}, \code{Y},
#'  and \code{geom}.
"sf_asc_localities"

#' Sheffield's 100 neighbourhood boundaries.
#'
#' From the SCC Portal.
#'
#' @format A simple feature with seven variables: \code{objectid}, 
#' \code{oa_code}, \code{oa_district}, \code{oa_ward},  \code{oa_nhood_code},
#' \code{nhood_name}, \code{X}, \code{Y}, and \code{geom}.
"sf_nhood"

#' Sheffield's 28 Ward boundaries.
#'
#' Generalised boundaries from ONS Open Geography Portal.
#'
#' @format A simple feature with five variables: \code{WD20CD}, 
#' \code{WD20NM}, \code{LONG}, \code{LAT}, and \code{geoms}.
"sf_ward"

#' Sheffield's 70 MSOA boundaries.
#'
#' Generalised boundaries from ONS Open Geography Portal.
#'
#' @format A simple feature with five variables: \code{MSOA11CD}, 
#' \code{MSOA11NM}, \code{LONG}, \code{LAT}, and \code{geoms}.
"sf_msoa"

#' Sheffield's 345 LSOA boundaries.
#'
#' Generalised boundaries from ONS Open Geography Portal.
#'
#' @format A simple feature with five variables: \code{LSOA11CD}, 
#' \code{LSOA11NM}, \code{LONG}, \code{LAT}, and \code{geoms}.
"sf_lsoa"

#' Sheffield's 1,817 Output Area boundaries.
#'
#' Generalised boundaries from ONS Open Geography Portal.
#'
#' @format A simple feature with two variables: \code{OA11CD}, 
#' and \code{geoms}.
"sf_oa"