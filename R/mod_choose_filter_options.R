#' choose_filter_options UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_choose_filter_options_ui <- function(id){
  ns <- NS(id)
  tagList(

  )
}

#' choose_filter_options Server Functions
#'
#' @noRd
mod_choose_filter_options_server <- function(id){
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
# mod_choose_filter_options_ui("choose_thresholds_1")

## To be copied in the server
# mod_choose_filter_options_server("choose_thresholds_1")
