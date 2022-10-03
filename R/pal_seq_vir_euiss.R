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
#'   ggplot2::scale_color_manual(values = pal_seq_vir_euiss(6))
pal_seq_vir_euiss <- function(n) {
  pal <- grDevices::colorRampPalette(c(mauve, teal2, fuchsia1, egg))
  pal(n)
}