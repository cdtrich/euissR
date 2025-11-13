#' Custom \code{ggplot2} theme enhanced with style script features
#' 
#' @details \code{theme_euiss()} runs when \code{euissR} package is loaded.
#' Enhanced version that incorporates improvements from style script.
#' @export 
theme_euiss <- function() {
  # Ensure fonts and variables are initialized
  .init_fonts()
  
  # Get ALL variables from environment
  font_family <- get("txt_family", envir = .euiss_env, inherits = FALSE)
  txt_bold <- get("txt_bold", envir = .euiss_env, inherits = FALSE)
  col_axis <- get("col_axis", envir = .euiss_env, inherits = FALSE)
  col_axis_text <- get("col_axis_text", envir = .euiss_env, inherits = FALSE)
  col_grid <- get("col_grid", envir = .euiss_env, inherits = FALSE)
  grey25 <- get("grey25", envir = .euiss_env, inherits = FALSE)
  lwd_grid <- get("lwd_grid", envir = .euiss_env, inherits = FALSE)

  ggplot2::theme_minimal() +
    ggplot2::theme(
      text = ggplot2::element_text(family = font_family),
      
      # Enhanced legend (from style script)
      legend.position = "top",
      legend.justification = base::c("left", "top"),
      legend.key.height = grid::unit(5, "points"),
      legend.title = ggplot2::element_text(
        size = ggplot2::rel(.75), 
        face = txt_bold, 
        vjust = 1
      ),
      legend.text = ggplot2::element_text(
        size = ggplot2::rel(.75),
        color = col_axis
      ),
      
      # Axis styling
      axis.title = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_text(
        size = ggplot2::rel(.75),
        color = col_axis_text,
        margin = ggplot2::margin(0, 0, 0, 0)
      ),
      axis.text.x = ggplot2::element_text(
        size = ggplot2::rel(.75),
        color = col_axis_text,
        margin = ggplot2::margin(0, 0, 0, 0)
      ),
      
      # Enhanced strip text (from style script)
      strip.text = ggplot2::element_text(face = "bold", hjust = 0),
      strip.text.x = ggplot2::element_text(face = "bold", hjust = 0),
      strip.text.y = ggplot2::element_text(face = "bold", hjust = 0),
      strip.clip = "off",
      
      # Lines
      line = ggplot2::element_line(
        linewidth = 2,
        lineend = "round"
      ),
      
      # Background (updated from style script)
      plot.background = ggplot2::element_rect(fill = NA, color = NA),
      
      # Enhanced grid styling
      panel.grid = ggplot2::element_line(
        color = col_grid,
        linewidth = lwd_grid
      ),
      panel.grid.minor.y = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_line(color = "#fff"),
      panel.grid.major.y = ggplot2::element_line(color = "#fff"),
      
      # Axis ticks (updated from style script)
      axis.ticks.length = grid::unit(0, "pt"),  # Changed from 10 to 0
      
      # Margins
      plot.margin = ggplot2::margin(0, 0, 0, 0, "mm"),
      
      # Enhanced text styling (from style script)
      plot.title = ggplot2::element_text(
        color = "black",
        face = txt_bold,
        size = 16  # Updated from 24 to match style script
      ),
      plot.title.position = "panel",  # Updated from "plot"
      plot.subtitle = ggplot2::element_text(
        color = grey25,
        face = "plain",
        size = 10
      ),
      plot.caption = ggplot2::element_text(
        color = grey25,
        size = 6
      )
    )
}
