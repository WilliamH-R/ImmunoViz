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
    verticalLayout(
      checkboxGroupInput(inputId = ns("data_sets"),
                         label = "Choose data set(s):",
                         choices = c("First donor" = "donor1",
                                     "Second donor" = "donor2",
                                     "Third donor" = "donor3",
                                     "Fourth donor" = "donor4"),
                         selected = "donor1"
                         ),
      checkboxGroupInput(inputId = ns("HLA_typings"),
                         label = "Choose which HLA-typings to include:",
                         choices = c("True matches" = "TRUE",
                                     "Unknown matches" = "UNKNOWN",
                                     "False matches" = "FALSE"),
                         selected = c("TRUE", "UNKNOWN", "FALSE")
                         ),
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

#' choose_data_set Server Functions
#'
#' @noRd
mod_choose_data_set_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observeEvent(input$reset_sliders, {
      updateSliderInput(session,"UMI_count_min",value = 10)
      updateSliderInput(session,"non_specific_UMI_count_min",value = 5)
    })

    chosen_data_set <-
      reactive(
        TCRSequenceFunctions::data_combined_tidy %>%
          dplyr::filter(donor == input$data_sets,
                        HLA_match == input$HLA_typings)
      )
    return(chosen_data_set)
})
}

## To be copied in the UI
# mod_choose_data_set_ui("choose_data_set_1")

## To be copied in the server
# mod_choose_data_set_server("choose_data_set_1")
