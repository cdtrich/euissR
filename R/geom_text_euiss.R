#' Custom ggplot2::geom_text()
#'
#' @param lineheight text line height
#' @param family text family
#' @param size text size
#' @param hjust text alignment
#' @param ... other arguments that can be passed to `ggplot2::geom_text()`
#'
#' @return Pre-styled `geom_text()` 
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt, label = wt)) + 
#'   geom_text_euiss()
geom_text_euiss <- function(lineheight = .85, 
                            family = txt_family,
                            size = txt_label, 
                            hjust = "left",
                            ...) {
  ggplot2::geom_text(
    lineheight = lineheight, 
    family = family,
    size = size, 
    hjust = hjust,
    ...
  )
}
