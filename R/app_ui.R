#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    # Your application UI logic
    fluidPage(

      # App title
      titlePanel("TCRSequenceShiny"),

      #
      sidebarLayout(
        sidebarPanel(
          verticalLayout(
            title = h4("Choose data set and settings"),
            mod_filter_data_set_ui("filter_data_set_1"),
            hr(),
            mod_count_rows_ui("count_rows_1"),
            hr(),
            h4("Download data with the filters applied from above"),
            mod_download_ui("download_1")
          )),

      mainPanel(
        tabsetPanel(
          tabPanel(title = "Descriptive Statistics",
                   h3("Show distribution of relevant binders grouped by user
                      selection to compare with and without filtering"),
                   mod_summarise_data_ui("summarise_data_1")
                   ),
          tabPanel(title = "Data check",
                   h3("Check distributions of the loaded data set"),
                   mod_alpha_beta_distinctiveness_ui("alpha_beta_distinctiveness_1"),
                   hr(),
                   mod_alpha_beta_distribution_ui("alpha_beta_distribution_1"),
                   hr(),
                   mod_plot_count_pr_allele_ui("plot_count_pr_allele_1")
                   ),
          tabPanel(title = "Data exploration",
                   br(),
                   h3("Check binding events between pMHC and non-promiscuous
                      TCR-sequences along with concordance and within-TCR barcode
                      count"),
                   mod_plot_relevant_binder_frequencies_ui("plot_relevant_binder_frequencies_1"),
                   h3("Umap of all protein expression levels"),
                   mod_plot_umap_ui("plot_umap_1")
                   ),
          tabPanel(title = "readme",
                   mod_readme_ui("readme_1")
                   )
          )
        )

      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "TCRSequenceShiny"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
