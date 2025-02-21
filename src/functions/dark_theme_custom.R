theme_dark_custom <- function() {
  theme_minimal() +
    theme(
      text = element_text(color = "white"),
      plot.background = element_rect(fill = "#121212", color = NA),
      panel.background = element_rect(fill = "#121212", color = NA),
      panel.grid.major = element_line(color = "#333333"),
      panel.grid.minor = element_line(color = "#222222"),
      axis.text = element_text(color = "white"),
      axis.title = element_text(color = "white"),
      legend.background = element_rect(fill = "#121212", color = NA),
      legend.key = element_rect(fill = "#121212", color = NA),
      strip.background = element_rect(fill = "#333333", color = NA),
      strip.text = element_text(color = "white")
    )
}
