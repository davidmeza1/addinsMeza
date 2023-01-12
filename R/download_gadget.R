library(shiny)
library(miniUI)

download_gadget <- function() {

  ui <- miniPage(
    gadgetTitleBar("Download Gadget"),
    miniContentPanel(
      ## Your UI items go here.

    )
  )

  server <- function(input, ouput, session) {



    #url <- "https://explosion.ai/blog/floret-vectors.pdf"
    #destfile <- "reference/floret.pdf"
    #download.file(url, destfile, method = 'curl')



    #url <- "https://explosion.ai/blog/floret-vectors"
    #path <- "reference"
    #my_html_to_pdf(url, path = path)

  }

  #viewer <- paneViewer(300)
  runGadget(ui, server)

}
