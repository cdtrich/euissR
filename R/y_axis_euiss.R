#' Custom ggplot2::geom_vline()
#'
#' @param xintercept position of y-axis. `default = 0`
#' @param size line width
#' @param col line color
#' @param ... other arguments that can be passed to `ggplot2::geom_hline()` 
#'
#' @return Pre-styled `geom_vline()` that inserts a grey y-axis at `x-intercept = 0`
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt)) + 
#'   geom_point_euiss() + 
#'   y_axis_euiss()
y_axis_euiss <- function(xintercept = 0,
                         size = lwd_grid, 
                         col = col_grid,
                         ...) {
  ggplot2::geom_vline(
    xintercept = xintercept,
    size = size, 
    col = col,
    ...
  )
}