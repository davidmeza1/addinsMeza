library(shiny)
library(miniUI)

downloadGadget <- function(inputValue1, inputValue2) {

  ui <- miniPage(
    gadgetTitleBar("Download Useful Articles"),
    miniContentPanel(
      # Define layout, inputs, outputs
      textInput("Url", "Enter url for download")
    )
  )

  server <- function(input, output, session) {
    # Define reactive expressions, outputs, etc.
    my_html_to_pdf <- function (file_path = NULL, dir = NULL, path = NULL, scale = 1, render_exist = FALSE)
    {
      if (requireNamespace("pagedown", quietly = TRUE)) {
        pagedown::find_chrome()
        if (!is.null(file_path)) {
          oldwd <- getwd()
          setwd("/Users/dmeza/Library/CloudStorage/OneDrive-NASA/web_downloads/")
          pagedown::chrome_print(input = file_path, options = list(scale = scale))
          setwd(oldwd)
        }
        else if (!is.null(dir)) {
          files <- list.files(dir)
          if (render_exist == FALSE) {
            pdf_files <- files[stringr::str_detect(pattern = ".pdf",
                                                   string = files)]
            pdf_cleaned <- stringr::str_replace(pdf_files,
                                                ".pdf", "")
            files <- files[stringr::str_detect(pattern = ".html",
                                               string = files)]
            files <- files[!stringr::str_detect(pattern = pdf_cleaned,
                                                string = files)]
          }
          files <- files[stringr::str_detect(pattern = ".html",
                                             string = files)]
          print(paste("Rendering", length(files), "files"))
          for (file in files) {
            file_path <- paste(path, "/", file, sep = "")
            skip_to_next <- FALSE
            tryCatch(pagedown::chrome_print(file_path), error = function(e) {
              skip_to_next <<- TRUE
            })
            if (skip_to_next) {
              next
            }
          }
        }
        else {
          stop("Either file_path or dir must be specified")
        }
      }
      else {
        stop("Please install.packages('pagedown')")
      }
    }


    observeEvent(input$url, {
      url <- renderText({input$url})
      path <- "reference"
      my_html_to_pdf(url, path = path)
    })


    # url <- textOutput(input$url)
    # destfile <- "reference/floret.pdf"
    # download.file(url, destfile, method = 'curl')




    # When the Done button is clicked, return a value
    observeEvent(input$done, {
      returnValue <- ...
      stopApp(returnValue)
    })
  }

  runGadget(ui, server)
}
