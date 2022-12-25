#' plot_umap UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_umap_ui <- function(id){
  ns <- NS(id)
  tagList(

    selectInput(
      inputId = ns("color"),
      label = "Protein expression to color by:",
      choices = c("CD3", "CD19", "CD45RA", "CD4", "CD8a",
                  "CD14", "CD45RO", "CD279_PD-1", "IgG1",
                  "IgG2a", "IgG2b", "CD127", "CD197_CCR7","HLA-DR"),
      selected = "CD45RA",
      multiple = FALSE
    ),
    plotOutput(outputId = ns("umap_plot"))

  )
}

#' plot_umap Server Functions
#'
#' @noRd
mod_plot_umap_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$umap_plot <- renderPlot(
      data_filtered() %>%
        TCRSequenceFunctions::umap_of_protein_expressions(color_by = input$color),
      res = 125
    )

  })
}

## To be copied in the UI
# mod_plot_umap_ui("plot_umap_1")

## To be copied in the server
# mod_plot_umap_server("plot_umap_1")
