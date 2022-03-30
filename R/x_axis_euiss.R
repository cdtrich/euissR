#' Custom ggplot2::geom_hline()
#'
#' @param yintercept position of x-axis. `default = 0`
#' @param size line width
#' @param col line color
#' @param ... other arguments that can be passed to `ggplot2::geom_hline()` 
#'
#' @return Pre-styled `geom_hline()` that inserts a grey x-axis at y-intercept = 0
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt)) + 
#'   geom_point_euiss() + 
#'   x_axis_euiss()
x_axis_euiss <- function(yintercept = 0,
                         size = lwd_grid, 
                         col = col_grid,
                         ...) {
  ggplot2::geom_hline(
    yintercept = yintercept,
    size = size, 
    col = col,
    ...
  )
}
