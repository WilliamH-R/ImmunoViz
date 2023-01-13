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
      choices = c("CD8a", "CD3", "CD45RA", "CD45RO",
                  "CD197_CCR7", "CD279_PD-1", "HLA-DR",
                  "CD127", "CD4", "CD14", "CD19"),
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
        ImmunoCleaner::umap_of_protein_expressions(color_by = input$color),
      res = 125
    )

  })
}

## To be copied in the UI
# mod_plot_umap_ui("plot_umap_1")

## To be copied in the server
# mod_plot_umap_server("plot_umap_1")
