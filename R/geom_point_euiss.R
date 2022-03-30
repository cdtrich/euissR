#' Custom ggplot2::geom_point()
#'
#' @param col point color
#' @param fill point fill
#' @param size point size
#' @param shape any shape value that can be passed to `ggplot2::geom_point()`
#' @param ... other arguments that can be passed to `ggplot2::geom_point()`
#'
#' @return Pre-styled `geom_point()` 
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt)) + 
#'   geom_point_euiss()
geom_point_euiss <- function(col = teal, 
                             fill = NA,
                             size = 2,
                             shape = 21,
                             ...) {
  ggplot2::geom_point(
    size = size,
    col = col,
    shape = shape,
    fill = fill,
    ...
  )
}