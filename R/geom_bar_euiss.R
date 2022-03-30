#' Custom ggplot2::geom_bar()
#'
#' @param width bar width
#' @param ... other arguments that can be passed to `ggplot2::geom_bar()`
#'
#' @return Pre-styled `geom_bar()` 
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(cyl, fill = base::factor(gear))) + 
#'   geom_bar_euiss()
geom_bar_euiss <- function(width = .25,
                           ...) {
  ggplot2::geom_bar(
    width = width,
    ...
  )
}
