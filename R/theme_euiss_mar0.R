#' euissR theme with narrow margins
#'
#' @param t top margin
#' @param r right margin
#' @param b bottom margin
#' @param l left margin
#' @param unit unit of margin values
#' @param ... other arguments that can be passed to `ggplot2::margin()`
#'
#' @return ggplot2 `theme` object
#' @export
theme_euiss_mar0 <- function(t = 0.1,
                             r = 0.1,
                             b = 0.1,
                             l = 0.1,
                             unit = "mm",
                             ...) {
  ggplot2::theme(
    plot.margin = ggplot2::margin(
      t = t,
      r = r,
      b = b,
      l = l,
      unit = unit,
      ...
    )
  )
}
