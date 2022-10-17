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
    verticalLayout(
      sliderInput(
        inputId = ns("min_UMI_count"),
        label = "Threshold for UMI-count",
        min = 0,
        max = 100,
        value = 10,
        step = 1
      ),
      sliderInput(
        inputId = ns("non_specific_threshold"),
        label = "Threshold for UMI-count of non-specific binders",
        min = 0,
        max = 50,
        value = 5,
        step = 1
      )
    )


  )
}

#' choose_thresholds Server Functions
#'
#' @noRd
mod_choose_thresholds_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    threshold <- reactive(
        input$min_UMI_count
      )
    return(threshold)
    '
    non_specific_threshold <- reactive(
        input$non_specific_threshold
      )
    return(list(threshold = threshold,
                non_specific_threshold = non_specific_threshold))
    Virker nu, men vil gerne kunne outputte to ting på én gang'
  })
}

## To be copied in the UI
# mod_choose_thresholds_ui("choose_thresholds_1")

## To be copied in the server
# mod_choose_thresholds_server("choose_thresholds_1")
