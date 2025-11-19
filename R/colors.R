#' EUISS Color System
#'
#' @description
#' The euissR package uses a comprehensive color system based on the EU Institute
#' for Security Studies visual identity. All color values are defined in onLoad.R
#' and stored in the `.euiss_env` environment, then copied to the package namespace
#' during package load.
#'
#' @section Color Palette Options:
#' The package automatically configures ggplot2 color options when loaded:
#' \itemize{
#'   \item \strong{Discrete colors:} Use categorical palette (pal_cat)
#'   \item \strong{Ordinal colors:} Use sequential palette (pal_seq_v)
#'   \item \strong{Binned colors:} Use categorical palette (pal_cat)
#' }
#'
#' These options are set in `.onAttach()` and affect all ggplot2 plots created
#' after loading euissR.
#'
#' @section Color Categories:
#' \strong{Basic Colors:}
#' \itemize{
#'   \item \code{col_grid} - Grid line color (#C6C6C6)
#'   \item \code{col_grid0} - Light grid color (#F9F9F9)
#'   \item \code{col_axis} - Axis line color (#1D1D1B)
#'   \item \code{col_axis_text} - Axis text color (#646363)
#'   \item \code{grey25} - 25\% grey (#646363)
#' }
#'
#' \strong{Cold Colors (Blues/Teals):}
#' \itemize{
#'   \item \code{blue} - Deep blue (#113655)
#'   \item \code{teal} - Primary teal (#309ebe)
#'   \item \code{grey} - Medium grey (#595959)
#'   \item \code{teal0} through \code{teal3} - Teal variants
#'   \item \code{teal1.1}, \code{teal1.2}, \code{teal2.1} - Additional teal shades
#' }
#'
#' \strong{Warm Colors (Reds/Oranges/Purples):}
#' \itemize{
#'   \item \code{egg} - Yellow (#ffde75)
#'   \item \code{egg0} - Light yellow (#FFFFA6)
#'   \item \code{lightorange} - Light orange (#f9b466)
#'   \item \code{orange} - Primary orange (#f28d22)
#'   \item \code{fuchsia1}, \code{fuchsia1.0} - Light fuchsia variants
#'   \item \code{fuchsia2} - Primary fuchsia (#df3144)
#'   \item \code{fuchsia3} - Dark fuchsia (#a41e26)
#'   \item \code{mauve} - Primary purple (#33163a)
#'   \item \code{mauve1} - Dark purple (#200E25)
#' }
#'
#' \strong{Green Colors:}
#' \itemize{
#'   \item \code{frog} - Bright green (#4cb748)
#'   \item \code{mint} - Light green (#99cb92)
#' }
#'
#' @section Line Widths:
#' \itemize{
#'   \item \code{lwd_grid} - Grid line width
#'   \item \code{lwd_line} - Standard line width
#'   \item \code{lwd_point} - Point outline width
#' }
#'
#' @section User Access:
#' Users can access colors through the euiss_colors.R functions:
#' \itemize{
#'   \item \code{euiss_teal()} - Get teal color
#'   \item \code{euiss_teal(2)} - Get teal variant 2
#'   \item \code{euiss_fuchsia()} - Get fuchsia color
#'   \item \code{euiss_colors("cold")} - Get all cold colors
#'   \item \code{euiss_show_colors()} - Display color palette
#' }
#'
#' @section Internal Use:
#' Package functions can reference colors directly in defaults:
#' \preformatted{
#'   geom_col_euiss(fill = teal)
#'   geom_point_euiss(col = fuchsia2)
#' }
#'
#' @name colors
#' @aliases euiss-colors color-system
#' @seealso 
#' \code{\link{euiss_colors}}, \code{\link{euiss_teal}}, \code{\link{euiss_show_colors}}
#' 
#' @keywords internal
NULL

# Declare all color variables as globals to avoid R CMD check notes
# Actual values are defined in onLoad.R and stored in .euiss_env
# Values are copied to package namespace during .onLoad() via .copy_colors_to_namespace()

utils::globalVariables(
  c(
    # Basic colors
    "col_grid", "col_grid0", "col_axis", "col_axis_text", "grey25",
    
    # Cold colors (visual ID)
    "blue", "teal", "grey",
    "teal0", "teal1", "teal1.1", "teal1.2", 
    "teal2", "teal2.1", "teal3",
    
    # Warm colors (visual ID)
    "egg", "egg0", "lightorange", "orange",
    "fuchsia1", "fuchsia1.0", "fuchsia2", "fuchsia3",
    "mauve", "mauve1",
    
    # Green colors
    "frog", "mint",
    
    # Line widths
    "lwd_grid", "lwd_line", "lwd_point"
  )
)
