#' Custom ggplot2::geom_hline()
#'
#' @param yintercept position of x-axis. `default = 0`
#' @param linewidth line width (defaults to EUISS grid linewidth)
#' @param col line color (defaults to EUISS grid color)
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
  
  ggplot2::geom_hline(
    yintercept = yintercept,
    linewidth = linewidth, 
    col = col,
    ...
  )
}