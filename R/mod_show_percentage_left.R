#' show_percentage_left UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_show_percentage_left_ui <- function(id){
  ns <- NS(id)
  tagList(

    tableOutput(outputId = ns("percentage_table"))

  )
}

#' show_percentage_left Server Functions
#'
#' @noRd
mod_show_percentage_left_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$percentage_table <- renderTable(
      data_filtered() %>%
        ImmunoCleaner::percentage_rows_kept())

  })
}

## To be copied in the UI
# mod_show_percentage_left_ui("show_percentage_left_1")

## To be copied in the server
# mod_show_percentage_left_server("show_percentage_left_1")
