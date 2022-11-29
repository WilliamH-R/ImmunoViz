#' count_rows UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_count_rows_ui <- function(id){
  ns <- NS(id)
  tagList(

    h5("The total number of rows is currenctly:"),
    verbatimTextOutput(outputId = ns("count_rows_total")),
    h5("The number of unique barcodes is currently :"),
    verbatimTextOutput(outputId = ns("count_rows_unique_barcode"))

  )
}

#' count_rows Server Functions
#'
#' @noRd
mod_count_rows_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$count_rows_total <- renderPrint({
      data_filtered() %>%
        nrow()
    })

    output$count_rows_unique_barcode <- renderPrint({
      data_filtered() %>%
        dplyr::distinct(barcode) %>%
        nrow()
    })

  })
}

## To be copied in the UI
# mod_count_rows_ui("count_rows_1")

## To be copied in the server
# mod_count_rows_server("count_rows_1")
