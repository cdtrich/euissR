#\' Add relief/elevation raster layer with EUISS styling
#\'
#\' This function creates a geom_raster layer with predefined EUISS color scheme
#\' for elevation/relief visualization. Integrates with euissR color system.
#\'
#\' @param data A data frame containing raster data with x, y coordinates and elevation values.
#\' @param mapping Aesthetic mapping, typically aes(x = x, y = y, fill = elevation_var).
#\' @param alpha Transparency level for the raster. Default is 0.5.
#\' @param colors Color palette for the elevation gradient. If NULL, uses EUISS colors from euissR.
#\' @param guide Guide type for the legend. Default is "none".
#\' @param ... Additional arguments passed to geom_raster().
#\'
#\' @return A list containing geom_raster and scale_fill_gradientn layers.
#\'
#\' @examples
#\' # Basic usage
#\' ggplot() + geom_relief_euiss(data = elevation_data, aes(x = x, y = y, fill = elevation))
#\'
#\' # With custom alpha
#\' ggplot() + geom_relief_euiss(data = elevation_data, aes(x = x, y = y, fill = elevation), alpha = 0.3)
#\'
#\' @import ggplot2
#\' @importFrom euissR .euiss_env
#\'
#\' @export
geom_relief_euiss <- function(data = NULL, 
                              mapping = NULL, 
                              alpha = 0.5,
                              colors = NULL,
                              guide = "none",
                              ...) {
  
  # Get EUISS colors if not provided
  if (is.null(colors)) {
    # Safe access to euissR colors with fallback
    if (requireNamespace("euissR", quietly = TRUE)) {
      try({
        col_grid <- get("col_grid", envir = euissR::.euiss_env, inherits = FALSE)
        col_axis <- get("col_axis", envir = euissR::.euiss_env, inherits = FALSE)
        colors <- c("white", "white", "white", col_grid, col_axis)
      }, silent = TRUE)
    }
    # Fallback if euissR not available
    if (is.null(colors)) {
      colors <- c("white", "white", "white", "#C6C6C6", "#1D1D1B")
    }
  }
  
  list(
    ggplot2::geom_raster(data = data,
                         mapping = mapping,
                         alpha = alpha,
                         ...),
    ggplot2::scale_fill_gradientn(colors = colors, guide = guide)
  )
}
