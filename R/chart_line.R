#' EUISS line chart
#'
#' @param data The data to be displayed in the plot.
#' @param x x-aesthetic passed into each layer.
#' @param y y-aesthetic passed into each layer.
#' @param group group-aesthetic for line(s).
#' @param label label for maximum x-value
#' @param title chart title
#' @param subtitle chart subtitle
#' @param caption chart caption
#' @param ... Other arguments passed on to layer().
#'
#' @return A complete line chart with labels and titles, that can be amended with further \code{ggplot2} geoms.
#' @importFrom magrittr %>%
#' @export
#'
#' @examples
#' require(magrittr)
#' mtcars %>% 
#'   chart_line(x = mpg, y = drat, group = cyl)
chart_line <- function(data,
                       x, 
                       y, 
                       group,
                       label,
                       title = "",
                       subtitle = "",
                       caption = "",
                       ...) {
  
  # utils::globalVariables("text")
  text <- NULL
  
  # unquoting
  x <- ggplot2::enquo(x)
  y <- ggplot2::enquo(y)
  group <- ggplot2::enquo(group)
  
  # maximum x-value  
  max <- data %>%
    dplyr::group_by(!! group) %>% 
    dplyr::filter(!! x == max(!! x)) %>% 
    dplyr::distinct(!! group, .keep_all = TRUE) %>% 
    dplyr::ungroup() %>% 
    dplyr::select(!! x) %>%
    dplyr::pull() 
  # message(paste0("Dots and labels placed at maximum x-value, ", max, "."))
  
  # check for labels input
  if (missing(label)) {
    
    # if label isn't specified, default label in new column
      data_label <- data %>%
        dplyr::filter(!! x %in% max) %>%
        dplyr::mutate(text = paste0(!! y, " | ", !! group))
    
  } else {
    
    label <- ggplot2::enquo(label)
    # create label based on input
      data_label <- data %>% 
        dplyr::filter(!! x %in% max) %>%
        dplyr::mutate(text = paste0(!! label))
    
  }
  
  # plotting
  line <- function(data, 
                   mapping, 
                   ...) {
    
    # plot
    ggplot2::ggplot(data, 
                    ggplot2::aes(x = !! x, 
                                 y = !! y, 
                                 group = !! group)) +
      geom_line_euiss() +
      geom_point_euiss(data = . %>%
                         dplyr::filter(!! x %in% max)) +
      geom_text_euiss(data = data_label,
                      ggplot2::aes(label = text)) +
      ggplot2::labs(
        title = title,
        subtitle = subtitle,
        caption = caption)
  }
  
  # calling plotting function
  line(data,
       ggplot2::aes(x = !! x,
                    y = !! y,
                    group = !! group))
  
}