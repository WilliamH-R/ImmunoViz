#' choose_thresholds UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_choose_thresholds_ui <- function(id){
  ns <- NS(id)
  tagList(
    sliderInput(
      inputId = ns("threshold"),
      label = "Threshold for UMI-count",
      min = 0,
      max = 100,
      value = 10,
      step = 1
    )

  )
}

#' choose_thresholds Server Functions
#'
#' @noRd
mod_choose_thresholds_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    threshold <-
      reactive(
        input$threshold
      )

  })
}

## To be copied in the UI
# mod_choose_thresholds_ui("choose_thresholds_1")

## To be copied in the server
# mod_choose_thresholds_server("choose_thresholds_1")
