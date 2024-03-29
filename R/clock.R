library(shiny)
library(miniUI)

# We'll wrap our Shiny Gadget in an addin.
# Let's call it 'clockAddin()'."2022-08-23 19:13:35"
clockAddin <- function() {

  # Our ui will be a simple gadget page, which
  # simply displays the time in a 'UI' output.
  ui <- miniPage(
    gadgetTitleBar("Clock"),
    miniContentPanel(
      uiOutput("time")
    )
  )

  server <- function(input, output, session) {

    # Set some CSS styles for our clock.
    clockStyles <- paste(
      "border: 1px solid #DADADA",
      "background-color: #EFEFEF",
      "border-radius: 5px",
      "font-size: 6em",
      "margin-top: 60px",
      "text-align: center",
      sep = "; "
    )

    # We'll use a 'reactiveTimer()' to force Shiny
    # to update and show the clock every second.
    invalidatePeriodically <- reactiveTimer(intervalMs = 1000)
    observe({

      # Call our reactive timer in an 'observe' function
      # to ensure it's repeatedly fired.
      invalidatePeriodically()

      # Get the time, and render it as a large paragraph element.
      time <- Sys.time()
      output$time <- renderUI({
        p(style = clockStyles, time)
      })
    })

    # Listen for 'done' events. When we're finished, we'll
    # insert the current time, and then stop the gadget.
    observeEvent(input$done, {
      timeText <- paste0("\"", as.character(Sys.time()), "\"")
      rstudioapi::insertText(timeText)
      stopApp()
    })

  }

  # We'll use a pane viwer, and set the minimum height at
  # 300px to ensure we get enough screen space to display the clock.
  viewer <- paneViewer(300)
  runGadget(ui, server, viewer = viewer)

}

# Try running the clock!
clockAddin()

"2022-08-24 10:02:41"# Now all that's left is sharing this addin -- put this function
# in an R package, provide the registration metadata at
# 'inst/rstudio/addins.dcf', and you're ready to go!
