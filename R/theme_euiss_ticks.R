#' euissR theme with tick marks
#'
#' @return ggplot2 `theme` object 
#' @export
theme_euiss_ticks <- function() {
  ggplot2::theme_get() +
    ggplot2::theme(
      line = ggplot2::element_line(linewidth = 2, 
                                   lineend = "round"),

      # axis ticks instead
      axis.ticks.length = grid::unit(5, 
                                     unit = "pt"),
      axis.ticks.y = ggplot2::element_line(color = col_grid, 
                                           linewidth = lwd_grid),
      axis.ticks.x = ggplot2::element_line(color = col_grid, 
                                           linewidth = lwd_grid)
    )
}