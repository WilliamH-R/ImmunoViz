#' alpha_beta_consistency UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_alpha_beta_consistency_ui <- function(id){
  ns <- NS(id)
  tagList(

    plotOutput(outputId = ns("consistency_plot"))

  )
}

#' alpha_beta_consistency Server Functions
#'
#' @noRd
mod_alpha_beta_consistency_server <- function(id, chosen_data_set){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$consistency_plot <- renderPlot(
      chosen_data_set() %>%
        TCRSequenceFunctions::alpha_beta_consistency(),
      res = 125
    )

  })
}

## To be copied in the UI
# mod_alpha_beta_consistency_ui("alpha_beta_consistency_1")

## To be copied in the server
# mod_alpha_beta_consistency_server("alpha_beta_consistency_1")
