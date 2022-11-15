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
    checkboxGroupInput(inputId = ns("data_sets"),
                       label = "Choose data set(s):",
                       choices = c("First donor" = "donor_one",
                                   "Second donor" = "donor_two",
                                   "Third donor" = "donor_three",
                                   "Fourth donor" = "donor_four"),
                       selected = "donor_one"
    ),
    verbatimTextOutput(outputId = ns("variable_to_print"))
  )
}

#' print_output Server Functions
#'
#' @noRd
mod_print_output_server <- function(id, UMI_count_min, non_specific_UMI_count_min){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$variable_to_print <- renderPrint({
      input$data_sets
    })

  })
}

## To be copied in the UI
# mod_print_output_ui("print_output_1")

## To be copied in the server
# mod_print_output_server("print_output_1")
