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
        inputId = ns("UMI_count_min"),
        label = "Threshold for UMI-count",
        min = 0,
        max = 100,
        value = 10,
        step = 1
      ),
      sliderInput(
        inputId = ns("non_specific_UMI_count_min"),
        label = "Threshold for UMI-count of non-specific binders",
        min = 0,
        max = 50,
        value = 5,
        step = 1
      ),
      br(),
      actionButton(ns("reset_sliders"),
                   "Reset sliders to 10x-standard")
    )


  )
}

#' choose_thresholds Server Functions
#'
#' @noRd
mod_choose_thresholds_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observeEvent(input$reset_sliders, {
      updateSliderInput(session,"UMI_count_min",value = 10)
      updateSliderInput(session,"non_specific_UMI_count_min",value = 5)
    })

    return_list <- list(UMI_count_min = reactive(input$UMI_count_min),
                        non_specific_UMI_count_min = reactive(input$non_specific_UMI_count_min))
    return(return_list)


  })
}

## To be copied in the UI
# mod_choose_thresholds_ui("choose_thresholds_1")

## To be copied in the server
# mod_choose_thresholds_server("choose_thresholds_1")
