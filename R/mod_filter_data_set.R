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
                         selected = c("donor1", "donor2",
                                      "donor3", "donor4")
                         ),
      checkboxGroupInput(inputId = ns("HLA_typings"),
                         label = "Choose which HLA-typings to include:",
                         choices = c("True matches" = "TRUE",
                                     "Unknown matches" = "UNKNOWN",
                                     "False matches" = "FALSE"),
                         selected = c("TRUE", "UNKNOWN", "FALSE")
                         ),
      checkboxGroupInput(inputId = "additional_filters",
                         label = "Additional filters",
                         choices = c("Include only non-promiscuous pairs" = "only_non_promiscuous",
                                     "Remove unique TCR-pMHC matches" = "exclude_unique",
                                     "Choose UMI-count thresholds" = "UMI_thresholds")
                         ),
      conditionalPanel(
        condition = "input.additional_filters.indexOf('UMI_thresholds') != -1",
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
        actionButton(inputId = ns("reset_sliders"),
                     label = "Reset sliders to 10x-standard")
        ),
      hr(),
      actionButton(inputId = ns("update_data"),
                   label = "Update data")
      )
    )
}

#' filter_data_set Server Functions
#'
#' @noRd
mod_filter_data_set_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    data_filtered <- reactive(TCRSequenceFunctions::data_combined_tidy)
    data_sets <- reactive(input$data_sets)



    observeEvent(input$update_data, {

      data_sets_new <- input$data_sets

      data_filtered_new <- TCRSequenceFunctions::data_combined_tidy %>%
        dplyr::filter(donor %in% input$data_sets,
                      HLA_match %in% input$HLA_typings) %>%
        {if ("only_non_promiscuous" %in% input$additional_filters) tidyr::drop_na(., non_promiscuous_pair) else .} %>%
        {if ("exclude_unique" %in% input$additional_filters) dplyr::filter(., unique_binder == FALSE) else .} %>%
        {if ("UMI_thresholds" %in% input$additional_filters) TCRSequenceFunctions::evaluate_binder(., UMI_count_min = input$UMI_count_min,
                                                                                                   non_specific_UMI_count_min = input$non_specific_UMI_count_min) else .}

      data_filtered(data_filtered_new)
      data_sets(data_sets_new)
    })

    observeEvent(input$reset_sliders, {
      updateSliderInput(session = session,
                        inputId = "UMI_count_min",
                        value = 10)
      updateSliderInput(session = session,
                        inputId = "non_specific_UMI_count_min",
                        value = 5)
    })

    return(list(data_filtered = data_filtered(),
                data_sets = data_sets()))
})
}

## To be copied in the UI
# mod_filter_data_set_ui("filter_data_set_1")

## To be copied in the server
# mod_filter_data_set_server("filter_data_set_1")
