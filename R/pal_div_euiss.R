# manual
#' euissR palettes based on \code{euissR::colors}
#'
#' @param n number of colors
#' 
#' @return vector of n colors
#' @export
#' 
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = base::factor(cyl))) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_manual(values = pal_div_euiss(6))
pal_div_euiss <- function(n) {
  pal <- grDevices::colorRampPalette(c(teal3, teal, col_grid, egg, fuchsia2))
  pal(n)
}