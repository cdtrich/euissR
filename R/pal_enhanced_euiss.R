#' Enhanced euissR palettes with additional variants
#'
#' Enhanced categorical palette using updated colors from style script
#' @param n number of colors
#'
#' @return vector of n colors
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = factor(cyl))) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_manual(values = pal_cat_euiss_enhanced(6))
pal_cat_euiss_enhanced <- function(n) {
  pal_cat <- get("pal_cat", envir = .euiss_env, inherits = FALSE)
  pal_cat(n)
}

#' Light red sequential palette
#' @param n number of colors
#' @return vector of n colors
#' @export
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = disp)) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_gradientn(colors = pal_seq_r_light_euiss(4))
pal_seq_r_light_euiss <- function(n) {
  pal_seq_r_light <- get("pal_seq_r_light", envir = .euiss_env, inherits = FALSE)
  pal_seq_r_light(n)
}

#' Light green sequential palette
#' @param n number of colors
#' @return vector of n colors
#' @export
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = disp)) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_gradientn(colors = pal_seq_g_light_euiss(4))
pal_seq_g_light_euiss <- function(n) {
  pal_seq_g_light <- get("pal_seq_g_light", envir = .euiss_env, inherits = FALSE)
  pal_seq_g_light(n)
}

#' Light blue sequential palette
#' @param n number of colors
#' @return vector of n colors
#' @export
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = disp)) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_gradientn(colors = pal_seq_b_light_euiss(4))
pal_seq_b_light_euiss <- function(n) {
  pal_seq_b_light <- get("pal_seq_b_light", envir = .euiss_env, inherits = FALSE)
  pal_seq_b_light(n)
}

#' Bathymetry palette for depth visualization
#' @param n number of colors
#' @return vector of n colors
#' @export
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = disp)) + 
#'   ggplot2::geom_point() + 
#'   ggplot2::scale_color_gradientn(colors = pal_seq_bathy_euiss(6))
pal_seq_bathy_euiss <- function(n) {
  pal_seq_bathy <- get("pal_seq_bathy", envir = .euiss_env, inherits = FALSE)
  pal_seq_bathy(n)
}
