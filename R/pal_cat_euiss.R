# manual
#' euissR palettes based on `euissR::colors`
#'
#' @param n number of colors
#' 
#' @export
#' 
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = base::factor(cyl))) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_manual(values = pal_cat_euiss(6))
pal_cat_euiss <- function(n) {
  pal <- grDevices::colorRampPalette(c(teal, fuchsia2, teal3, orange, mauve, egg))
  pal(n)
}
4