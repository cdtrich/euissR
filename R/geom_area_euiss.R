#' Custom ggplot2::geom_area()
#'
#' @param mapping Set of aesthetic mappings created by \code{aes()} or \code{aes_()}. If specified and \code{inherit.aes = TRUE} (the default), it is combined with the default mapping at the top level of the plot. You must supply \code{mapping} if there is no plot mapping.
#' @param data The data to be displayed in this layer.
#' @param col area color (defaults to EUISS teal)
#' @param fill area fill (defaults to transparent EUISS teal)
#' @param linewidth line width (defaults to EUISS standard)
#' @param show.legend logical. Should this layer be included in the legends? \code{NA}, the default, includes if any aesthetics are mapped. \code{FALSE} never includes, and \code{TRUE} always includes. It can also be a named logical vector to finely select the aesthetics to display. 
#' @param inherit.aes If \code{FALSE}, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g. \code{borders()}.
#' @param ... other arguments that can be passed to \code{ggplot2::geom_area()}
#'
#' @return Pre-styled \code{geom_area()}
#' @export
#'
#' @examples 
#' require(dplyr)
#' require(ggplot2)
#' mtcars %>% 
#'   dplyr::group_by(gear, cyl) %>% 
#'   dplyr::summarize(wt = sum(wt)) %>% 
#'   ggplot2::ggplot() +
#'   ggplot2::aes(cyl, wt, group = gear) + 
#'   geom_area_euiss() + 
#'   ggplot2::facet_wrap(~gear)
geom_area_euiss <- function(mapping = NULL, 
                            data = NULL, 
                            col = NULL, 
                            fill = NULL,
                            linewidth = NULL,
                            show.legend = NA,
                            inherit.aes = TRUE,
                            ...) {
  
  # Get values from package environment if not specified
  if (is.null(col)) {
    col <- get("teal", envir = .euiss_env, inherits = FALSE)
  }
  if (is.null(fill)) {
    teal <- get("teal", envir = .euiss_env, inherits = FALSE)
    fill <- scales::alpha(teal, .1)
  }
  if (is.null(linewidth)) {
    linewidth <- get("lwd_line", envir = .euiss_env, inherits = FALSE)
  }
  
  ggplot2::geom_area(
    data = data,
    mapping = mapping,
    col = col,
    fill = fill,
    linewidth = linewidth,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    ...
  )
}