# Set options here
options(golem.app.prod = FALSE) # TRUE = production mode, FALSE = development mode

# Comment this if you don't want the app to be served on a random port
options(shiny.port = httpuv::randomPort())

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run in Viewer or Window, comment one out
options(shiny.launch.browser = .rs.invokeShinyPaneViewer)
#options(shiny.launch.browser = .rs.invokeShinyWindowViewer)

# Run the application
run_app()

# Link to online app
# https://williamhr.shinyapps.io/TCRSequenceShiny/

# Link to pass objects between modules
# https://jiwanheo.rbind.io/post/2022-02-06-pass-around-data-between-shiny-modules-with-r6/
