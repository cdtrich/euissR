
annontate_euiss <- function(geom = "text",
                            x, y, 
                            col = col_axis,
                            family = txt_family,
                            size = txt_label,
                            hjust = "left",
                            lineheight = .85,
                            ...) {
  ggplot2::annotate(geom = geom,
                    x = x, y = y,
                    col = col,
                    family = family,
                    size = size,
                    hjust = hjust,
                    lineheight = lineheight) 
}

