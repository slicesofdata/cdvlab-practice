################################################################################

# functions for ggplot stat_summary() fun or fun.data

################################################################################
trimmed_mean <- function(x) mean(x, trim = 0.1)  # Trim 10% of the values


iqr_summary <- function(x) {
  data.frame(
    y = median(x),
    ymin = quantile(x, 0.25),
    ymax = quantile(x, 0.75)
  )
}

mean_with_sd <- function(x, mult = 3) {
  data.frame(
    y = mean(x),                          # Mean
    ymin = mean(x) - mult * sd(x),        # Mean minus mult * SD
    ymax = mean(x) + mult * sd(x)         # Mean plus mult * SD
  )
}

mean_with_se <- function(x, mult = 1.96) {
  # fix vector for NAs
  x = na.omit(x)
  # standard error of the mean (SEM)
  se = sd(x) / sqrt(length(x))

  data.frame(
    y = mean(x),                          # Mean
    ymin = mean(x) - mult * se,           # Mean minus mult * SEM
    ymax = mean(x) + mult * se            # Mean plus mult * SEM
  )
}


mean_with_ci <- function(x, level = 0.95) {
  # fix vector for NAs
  x = na.omit(x)

  mean_value = mean(x)

  # standard error of the mean
  sem = sd(x) / sqrt(length(x))

  # error for the CI
  ci_error = qt((1 + level) / 2, df = length(x) - 1) * sem

  # Return the mean and the upper/lower bounds of the CI
  return(data.frame(
    y = mean_value,                  # Mean
    ymin = mean_value - ci_error,    # Lower bound of CI
    ymax = mean_value + ci_error     # Upper bound of CI
  ))
}
