library(rvest)
library(tidyverse)
library(R.utils)

url <- "https://openpolicing.stanford.edu/data/"

stanford <- url %>%
  read_html() %>%
  html_nodes("#data-fixed-header") %>%
  html_table() %>%
  data.frame()


stanford_links <- url %>%
  read_html() %>%
  html_nodes("#data-fixed-header a") %>%
  html_attr("href")

stanford$Var.2 <- stanford_links
 
stanford <- stanford[,1:4] %>%
  select(State, url = Var.2, Stops, Time.Range)

for (i in 1:nrow(stanford)) {
  s_url <- stanford$url[i]
  s_filename <- gsub(".*\\/", "", s_url)
  s_file <- gsub(".gz", "", s_filename)
  s_filename_zip <- paste0("data/", s_filename)
  s_filename_dat <- paste0("data/", s_file)
  if(!file.exists(s_filename_dat)) {
    download.file(s_url, s_filename_zip, quiet=T)
    gunzip(s_filename_zip)
  }
}

