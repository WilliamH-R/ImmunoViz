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

  #filter_options <- mod_choose_filter_options_server("choose_filter_options_1")
  chosen_data_set <- mod_choose_data_set_server("choose_data_set_1")
  mod_summarise_data_server("summarise_data_1",
                            chosen_data_set = chosen_data_set)
  mod_plot_relevant_binder_frequencies_server("plot_relevant_binder_frequencies_1",
                                              chosen_data_set = chosen_data_set)
  mod_alpha_beta_distribution_server("alpha_beta_distribution_1",
                                     chosen_data_set = chosen_data_set)
  mod_alpha_beta_consistency_server("alpha_beta_consistency_1",
                                    chosen_data_set = chosen_data_set)
  mod_plot_count_pr_allele_server("plot_count_pr_allele_1",
                                  chosen_data_set = chosen_data_set)
  mod_print_output_server("print_output_1")
}
