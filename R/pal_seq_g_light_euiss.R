# manual
#' euissR palettes based on \code{euissR::colors}
#'
#' @param n number of colors
#' 
#' @return vector of n colors
#' @export
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = disp)) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_gradientn(colors = pal_seq_g_light_euiss(4))
pal_seq_g_light_euiss <- function(n) {
  pal_seq_g <- get("pal_seq_g_light", envir = .euiss_env, inherits = FALSE)
  pal_seq_g(n)
}
