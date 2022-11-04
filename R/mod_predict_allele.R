#' predict_allele UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_predict_allele_ui <- function(id){
  ns <- NS(id)
  tagList(

    verbatimTextOutput(outputId = ns("predicted_allele_type"))

  )
}

#' predict_allele Server Functions
#'
#' @noRd
mod_predict_allele_server <- function(id, chosen_data_set){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$predicted_allele_type <- renderPrint(
      chosen_data_set() %>%
        TCRSequenceFunctions::predict_allele_typing()
    )

  })
}

## To be copied in the UI
# mod_predict_allele_ui("predict_allele_1")

## To be copied in the server
# mod_predict_allele_server("predict_allele_1")
