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
      filename = paste('TCRSequences-', Sys.Date(), '.zip', sep=''),
      content = function(fname) {

        data_filtered_name <- paste('data_filtered',
                                    Sys.Date(),
                                    '.csv',
                                    sep = '')
        meta_data_name <- paste('meta_data',
                                Sys.Date(),
                                '.csv',
                                sep = '')

        write.csv(data_filtered(),
                  file = data_filtered_name,
                  row.names=FALSE)
        write.csv(tibble::tribble(~variable, ~value,
                                  "Data sets", "A0201",
                                  "HLA-typings", "asd",
                                  "Min. UMI-count", "asd",
                                  "Non-specific binder multiplier", "asd",
                                  "Additional filters", "asd"),
                  file = meta_data_name,
                  row.names=FALSE)

        zip(zipfile = fname,
            files = c(data_filtered_name, meta_data_name))
        browser()
      },
      contentType = "application/zip"
    )

  })
}

## To be copied in the UI
# mod_download_ui("download_1")

## To be copied in the server
# mod_download_server("download_1")
