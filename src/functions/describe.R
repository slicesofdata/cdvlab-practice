# message("Defining describe.R")
ci_vector <- function(x,
                      #                      group = NULL,
                      #                      var = NULL,
                      #                      paired = F,
                      conf = .95, ...
) {

  if ( is.vector({{x}})) {
    data = data.frame(x = rep(1, length(x)), y = x)

    return(
      list(ci.lower = confint(lm(y ~ 1, data = data), level = conf)[1],
           ci.upper = confint(lm(y ~ 1, data = data), level = conf)[2]
      )
    )
  } else {
    message("Not a vector")
  }
}

count_by <- function(data, groupby) {
  dep = c("dplyr", "magrittr")
  pkgs = dep[!(dep %in%  installed.packages()[,"Package"])]
  if(length(pkgs)) install.packages(pkgs)

  suppressMessages(
    return(
      data %>%
        group_by(across({{groupby}})) %>%
        count() %>%
        ungroup()
    )
  )
}

# obtain the most frequent event
Mode <- function(x){
  names(which.max(table(x)))
}

descriptives <- function(data,
                         groupby,
                         var = NULL,
                         trim = .10,
                         conf = .95,
                         ...
                         ) {
  dep = c("dplyr", "DescTools", "moments")
  pkgs = dep[!(dep %in%  installed.packages()[,"Package"])]
  if (length(pkgs)) install.packages(pkgs)

  #####################################################
  # if vector
  #####################################################
  if (!is.data.frame(data)) {
    d = as_tibble(data)
    d[["group"]] = "none"
    #####################################################
    # if character
    #####################################################
    if (is.character(d$value)) {
      suppressMessages(return(summarize(d,
                                        n = dplyr::n(),
                                        smallest_mode = names(which.max(table(d$value))),
                                        modefreq = max(table(d$value)),
                                        modeprop = max(table(d$value))/dplyr::n()
                                        )))
    }
    #####################################################
    # if numeric
    #####################################################
    if (is.numeric(d$value)) {
    suppressMessages(return(
      d |>
      filter(!is.na(value)) |>  # NA are filtered
      summarize(n = dplyr::n(),
                mean = mean(value),
                mean.trim = mean(DescTools::Trim(value, trim = trim)),
                mdn = median(value),
                smallest_mode = names(which.max(table(value))),
                modefreq = max(table(value)),
                modeprop = max(table(value))/dplyr::n(),
                sd  = sd(value),
                se = sd(value)/sqrt(dplyr::n()),
                skew = moments::skewness(value),
                kurt = moments::kurtosis(value),
                min = min(value),
                max = max(value),
                range = (max(value) - min(value)),
                iqr = IQR(value, na.rm = T, type = 7),
                q25 = as.numeric(quantile({{var}}, probs = c(0.25, 0.5, 0.75))[1]),
                q75 = as.numeric(quantile({{var}}, probs = c(0.25, 0.5, 0.75))[3]),
                mad = mad({{var}}),
                sum = sum({{var}}),
                ci.95l = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .95)$conf.int[1], NA),
                ci.95u = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .95)$conf.int[2], NA),
                ci.99l = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .99)$conf.int[1], NA),
                ci.99u = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .99)$conf.int[2], NA)
    )))
    }
  } # end vector summary
  #####################################################
  # if a data frame
  #####################################################
  if (is.data.frame(data)) {
      #####################################################
      # if var is character
      #####################################################
      if (is.character(pull(data, !!enquo(var) ))) {
        suppressMessages(
          return(
            data |>
              filter(!is.na({{var}})) |> # NA are filtered
              group_by(across({{groupby}})) |>
              summarize(n = dplyr::n(),
                        smallest_mode = names(which.max(table({{var}}))),
                        modefreq = max(table({{var}})),
                        modeprop = max(table({{var}}))/dplyr::n()
              ) |> ungroup()
          )
        )
      }
      #####################################################
      # if var is numeric
      #####################################################
      if (is.numeric(pull(data, !!enquo(var) ))) {
        suppressMessages(
        return(
          data |>
            filter(!is.na({{var}})) |>
            group_by(across({{groupby}})) |>
            summarize(n = dplyr::n(),
                      #!enquo(var) = mean({{var}}),
                      mean = mean({{var}}),
                      mean.trim = mean(DescTools::Trim({{var}}, trim = trim)),
                      mdn = median({{var}}),
                      smallest_mode = names(which.max(table({{var}}))),
                      modefreq = max(table({{var}})),
                      modeprop = max(table({{var}}))/dplyr::n(),
                      sd  = sd({{var}}),
                      se = sd({{var}})/sqrt(dplyr::n()),
                      skew = moments::skewness({{var}}),
                      kurt = moments::kurtosis({{var}}),
                      min = min({{var}}),
                      max = max({{var}}),
                      range = (max({{var}}) - min({{var}})),
                      iqr = IQR({{var}}, na.rm = T, type = 7),
                      q25 = as.numeric(quantile({{var}}, probs = c(0.25, 0.5, 0.75))[1]),
                      q75 = as.numeric(quantile({{var}}, probs = c(0.25, 0.5, 0.75))[3]),
                      mad = mad({{var}}),
                      sum = sum({{var}}),
                      ci.95l = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .95)$conf.int[1], NA),
                      ci.95u = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .95)$conf.int[2], NA),
                      ci.99l = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .99)$conf.int[1], NA),
                      ci.99u = ifelse(dplyr::n() > 1, t.test({{var}}, conf.level = .99)$conf.int[2], NA)
            ) |>
            ungroup()
        )
      )
      }
    } # end data frame
} # end function


