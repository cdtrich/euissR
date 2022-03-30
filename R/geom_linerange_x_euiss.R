#' Custom horizontal ggplot2::geom_linerange()
#'
#' @param col line color
#' @param size line width
#' @param ... other arguments that can be passed to `ggplot2::geom_linerange()`
#'
#' @return Pre-styled `geom_linerange()`
#' @export
#'
#' @examples
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(x = hp, y = wt, xmax = hp)) + 
#'   geom_linerange_x_euiss() + 
#'   geom_point_euiss()
geom_linerange_x_euiss <- function(col = teal,
                                   size = lwd_line,
                                   ...) {
  ggplot2::geom_linerange(
    xmin = 0,
    col = col,
    size = size,
    ...
  )
}





