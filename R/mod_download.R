#' download UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_download_ui <- function(id){
  ns <- NS(id)
  tagList(

    downloadButton(outputId = ns('downloadData'),
                   label = 'Download data')

  )
}

#' download Server Functions
#'
#' @noRd
mod_download_server <- function(id, data_filtered){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$downloadData <- downloadHandler(
      filename = function() {
        paste('data-', Sys.Date(), '.csv', sep='')
      },
      content = function(file) {
        write.csv(data_filtered(), file)
      }
    )

  })
}

## To be copied in the UI
# mod_download_ui("download_1")

## To be copied in the server
# mod_download_server("download_1")
