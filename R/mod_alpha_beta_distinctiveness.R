#' alpha_beta_sequence_distinctiveness UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_alpha_beta_sequence_distinctiveness_ui <- function(id){
  ns <- NS(id)
  tagList(

    plotOutput(outputId = ns("distinctiveness_plot"))

  )
}

#' alpha_beta_sequence_distinctiveness Server Functions
#'
#' @noRd
mod_alpha_beta_sequence_distinctiveness_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$distinctiveness_plot <- renderPlot(
      data_filtered() %>%
        ImmunoCleaner::alpha_beta_sequence_distinctiveness(),
      res = 125
    )

  })
}

## To be copied in the UI
# mod_alpha_beta_sequence_distinctiveness_ui("alpha_beta_sequence_distinctiveness_1")

## To be copied in the server
# mod_alpha_beta_sequence_distinctiveness_server("alpha_beta_sequence_distinctiveness_1")
