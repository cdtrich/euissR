#' Custom ggplot2::annotate() with EUISS styling
#'
#' @param geom geometric object to use for annotation
#' @param x x position for annotation
#' @param y y position for annotation  
#' @param col text color (defaults to EUISS axis color)
#' @param family font family (defaults to EUISS font)
#' @param size text size (defaults to EUISS label size)
#' @param hjust horizontal justification
#' @param lineheight line height
#' @param ... other arguments passed to ggplot2::annotate()
#'
#' @return A ggplot2 annotation layer with EUISS styling
#' @export
#'
#' @examples
#' \donttest{
#' # Examples that use EUISS fonts (requires euissR fonts to be installed)
#' ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) +
#'   ggplot2::geom_point() +
#'   annotate_euiss("text", x = 3, y = 25, label = "Sample text")
#' }
annotate_euiss <- function(geom = "text",
                           x, y, 
                           col = NULL,
                           family = NULL,
                           size = NULL,
                           hjust = "left",
                           lineheight = .85,
                           ...) {
  
  # Get values from package environment if not specified
  if (is.null(col)) {
    col <- get("col_axis", envir = .euiss_env, inherits = FALSE)
  }
  if (is.null(family)) {
    family <- get("txt_family", envir = .euiss_env, inherits = FALSE)
  }
  if (is.null(size)) {
    size <- get("txt_label", envir = .euiss_env, inherits = FALSE)
  }
  
  ggplot2::annotate(geom = geom,
                    x = x, y = y,
                    col = col,
                    family = family,
                    size = size,
                    hjust = hjust,
                    lineheight = lineheight,
                    ...)
}