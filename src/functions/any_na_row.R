any_na_row <- function(data,
                       var_name = "any_rows_na"
) {
  data =
    {{data}} |>
    rowwise() |>
    mutate({{var_name}} := any(is.na(across(everything())))) |>
    relocate({{var_name}}, .before = 1) |>
    ungroup()
  return(data)
}
