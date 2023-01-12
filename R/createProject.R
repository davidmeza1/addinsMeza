#' Creates project infrastructure
#'
#' This function creates the folders you will use in your project
#' @param
#' @keywords project
#' @export
#' @examples
#' CreateProjectFolders()

CreateProjectFolders <- function(){

  projectDir = getwd()

  rcodeDir = file.path(projectDir, 'R')
  pythoncodeDir = file.path(projectDir, "python")
  dataDir = file.path(projectDir, 'data')
  outputDir = file.path(projectDir, 'output')
  docDir <- file.path(projectDir, "doc")
  quartoDir <- file.path(projectDir, "quarto")
  shinydashDir <- file.path(projectDir, "shinyDash")
  shinyAppDir <- file.path(projectDir, "shinyApp")

  dir.create(rcodeDir)
  dir.create(pythoncodeDir)
  dir.create(dataDir)
  dir.create(outputDir)
  dir.create(docDir)
  dir.create(quartoDir)
  dir.create(shinydashDir)
  dir.create(shinyAppDir)

}
