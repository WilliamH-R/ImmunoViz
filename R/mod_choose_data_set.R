#' filter_data_set UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_filter_data_set_ui <- function(id){
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
      checkboxGroupInput(inputId = ns("only_non_promiscuous_pairs"),
                         label = "Should only non-promiscuous pairs be included?",
                         choices = c("Yes" = TRUE)
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
      actionButton(ns("reset_sliders"),
                   "Reset sliders to 10x-standard")
      )
    )
}

#' filter_data_set Server Functions
#'
#' @noRd
mod_filter_data_set_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observeEvent(input$reset_sliders, {
      updateSliderInput(session = session,
                        label = "UMI_count_min",
                        value = 10)
      updateSliderInput(session = session,
                        label = "non_specific_UMI_count_min",
                        value = 5)
    })

    data_sets <- reactive(
      input$data_sets
    )

    data_filtered <- reactive(
      TCRSequenceFunctions::data_combined_tidy %>%
        dplyr::filter(donor %in% input$data_sets,
                      HLA_match %in% input$HLA_typings) %>%
        {if ((length(input$only_non_promiscuous_pairs)) != 0) tidyr::drop_na(., non_promiscuous_pair) else .}
      )

    return(list(data_filtered = data_filtered,
                data_sets = data_sets))
})
}

## To be copied in the UI
# mod_filter_data_set_ui("filter_data_set_1")

## To be copied in the server
# mod_filter_data_set_server("filter_data_set_1")
