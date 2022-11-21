#' readme UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_readme_ui <- function(id){
  ns <- NS(id)
  tagList(
    h3("How to use the Shiny Application"),
    p("On the left hand side a side bar panel is shown. Here it is possible to
      select various filters. E.g. data from which donor(s) to use, which
      HLA-matches to include and a couple sliders. Whether or not an interaction
      between a pMHC and TCR-sequence is evaluated to relevant depend on these
      sliders. The default is set to the threshold chosen by 10x Genomics.
      Updating these sliders will then re-evaluate whether or not a interaction
      is relevant, and thereby also which data points to include in the shown
      plots and tables. Changing the tick boxes will also automatically update
      the plots and tables. At the bottom of said side bar panel is a download
      button. This will allow the user to download the data file presently
      used for plotting and similar. I.e, it will download the data file with
      applied filtering."),
    hr(),
    h3("HLA-typings"),
    p("The HLA-matching is done by matching the data with with typings given in
      the article from 10x Genomics from which these data sets come from. The
      table are as shown:"),
    tableOutput(outputId = ns("HLA_table"))
  )
}

#' readme Server Functions
#'
#' @noRd
mod_readme_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$HLA_table <- renderTable(TCRSequenceFunctions::aux_alleles_status_each_donor)

  })
}

## To be copied in the UI
# mod_readme_ui("readme_1")

## To be copied in the server
# mod_readme_server("readme_1")
