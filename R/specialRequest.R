#' Special Request
#'
#' This function is used to Input and send Special Request I recieve to Managment
#' @param
#' @keywords request
#' @export
#' @examples
#' specialRequest()
#'
library(shiny)
library(miniUI)
library(mailR)

specialRequest <- function(inputValue1, inputValue2) {
  library(shiny)
  library(miniUI)
  library(mailR)
  ui <- miniPage(
    gadgetTitleBar("David Meza - Special Requests"),
    miniContentPanel(
      # Define layout, inputs, outputs
      dateInput("date", "Date of Special Request" ),
      textInput("requestor", "Name of Requesting Office or Individual", width = "400px"),
      textAreaInput("description", "Description of Special Request", width = "400px",
                     height = "200px"),
      textInput("office", "Name of Primary Office", value = "NA141", width = "400px"),
      textInput("requested", "Information Source", value = "David Meza", width = "400px"),
      textInput("sendto", "Email Info To", value = "jim.rostohar@nasa.gov", width = "400px")
    )
  )

  server <- function(input, output, session) {
    # Define reactive expressions, outputs, etc.

    # When the Done button is clicked, return a value
    observeEvent(input$done, {
      date <- input$date
      requestor <- renderText(input$requestor)
      description <- renderText(input$description)
      office <- renderText(input$office)
      requested <- renderText(input$requested)
      emailbody <- paste("Date: ", date(), "\n", "Requesting Office/Individual: ", requestor(), "\n",
                        "Description: ", description(), "\n", "Name of Primary Office: ",
                        office(), "\n", "Person Requested: ", requested())
      sendto <- renderText(input$sendto)
      returnValue <- send.mail(from = "david.meza-1@nasa.gov",
                               to = sendto(),
                               cc = c("david.meza-1@nasa.gov"),
                               #bcc = c("BCC Recipient <bcc.recipient@gmail.com>"),
                               subject = "David Meza - Special Request ",
                               body = emailbody,
                               smtp = list(host.name = "mrelay.jsc.nasa.gov", port = 25),
                               authenticate = FALSE,
                               send = TRUE)
      stopApp(returnValue)
    })
  }

  runGadget(ui, server)
}
