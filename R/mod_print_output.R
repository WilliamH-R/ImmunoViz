#' print_output UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_print_output_ui <- function(id){
  ns <- NS(id)
  tagList(
    textOutput(outputId = ns("variable_to_print"))
  )
}

#' print_output Server Functions
#'
#' @noRd
mod_print_output_server <- function(id, threshold){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$variable_to_print <- renderText({
      threshold()
    })

  })
}

## To be copied in the UI
# mod_print_output_ui("print_output_1")

## To be copied in the server
# mod_print_output_server("print_output_1")
