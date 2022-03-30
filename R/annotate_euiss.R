#' Custom `ggplot2` annotation
#'
#' @param geom `ggplot2` geom for annotation
#' @param lineheight text line height
#' @param family text family
#' @param size text size
#' @param hjust text alignment
#' @param ... other arguments that can be passed to `ggplot2::annotate()`
#'
#' @return Pre-styled `annotate()`
#' @export
#'
#' @examples
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt)) +
#'   geom_point_euiss() +
#'   annotate_euiss(label = "annotation in center-top", x = 300, y = 5)
annotate_euiss <- function(geom = "text",
                           lineheight = .85,
                           family = txt_family,
                           size = txt_label,
                           hjust = "left",
                           ...) {
  ggplot2::annotate(
    geom = geom,
    lineheight = lineheight,
    family = family,
    size = size,
    hjust = hjust,
    ...
  )
}
