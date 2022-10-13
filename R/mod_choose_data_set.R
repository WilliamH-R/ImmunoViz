#' choose_data_set UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_choose_data_set_ui <- function(id){
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("data_set"),
      label = "Choose data set",
      choices = c("First donor" = "donor_one",
                  "Second donor" = "donor_two",
                  "Third donor" = "donor_three",
                  "Fourth donor" = "donor_four"),
      selectize = FALSE,
      size = 4
    )
  )
}

#' choose_data_set Server Functions
#'
#' @noRd
mod_choose_data_set_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    chosen_data_set <-
      reactive(
        if (input$data_set == "donor_one") {
          TCRSequenceFunctions::data_donor_one
        } else if (input$data_set == "donor_two") {
          TCRSequenceFunctions::data_donor_two
        } else if (input$data_set == "donor_three") {
          TCRSequenceFunctions::data_donor_three
        } else if (input$data_set == "donor_four") {
          TCRSequenceFunctions::data_donor_four
        }
      )
})
}

## To be copied in the UI
# mod_choose_data_set_ui("choose_data_set_1")

## To be copied in the server
# mod_choose_data_set_server("choose_data_set_1")
