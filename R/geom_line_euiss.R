#' Custom ggplot2::geom_line()
#'
#' @param mapping Set of aesthetic mappings created by \code{aes()} or \code{aes_()}. If specified and \code{inherit.aes = TRUE} (the default), it is combined with the default mapping at the top level of the plot. You must supply \code{mapping} if there is no plot mapping.
#' @param data The data to be displayed in this layer.
#' @param col line color
#' @param size line width
#' @param show.legend logical. Should this layer be included in the legends? \code{NA}, the default, includes if any aesthetics are mapped. \code{FALSE} never includes, and \code{TRUE} always includes. It can also be a named logical vector to finely select the aesthetics to display. 
#' @param inherit.aes If \code{FALSE}, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. \code{borders()}.
#' @param ... other arguments that can be passed to \code{ggplot2::geom_line()}
#'
#' @return Pre-styled \code{geom_line()}
#' @export
#'
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt, label = wt)) + 
#'   geom_line_euiss()
geom_line_euiss <- function(mapping = NULL, 
                            data = NULL, 
                            col = teal, 
                            linewidth = lwd_line,
                            show.legend = NA,
                            inherit.aes = TRUE,
                            ...) {
  ggplot2::geom_line(
    data = data,
    mapping = mapping,
    col = col,
    linewidth = linewidth,
    lineend = "butt",
    linejoin = "round",
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    ...
  )
}

