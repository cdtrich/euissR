#' Custom ggplot2::geom_area()
#'
#' @param fill area color
#' @param col line color
#' @param outline.type line position
#' @param ... other arguments that can be passed to `ggplot2::geom_area()`
#'
#' @return Pre-styled `geom_area()`
#' @export
#'
#' @examples 
#' require(dplyr)
#' mtcars %>% 
#'   dplyr::group_by(gear, cyl) %>% 
#'   dplyr::summarize(wt = sum(wt)) %>% 
#'   ggplot2::ggplot(ggplot2::aes(cyl, wt, group = gear)) + 
#'   geom_area_euiss() + 
#'   ggplot2::facet_wrap(~gear)
geom_area_euiss <- function(fill = scales::alpha(teal, .1),
                            col = teal,
                            outline.type = "upper",
                            ...) {
  ggplot2::geom_area(
    fill = fill,
    col = col,
    outline.type = outline.type,
    ...
  )
}
