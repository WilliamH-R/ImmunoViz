#' plot_count_pr_allele UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_count_pr_allele_ui <- function(id){
  ns <- NS(id)
  tagList(

    plotOutput(outputId = ns("count_plot"))

  )
}

#' plot_count_pr_allele Server Functions
#'
#' @noRd
mod_plot_count_pr_allele_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$count_plot <- renderPlot(
      data_filtered() %>%
        ImmunoCleaner::count_binding_pr_allele(),
      res = 125
    )

  })
}

## To be copied in the UI
# mod_plot_count_pr_allele_ui("plot_count_pr_allele_1")

## To be copied in the server
# mod_plot_count_pr_allele_server("plot_count_pr_allele_1")
