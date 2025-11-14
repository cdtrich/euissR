#' Custom ggplot2::geom_vline()
#'
#' @param xintercept position of y-axis. `default = 0`
#' @param linewidth line width
#' @param col line color
#' @param ... other arguments that can be passed to `ggplot2::geom_vline()` 
#'
#' @return Pre-styled `geom_vline()` that inserts a grey y-axis at `x-intercept = 0`
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt)) + 
#'   geom_point_euiss() + 
#'   y_axis_euiss()
y_axis_euiss <- function(xintercept = 0,
                         linewidth = NULL, 
                         col = NULL,
                         ...) {
  
  # Get values from package environment if not specified
  if (is.null(linewidth)) {
    linewidth <- get("lwd_grid", envir = .euiss_env, inherits = FALSE)
  }
  if (is.null(col)) {
    col <- get("col_grid", envir = .euiss_env, inherits = FALSE)
  }
  
  ggplot2::geom_vline(
    xintercept = xintercept,
    linewidth = linewidth, 
    col = col,
    ...
  )
}