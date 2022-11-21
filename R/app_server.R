#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#'
#' @importFrom magrittr %>%
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  data_filtered <- mod_filter_data_set_server("filter_data_set_1")[[1]]
  data_sets <- mod_filter_data_set_server("filter_data_set_1")[[2]]
  mod_summarise_data_server("summarise_data_1",
                            data_filtered = data_filtered,
                            data_sets = data_sets)
  mod_plot_relevant_binder_frequencies_server("plot_relevant_binder_frequencies_1",
                                              data_filtered = data_filtered)
  mod_alpha_beta_distribution_server("alpha_beta_distribution_1",
                                     data_filtered = data_filtered)
  mod_alpha_beta_distinctiveness_server("alpha_beta_distinctiveness_1",
                                        data_filtered = data_filtered)
  mod_plot_count_pr_allele_server("plot_count_pr_allele_1",
                                  data_filtered = data_filtered)
  mod_print_output_server("print_output_1")
  mod_download_server("download_1",
                      data_filtered = data_filtered)
}
