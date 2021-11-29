# HEADER ---------------------
# Description:  Copy output files from a local folder to a network folder
#               to  share with the rest of the team or Council
# Author: Laurie Platt

# boundsheff package Windows binary file   ------------------------------------

## share to all ----
fs::file_copy(
  "C:/Users/lp41455/OneDrive - Sheffield City Council/Repo/boundsheff_0.0.1.zip",
  "S:/BI Team/ShareToAll/RPackages/boundsheff_0.0.1.zip",
  overwrite = TRUE)

## ASC_SNA team data share ----
fs::file_copy(
  "C:/Users/lp41455/OneDrive - Sheffield City Council/Repo/boundsheff_0.0.1.zip",
  stringr::str_c(
    "S:/Public Health/Policy Performance Communications/",
    "Business Intelligence/Projects/AdultSocialCare/ASC_SNA/data/",
    "boundsheff_0.0.1.zip"),
  overwrite = TRUE)
