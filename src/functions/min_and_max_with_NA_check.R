# Custom function to calculate minimum with NA handling
min_with_NA_check <- function(x) {
  if (any(!is.na(x))) {
    return(min(x, na.rm = TRUE))
  } else {
    return(NA)  # Return NA if all values are NA
  }
}

# Custom function to calculate maximum with NA handling
max_with_NA_check <- function(x) {
  if (any(!is.na(x))) {
    return(max(x, na.rm = TRUE))
  } else {
    return(NA)  # Return NA if all values are NA
  }
}
