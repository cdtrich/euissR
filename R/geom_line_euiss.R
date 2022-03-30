#' Custom ggplot2::geom_line()
#'
#' @param col line color
#' @param size line width
#' @param ... other arguments that can be passed to `ggplot2::geom_line()`
#'
#' @return Pre-styled `geom_line()` 
#' @export
#'
#' @examples 
#' require(dplyr)
#' mtcars %>% 
#'   dplyr::group_by(gear, cyl) %>% 
#'   dplyr::summarize(wt = sum(wt)) %>% 
#'   ggplot2::ggplot(ggplot2::aes(cyl, wt, group = gear)) + 
#'   geom_line_euiss() + 
#'   ggplot2::facet_wrap(~gear)
geom_line_euiss <- function(col = teal,
                            size = lwd_line,
                            ...) {
  ggplot2::geom_line(
    col = col,
    size = size,
    ...
  )
}
