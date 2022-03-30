#' Custom ggplot2::geom_col()
#'
#' @param width column width
#' @param ... other arguments that can be passed to `ggplot2::geom_col()`
#'
#' @return Pre-styled `geom_col()` 
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(cyl, hp, fill = base::factor(gear))) + 
#'   geom_col_euiss()
geom_col_euiss <- function(width = .25,
                           ...) {
  ggplot2::geom_col(
    width = width,
    ...
  )
}
