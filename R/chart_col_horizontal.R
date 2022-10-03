#' EUISS column chart
#'
#' @param data The data to be displayed in the plot.
#' @param x x-aesthetic passed into each layer.
#' @param y y-aesthetic passed into each layer.
#' @param label label for maximum x-value
#' @param title chart title
#' @param subtitle chart subtitle
#' @param caption chart caption
#' @param nudge_y Vertical adjustment to nudge labels by.
#' @param vjust Vertical alignment; defaults to 0 (bottom).
#' @param ... Other arguments passed on to layer().
#'
#' @return A complete horizontal column chart with labels and titles, that can be amended with further \code{ggplot2} geoms.
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
#' require(ggplot2)
#' require(magrittr)
#' mtcars %>% 
#'   chart_col_horizontal(x = mpg, y = cyl)
chart_col_horizontal <- function(data,
                                 x, 
                                 y, 
                                 label,
                                 title = "",
                                 subtitle = "",
                                 caption = "",
                                 nudge_y = .5,
                                 vjust = 0,
                                 ...) {
  
  # utils::globalVariables("text")
  text <- NULL
  
  # unquoting
  x <- ggplot2::enquo(x)
  y <- ggplot2::enquo(y)
  
  # check for labels input
  if (missing(label)) {
    # if label isn't specified, create default label in new column
    data_label <- data %>%
      dplyr::mutate(text = paste0(!! y, " | ", !! x))
    
  } else {
    label <- ggplot2::enquo(label)
    # create label based on input
    data_label <- data %>% 
      dplyr::mutate(text = paste0(!! label))
    
  }
  
  # plotting
  col <- function(data, 
                  mapping, 
                  data_label,
                  nudge_y,
                  vjust,
                  ...) {
    
    # plot
    ggplot2::ggplot(data, 
                    ggplot2::aes(x = !! x, 
                                 y = !! y)) +
      geom_col_euiss() +
      geom_text_euiss(data = data_label,
                      ggplot2::aes(x = 0,
                                   label = text),
                      vjust = 0,
                      nudge_y = nudge_y) +
      ggplot2::theme(axis.text.x = ggplot2::element_blank(),
                     axis.text.y = ggplot2::element_blank()) +
      ggplot2::labs(
        title = title,
        subtitle = subtitle,
        caption = caption)
  }
  
  # calling plotting function
  col(data,
      ggplot2::aes(x = !! x,
                   y = !! y),
      data_label = data_label)
  
}