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
mod_download_server <- function(id, data_filtered, data_sets, HLA_typings,
                                UMI_count_min, negative_control_UMI_count_min,
                                additional_filters){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$downloadData <- downloadHandler(
      filename = stringr::str_c('TCRSequences-', Sys.Date(), '.zip'),
      content = function(fname) {

        data_filtered_name <- stringr::str_c('data_filtered',
                                    Sys.Date(),
                                    '.csv')
        meta_data_name <- stringr::str_c('meta_data',
                                Sys.Date(),
                                '.csv')

        #write.csv(data_filtered(),
        #          file = data_filtered_name,
        #          row.names=FALSE)
        write.csv(tibble::tribble(~variable, ~value,
                                  "Data sets", data_sets(),
                                  "HLA-typings", HLA_typings(),
                                  "Min. UMI-count", stringr::str_c(UMI_count_min()),
                                  "Non-specific binder multiplier", stringr::str_c(negative_control_UMI_count_min()),
                                  "Additional filters", additional_filters()) %>%
                    tidyr::unnest(cols = value),
                  file = meta_data_name,
                  row.names=FALSE)
      }
    )
  })
}

## To be copied in the UI
# mod_download_ui("download_1")

## To be copied in the server
# mod_download_server("download_1")
