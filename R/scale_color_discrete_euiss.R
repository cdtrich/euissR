#' euissR scales based on `euissR::scales`
#'
#' @export
#' @examples
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = base::factor(cyl))) +
#'   ggplot2::geom_point() +
#'   scale_color_discrete_euiss()
scale_color_discrete_euiss <- function() {
  ggplot2::scale_color_manual(
    values = pal_cat_euiss(6),
    aesthetics = c("color", "fill")
  )
}