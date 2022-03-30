# manual
#' euissR palettes based on `euissR::colors`
#'
#' @param n number of colors
#'
#' @export
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = base::factor(cyl))) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_manual(values = pal_seq_v_euiss(6))
pal_seq_v_euiss <- function(n) {
  pal <- grDevices::colorRampPalette(c(col_grid, teal2, mauve, fuchsia2))
  pal(n)
}