#' plot_relevant_binder_frequencies UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_relevant_binder_frequencies_ui <- function(id){
  ns <- NS(id)
  tagList(
    verticalLayout(
      "Object 1",
      "Object 2",
      "Object 3",
      plotly::plotlyOutput(outputId = ns("frequency_plot"))
    )

  )
}

#' plot_relevant_binder_frequencies Server Functions
#'
#' @noRd
mod_plot_relevant_binder_frequencies_server <- function(id, chosen_data_set){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$frequency_plot <- plotly::renderPlotly(
      chosen_data_set() %>%
        TCRSequenceFunctions::relevant_binder_frequency_plot(identifier = barcode)
    )

  })
}

## To be copied in the UI
# mod_plot_relevant_binder_frequencies_ui("plot_relevant_binder_frequencies_1")

## To be copied in the server
# mod_plot_relevant_binder_frequencies_server("plot_relevant_binder_frequencies_1")
