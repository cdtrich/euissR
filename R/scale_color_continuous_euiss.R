#' euissR scales based on `euissR::scales`
#'
#' @export
#' @examples
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = cyl)) +
#'   ggplot2::geom_point() +
#'   scale_color_continuous_euiss()
scale_color_continuous_euiss <- function() {
  ggplot2::scale_color_gradientn(
    colors = pal_seq_vir_euiss(4),
    aesthetics = c("color", "fill")
  )
}