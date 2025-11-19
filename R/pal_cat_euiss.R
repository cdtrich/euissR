#' euissR palettes based on \code{euissR::colors}
#'
#' @param n number of colors
#'
#' @return vector of n colors
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = factor(cyl))) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_manual(values = pal_cat_euiss(6))
pal_cat_euiss <- function(n) {
  pal_cat <- get("pal_cat", envir = .euiss_env, inherits = FALSE)
  pal_cat(n)
}
