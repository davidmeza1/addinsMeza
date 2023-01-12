#' Search last error on Stack Overflow
#'
#' This function will search SO using the last
#' error you encounterd
#' @param
#' @keywords project
#' @export
#' @examples
#' search_last_error_on_so()

search_last_error_on_so <- function(){
  tr <- .traceback()
  if (!length(tr)){
    return(NULL)
  }
  err_msg <- tryCatch(
    eval(parse(text = tr[[1]])),
    error = function(e) paste0("Error: ", e$message)
    )
  browseURL(paste0("https:/stackoverflow.com/search?q=", err_msg))
}
options(error = search_last_error_on_so)
