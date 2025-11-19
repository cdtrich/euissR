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
#'   ggplot2::scale_color_gradientn(colors = pal_seq_r_light_euiss(4))
pal_seq_r_light_euiss <- function(n) {
  pal_seq_r_light <- get("pal_seq_r_light", envir = .euiss_env, inherits = FALSE)
  pal_seq_r_light(n)
}
