#' Custom ggplot2::geom_text()
#'
#' @param mapping Set of aesthetic mappings created by \code{aes()} or \code{aes_()}. If specified and \code{inherit.aes = TRUE} (the default), it is combined with the default mapping at the top level of the plot. You must supply \code{mapping} if there is no plot mapping.
#' @param data The data to be displayed in this layer.
#' @param col text color
#' @param family text family
#' @param size text size
#' @param hjust text alignment
#' @param lineheight text line height
#' @param show.legend logical. Should this layer be included in the legends? \code{NA}, the default, includes if any aesthetics are mapped. \code{FALSE} never includes, and \code{TRUE} always includes. It can also be a named logical vector to finely select the aesthetics to display. 
#' @param inherit.aes If \code{FALSE}, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behavior from the default plot specification, e.g. \code{borders()}.
#' @param ... other arguments that can be passed to \code{ggplot2::geom_text()}
#'
#' @return Pre-styled \code{geom_text()}
#' @export
#'
#' @examples 
#' require(dplyr)
#' require(ggplot2)
#' ggplot2::ggplot(data = mtcars) +
#'   ggplot2::aes(disp, wt) + 
#'   geom_text_euiss(ggplot2::aes(label = rownames(mtcars)))
geom_text_euiss <- function(mapping = NULL, 
                            data = NULL, 
                            col = col_axis,
                            family = txt_family,
                            size = txt_label,
                            hjust = "left",
                            lineheight = .85,
                            show.legend = NA,
                            inherit.aes = TRUE,
                            ...) {
  ggplot2::geom_text(
    data = data,
    mapping = mapping,
    col = col,
    family = family,
    size = size,
    hjust = hjust,
    lineheight = lineheight,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    ...
  )
}