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
                         selected = c("donor1")
                         ),
      checkboxGroupInput(inputId = ns("HLA_typings"),
                         label = "Choose which HLA-typings to include:",
                         choices = c("True matches" = "TRUE",
                                     "Unknown matches" = "UNKNOWN",
                                     "False matches" = "FALSE"),
                         selected = c("TRUE", "UNKNOWN", "FALSE")
                         ),
      checkboxGroupInput(inputId = ns("additional_filters"),
                         label = "Additional filters",
                         choices = c("Include only non-promiscuous pairs" = "only_non_promiscuous",
                                     "Remove uniquely observed TCR-pMHC matches" = "exclude_unique",
                                     "Choose UMI-count thresholds (Note: will increase computational time)" = "UMI_thresholds")
                         ),
      conditionalPanel(
        condition = "input.additional_filters.indexOf('UMI_thresholds') != -1",
        ns = ns,
        sliderInput(
          inputId = ns("UMI_count_min"),
          label = "Threshold for UMI-count",
          min = 0,
          max = 100,
          value = 10,
          step = 1
        ),
        sliderInput(
          inputId = ns("negative_control_UMI_count_min"),
          label = "Multiplication factor for threshold for UMI-count of negative controls",
          min = 0,
          max = 50,
          value = 5,
          step = 1
        )),
      hr(),
      actionButton(inputId = ns("reset_filters"),
                   label = "Reset filters to 10x-standard"),
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

    data_filtered <- eventReactive(input$update_data,
                                   ignoreNULL = FALSE, {

                                     validate(
                                       need(input$data_sets != "", "Please choose at least one donor"),
                                       need(input$HLA_typings != "", "Please choose at least one type of HLA-match")
                                     )

                                     TCRSequenceFunctions::data_combined_tidy %>%
                                       dplyr::filter(donor %in% input$data_sets,
                                                     HLA_match %in% input$HLA_typings) %>%
                                       {if ("only_non_promiscuous" %in% input$additional_filters) tidyr::drop_na(., non_promiscuous_pair) else .} %>%
                                       {if ("exclude_unique" %in% input$additional_filters) dplyr::filter(., unique_binder == FALSE) else .} %>%
                                       {if ("UMI_thresholds" %in% input$additional_filters) TCRSequenceFunctions::evaluate_binder(.,
                                                                                                                                  UMI_count_min = input$UMI_count_min,
                                                                                                                                  negative_control_UMI_count_min = input$negative_control_UMI_count_min) else .} %>%
                                       dplyr::filter(is_binder == TRUE)
    })

    data_sets <- eventReactive(input$update_data,
                               ignoreNULL = FALSE, {
                                 input$data_sets
                                 })

    HLA_typings <- eventReactive(input$update_data,
                                 ignoreNULL = FALSE, {
                                   input$HLA_typings
                                   })

    additional_filters <- eventReactive(input$update_data,
                                        ignoreNULL = FALSE, {
                                          input$additional_filters
                                          })

    UMI_count_min <- eventReactive(input$update_data,
                                   ignoreNULL = FALSE, {
                                     input$UMI_count_min
                                     })

    negative_control_UMI_count_min <- eventReactive(input$update_data,
                                                ignoreNULL = FALSE, {
                                                  input$negative_control_UMI_count_min
                                                  })

    observeEvent(input$reset_filters, {
      updateSliderInput(inputId = "UMI_count_min",
                        value = 10)
      updateSliderInput(inputId = "negative_control_UMI_count_min",
                        value = 5)
      updateCheckboxGroupInput(inputId = "data_sets",
                               selected = c("donor1", "donor2",
                                            "donor3", "donor4"))
      updateCheckboxGroupInput(inputId = "HLA_typings",
                               selected = c("TRUE", "UNKNOWN", "FALSE"))
      updateCheckboxGroupInput(inputId = "additional_filters",
                               selected = c("UMI_thresholds"))
    })

    return(list(data_filtered = data_filtered,
                data_sets = data_sets,
                HLA_typings = HLA_typings,
                additional_filters = additional_filters,
                UMI_count_min = UMI_count_min,
                negative_control_UMI_count_min = negative_control_UMI_count_min
                ))
})
}

## To be copied in the UI
# mod_filter_data_set_ui("filter_data_set_1")

## To be copied in the server
# mod_filter_data_set_server("filter_data_set_1")
