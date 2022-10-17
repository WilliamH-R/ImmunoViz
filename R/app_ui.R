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
          mod_choose_data_set_ui("choose_data_set_1"),
          mod_choose_thresholds_ui("choose_thresholds_1")
          )),

      mainPanel(
        tabsetPanel(
          tabPanel(title = "Data check",
                   h4("Check distributions of the loaded data set"),
                   fluidRow(column(mod_alpha_beta_consistency_ui("alpha_beta_consistency_1"),
                                   width = 6),
                            column(mod_alpha_beta_distribution_ui("alpha_beta_distribution_1"),
                                   width = 6),
                            column(mod_summarise_data_ui("summarise_data_1"),
                                   width = 12)
                            )
                   ),
          tabPanel(title = "Data exploration",
                   br(),
                   mod_plot_relevant_binder_frequencies_ui("plot_relevant_binder_frequencies_1"))
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
