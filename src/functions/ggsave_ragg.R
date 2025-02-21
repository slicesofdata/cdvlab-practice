################################################################################
# Saves files and png using {ragg}
################################################################################
ggsave_ragg <- function(
    filename,
    plot = last_plot(),
    device = ragg::agg_png,
    overwrite = FALSE
) {
  if (!missing(filename)) {

    if (file.exists(filename) & overwrite == TRUE) {
      ggsave(
        filename,
        plot = {{plot}},              # last_plot(),  the default is the last plot
        device = {{device}},
        dpi = 320
      )
    } else {
      message("Filename already exists (use overwrite = TRUE to overwrite):\n   ", filename)
    }
  } else {
    message("Missing argument for filename.")
  }
}

#ggsave_ragg(filename = here::here("report", "figs", "my_plot.png"))
