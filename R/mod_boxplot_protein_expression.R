#' boxplot_protein_expression UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_boxplot_protein_expression_ui <- function(id){
  ns <- NS(id)
  tagList(

    selectInput(
      inputId = ns("protein"),
      label = "Protein expression to color by:",
      choices = c("CD3", "CD19", "CD45RA", "CD4", "CD8a",
                  "CD14", "CD45RO", "CD279_PD-1", "IgG1",
                  "IgG2a", "IgG2b", "CD127", "CD197_CCR7","HLA-DR"),
      selected = "CD45RA",
      multiple = FALSE
    ),
    plotOutput(outputId = ns("expression_boxplot"))

  )
}

#' boxplot_protein_expression Server Functions
#'
#' @noRd
mod_boxplot_protein_expression_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$expression_boxplot <- renderPlot(
      data_filtered() %>%
        TCRSequenceFunctions::boxplot_protein_expressions(plot_protein = input$protein),
      res = 125
    )

  })
}

## To be copied in the UI
# mod_boxplot_protein_expression_ui("boxplot_protein_expression_1")

## To be copied in the server
# mod_boxplot_protein_expression_server("boxplot_protein_expression_1")
