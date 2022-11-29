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
                         label = "Choose variables to group by:",
                         choices = c("Allele" = "allele",
                                     "Peptide" = "peptide",
                                     "Protein source" = "peptide_source"),
                         selected = "allele"
                         ),
      mainPanel(tableOutput(outputId = ns("summarise_table")))
      )

  )
}

#' summarise_data Server Functions
#'
#' @noRd
mod_summarise_data_server <- function(id, data_filtered, data_sets){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$summarise_table <- renderTable(
      data_filtered() %>%
        TCRSequenceFunctions::summarise_with_filter(summarise_by = input$summarise_by))

  })
}

## To be copied in the UI
# mod_summarise_data_ui("summarise_data_1")

## To be copied in the server
# mod_summarise_data_server("summarise_data_1")
