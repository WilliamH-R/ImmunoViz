#' summarise_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_summarise_data_ui <- function(id){
  ns <- NS(id)
  tagList(
    sidebarLayout(
      checkboxGroupInput(inputId = ns("summarise_by"),
                         "Choose variables to group by:",
                         c("Allele" = "allele",
                           "Peptide" = "peptide",
                           "Protein source" = "peptide_source")
                         ),
      mainPanel(dataTableOutput(outputId = ns("summarise_table"))))

  )
}

#' summarise_data Server Functions
#'
#' @noRd
mod_summarise_data_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$summarise_table <- renderDataTable(
      TCRSequenceFunctions::vdj_v1_hs_aggregated_donor1_binarized_matrix %>%
        TCRSequenceFunctions::run_all_prep() %>%
        TCRSequenceFunctions::summarise_with_filter(input$summarise_by,
                                                    identifier = barcode)
    )

  })
}

## To be copied in the UI
# mod_summarise_data_ui("summarise_data_1")

## To be copied in the server
# mod_summarise_data_server("summarise_data_1")
