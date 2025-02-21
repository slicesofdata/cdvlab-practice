library(DT)
library(htmltools)

view_html <- function(object,
                      rows = FALSE,
                      show = 100,
                      render_mode = "dark",
                      ...
                      ) {

  if (!requireNamespace("DT", quietly = TRUE)) {
    stop("DT library not installed")
  }

  #if (tibble::is_tibble(object)) {
  object <- as.data.frame(object)
  # message("converted tibble to dataframe for viewing")
  #}

  apply_dark_mode <- function(datatable_object) {
    datatable_object |>
      htmlwidgets::prependContent(
        tags$style(HTML("
          .dataTables_wrapper {
            background-color: black !important;
            color: white !important;
          }
          table.dataTable thead {
            background-color: #333 !important;
            color: white !important;
          }
          table.dataTable tbody {
            background-color: black !important;
            color: white !important;
          }
          table.dataTable tbody tr {
            background-color: black !important;
            color: white !important;
          }
          table.dataTable tbody tr:nth-child(even) {
            background-color: #444 !important;
          }
          table.dataTable tbody tr:hover {
            background-color: #555 !important;
          }
          table.dataTable tfoot {
            background-color: #333 !important;
            color: white !important;
          }
          .dataTables_filter input {
            background-color: #333 !important;
            color: white !important;
          }
          .dataTables_filter label {
            color: white !important;
          }
          .dataTables_length select {
            background-color: #333 !important;
            color: white !important;
          }
          .dataTables_length label {
            color: white !important;
          }
        "))
      )
  }

  if (is.null(dim(object)) & class(object) == "list") {
    message("Object is a list. Viewer displays last list element. Consider passing each element to view().")

    lapply(object, function(x) {
      # build the basic table
      dt <- datatable(x, rownames = rows, options = list(pageLength = show))
      # apply color mode
      if (render_mode == "light") {
        dt <- dt
      }
      
      if (render_mode == "dark") {
        dt <- apply_dark_mode(dt)
      }
      # render table
      dt
    })
  } else {
    dt <- datatable(object, rownames = rows, options = list(pageLength = show))
    if (render_mode == "light") {
      dt <- dt
    }
    if (render_mode == "dark") {
      dt <- apply_dark_mode(dt)
    }
    # render table
    dt
  }
}


view_html_old <- function(object, rows = F, show = 100, ...) {

  if (!require(DT)) {

    stop("DT library not installed")

  } else {

    if (tibble::is_tibble(object)) {
      object = as.data.frame(object)
      # message("converted tibble to dataframe for viewing")
    }

    if (is.null(dim(object)) & class(object) == "list") {
      message("Object is a list. Viewer displays last list element. Consider passing each element to view().")

      lapply(object, function(x) {
        DT::datatable(x,
                      rownames = rows,
                      filter = "top",
                      options = list(pageLength = show))
      })
    } else {
      DT::datatable(object,
                    rownames = rows,
                    filter = "top",
                    options = list(pageLength = show))
    }
  }
}

