theme_dark_mode <- function(
    base_size = 16,
    base_family = "",
    color_text = "white",
    color_axis_line = "white",
    color_axis_ticks = "white",
    color_axis_text = "white",
    color_legend_text = "white",
    color_plot_title = "white",
    color_plot_subtitle = "white",
    color_strip_text = "white",
    color_panel_border = "black",
    color_panel_grid_major = "black",
    #plot_title_position = "plot",
    ...
    ) {
  theme_minimal(base_size = base_size,
                base_family = base_family,
                ...
                ) +
    theme(
      # Overall appearance
      panel.background = element_rect(fill = "black"),
      plot.background = element_rect(fill = "black"),
      legend.background = element_rect(fill = "black"),
      strip.background = element_rect(fill = "black"),
      # Axis text
      axis.text = element_text(color = color_axis_text),
      # Axis ticks
      axis.ticks = element_line(color = color_axis_ticks),
      # Legend text
      legend.text = element_text(color = color_legend_text),
      # Title text
      plot.title = element_text(color = color_plot_title),
     # plot.title.position = plot_title_position,
      plot.subtitle = element_text(color = color_plot_subtitle),
      # Panel grid lines
      panel.grid.major = element_line(color = color_panel_grid_major),
      panel.grid.minor = element_blank(),
      # Plot border
      panel.border = element_rect(color = color_panel_border, fill = NA),
      # Facet labels
      strip.text = element_text(color = color_strip_text),
      axis.line = element_line(color = color_axis_line),
      ...
    )
}


