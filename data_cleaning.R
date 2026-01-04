library(tidyverse)
library(readxl)
library(janitor)


# Create function for reading in data. This will find all of the files in the directory, then read and do initial cleaning on them. 
read_files <- function(x) {
  readxl::read_xlsx(x) |> 
  janitor::clean_names() |> 
  filter(system_name == 'Coweta County',
         indicator == 'At or Above Grade-Level Reading') |> 
  mutate(school_year = as.character(school_year),
         system_id = as.character(system_id))
}

files <- list.files("CCRPI-Readiness/", pattern = '.xlsx',full.names = TRUE)

df <- map_df(files,read_files)

#Save it as an RDS file so individual XLSX files do not need to be loaded each run. 
write_rds(df, 'CCRPI_data.rds')



