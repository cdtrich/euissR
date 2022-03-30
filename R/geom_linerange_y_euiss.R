#' Custom vertical ggplot2::geom_linerange() 
#'
#' @param col line color
#' @param size line width
#' @param ... other arguments that can be passed to `ggplot2::geom_linerange()`
#'
#' @return Pre-styled `geom_linerange()`
#' @export
#'
#' @examples
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(x = wt, y = hp, ymax = hp)) + 
#'   geom_linerange_y_euiss() + 
#'   geom_point_euiss()
geom_linerange_y_euiss <- function(
                                   col = teal,
                                   size = lwd_line,
                                   ...) {
  ggplot2::geom_linerange(
    ymin = 0,
    col = col,
    size = size,
    ...
  )
}