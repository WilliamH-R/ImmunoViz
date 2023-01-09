#' plot_relevant_binders_plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_relevant_binders_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    verticalLayout(
      sliderInput(
        inputId = ns("max_frequency"),
        label = "Threshold for concordance:",
        min = 0,
        max = 1,
        value = 1,
        step = 0.1
      ),
      plotly::plotlyOutput(outputId = ns("frequency_plot"))
    )

  )
}

#' plot_relevant_binders_plot Server Functions
#'
#' @noRd
mod_plot_relevant_binders_plot_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$frequency_plot <- plotly::renderPlotly(
      data_filtered() %>%
        TCRSequenceFunctions::relevant_binders_plot(identifier = barcode,
                                                    max_frequency = input$max_frequency)
    )

  })
}

## To be copied in the UI
# mod_plot_relevant_binders_plot_ui("plot_relevant_binders_plot_1")

## To be copied in the server
# mod_plot_relevant_binders_plot_server("plot_relevant_binders_plot_1")
