library(readr)

file_list <- list.files("data")


for (i in 1:length(file_list)) {
  state <- read_csv(paste0("data/", file_list[i]), n_max=1)
  
  big_names <- names(state)
  
  if (i == 1) {
    all_names <- big_names
  } else {
    all_names <- c(all_names, big_names)
    all_names <- unique(all_names)
  }
}
