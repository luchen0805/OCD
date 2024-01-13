# create a hello_world function
snow <- TRUE

hello_world <- function(day, weather) {
  if (day == "Tuesday" && weather == TRUE) { # if it is Tuesday and it snows
    "I will take the bus to the school."
  } else if (day == "Tuesday" && weather == FALSE) { # if it is Tuesday and it dose not snow
    "I will walk to school."
  } else if (day != "Tuesday" && weather == TRUE) { # if it is not Tuesday and it snows
    "I will stay at home."
  } else { # if it is not Tuesday and it does not snow
    "I will do grocery shopping."
  }
}

hello_world(day = "Tuesday", weather = TRUE) # Tuesday and snow
hello_world(day = "Tuesday", weather = FALSE) # Tuesday and no snow
hello_world(day = "Monday", weather = TRUE) # not Tuesday and snow
hello_world(day = "Monday", weather = FALSE) # not Tuesday and no snow

# create a while loop
i <- 1
while (i <= 9) { # while i is equal to and smaller than 8
  print(i)
  i <- i+2 # add 2 to the value of i
}
