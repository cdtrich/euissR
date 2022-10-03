# manual
#' euissR palettes based on `euissR::colors`
#'
#' @param n number of colors
#' 
#' @return vector of n colors
#' @export
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = cyl)) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_gradientn(colors = pal_seq_r_euiss(4))
pal_seq_r_euiss <- function(n) {
  pal <- grDevices::colorRampPalette(c(fuchsia3, fuchsia2, fuchsia1, egg))
  pal(n)
}