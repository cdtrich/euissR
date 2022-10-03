#' Custom \code{ggplot2} theme
#' 
#' @details \code{theme_euiss()} runs when \code{euissR} package is loaded. 
theme_euiss <- function() {
  ggplot2::theme_set(ggplot2::theme_minimal() +
                       ggplot2::theme(
                         text = ggplot2::element_text(family = txt_family),
                         
                         legend.position = "top",
                         legend.justification = base::c("left", "top"),
                         legend.key.height = grid::unit(5,
                                                        unit = "points"
                         ),
                         legend.title = ggplot2::element_text(size = ggplot2::rel(.75)),
                         legend.text = ggplot2::element_text(
                           size = ggplot2::rel(.75),
                           color = col_axis
                         ),
                         axis.title = ggplot2::element_blank(),
                         axis.text.y = ggplot2::element_text(
                           size = ggplot2::rel(.75),
                           color = col_axis_text
                         ),
                         axis.text.x = ggplot2::element_text(
                           size = ggplot2::rel(.75),
                           color = col_axis_text
                         ),
                         strip.text = ggplot2::element_text(hjust = 0),
                         strip.text.x = ggplot2::element_text(
                           size = ggplot2::rel(10 / 9),
                           lineheight = .85
                         ),
                         strip.text.y = ggplot2::element_text(
                           size = ggplot2::rel(10 / 9),
                           lineheight = .85
                         ),
                         
                         line = ggplot2::element_line(
                           size = 2,
                           lineend = "round"
                         ),
                         
                         # background
                         plot.background = ggplot2::element_rect(fill = "white"),
                         
                         
                         # theoretical grid styling
                         panel.grid = ggplot2::element_line(
                           color = col_grid,
                           size = lwd_grid
                         ),
                         # white grid
                         panel.grid.minor.y = ggplot2::element_blank(),
                         panel.grid.minor.x = ggplot2::element_blank(),
                         panel.grid.major.x = ggplot2::element_line(color = "white"),
                         panel.grid.major.y = ggplot2::element_line(color = "white"),
                         
                         # axis ticks instead
                         axis.ticks.length = grid::unit(10,
                                                        unit = "pt"
                         ),
                         
                         # no margins
                         plot.margin = ggplot2::margin(0, 0, 0, 0, "mm"),
                         
                         # main labels
                         plot.title = ggplot2::element_text(
                           color = "black",
                           face = txt_bold,
                           size = 24
                         ),
                         plot.title.position = "plot",
                         plot.subtitle = ggplot2::element_text(
                           color = grey25,
                           face = "plain",
                           size = 10
                         ),
                         plot.caption = ggplot2::element_text(
                           color = grey25,
                           size = 6
                         )
                       ))
}

.onAttach <- function(libname, pkgname) {
  theme_euiss()
  packageStartupMessage("Default ggplot2 theme changed to theme_euiss().")
}
# .onAttach("theme_euiss", "euissR")
# onAttach <- theme_euiss()
