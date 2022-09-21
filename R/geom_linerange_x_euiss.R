#' Custom ggplot2::geom_linerange_x()
#'
#' @param mapping Set of aesthetic mappings created by \code{aes()} or \code{aes_()}. If specified and \code{inherit.aes = TRUE} (the default), it is combined with the default mapping at the top level of the plot. You must supply \code{mapping} if there is no plot mapping.
#' @param data The data to be displayed in this layer.
#' @param xmin x-baseline
#' @param col line/shape color
#' @param fill point fill
#' @param linewidth range line width
#' @param size shape size
#' @param shape type of shape
#' @param show.legend logical. Should this layer be included in the legends? \code{NA}, the default, includes if any aesthetics are mapped. \code{FALSE} never includes, and \code{TRUE} always includes. It can also be a named logical vector to finely select the aesthetics to display. 
#' @param inherit.aes If \code{FALSE}, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. \code{borders()}.
#' @param ... other arguments that can be passed to \code{ggplot2::geom_linerange_x()}
#'
#' @return Pre-styled \code{geom_linerange_x()}
#' @export
#'
#' @examples 
#' require(dplyr)
#' mtcars %>% 
#'   dplyr::group_by(gear, cyl) %>% 
#'   dplyr::summarize(wt = sum(wt)) %>% 
#'   ggplot2::ggplot(ggplot2::aes(x = cyl, y = wt, xmax = cyl, group = gear)) + 
#'   geom_linerange_x_euiss() + 
#'   ggplot2::facet_wrap(~gear)
geom_linerange_x_euiss <- function(mapping = NULL, 
                                   data = NULL, 
                                   xmin = 0,
                                   shape = 21,
                                   linewidth = lwd_line,
                                   size = 2,
                                   col = teal, 
                                   fill = "white",
                                   show.legend = NA,
                                   inherit.aes = TRUE,
                                   ...) {
  list(
    ggplot2::geom_linerange(
      data = data,
      mapping = mapping,
      xmin = xmin,
      col = col,
      size = linewidth,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      ...
    ),
    ggplot2::geom_point(
      data = data,
      mapping = mapping,
      shape = shape,
      size = size,
      col = col,
      fill = fill,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      ...
    )
  )
}
