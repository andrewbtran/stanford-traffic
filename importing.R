library(readr)

file_list <- list.files("data")

first_file <- read_csv("data/CA-clean.csv")
column_names <- names(first_file)

for (i in 1:length(file_list)) {
  state <- read_csv(paste0("data/", file_list[i]))
  
  if (ncol(state)!=length(column_names)) {
    Missing <- setdiff(column_names, names(state))
    state[Missing] <- NA
  }
  if (i==1) {
    us <- state 
  } else {
    
    if (ncol(state) < ncol(us)) {
      Missing <- setdiff(names(us), names(state))
      state[Missing] <- NA
      us <- rbind(us, state)
    } else if (ncol(state) > ncol(us)) {
      Missing <- setdiff(names(state), names(us))
      us[Missing] <- NA
      us <- rbind(us, state)
    } else if  (ncol(state) == ncol(us)) {
      us <- rbind(us, state)
      
    }
  }
  rm(state)
}

saveRDS(first_file, file="us.RDa")
rm(us)
#us <- readRDS(file="us.Rda")
