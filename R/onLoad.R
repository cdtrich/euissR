# Package environment for font, color, and mode settings
.euiss_env <- new.env(parent = emptyenv())

# =============================================================================
# Font Initialization
# =============================================================================

#' Enhanced font initialization with better error handling
#' @keywords internal
.init_fonts <- function() {
  if (!exists("txt_family", envir = .euiss_env, inherits = FALSE)) {
    
    # Initialize font family to default
    font_family <- "sans"
    
    # Method 1: Try extrafont first
    extrafont_fonts <- character(0)
    if (requireNamespace("extrafont", quietly = TRUE)) {
      try({
        extrafont::loadfonts(quiet = TRUE, device = "win")
        extrafont_fonts <- extrafont::fonts()
      }, silent = TRUE)
    }
    
    # Method 2: Use systemfonts as backup for Adobe fonts
    system_fonts <- character(0)
    if (requireNamespace("systemfonts", quietly = TRUE)) {
      try({
        all_system_fonts <- systemfonts::system_fonts()
        system_fonts <- unique(all_system_fonts$family)
      }, silent = TRUE)
    }
    
    # Combine both sources
    available_fonts <- unique(c(extrafont_fonts, system_fonts))
    
    # Check font availability with branding priority
    # Priority 1: PT Sans Pro Narrow (Adobe font - best for branding)
    if ("PT Sans Pro Narrow" %in% available_fonts) {
      font_family <- "PT Sans Pro Narrow"
      if (!"PT Sans Pro Narrow" %in% extrafont_fonts && .Platform$OS.type == "windows") {
        try(grDevices::windowsFonts("PT Sans Pro Narrow" = grDevices::windowsFont("PT Sans Pro Narrow")), silent = TRUE)
      }
    } 
    # Priority 2: PT Sans Narrow (Google font - excellent alternative)
    else if ("PT Sans Narrow" %in% available_fonts) {
      font_family <- "PT Sans Narrow"
      if (!"PT Sans Narrow" %in% extrafont_fonts && .Platform$OS.type == "windows") {
        try(grDevices::windowsFonts("PT Sans Narrow" = grDevices::windowsFont("PT Sans Narrow")), silent = TRUE)
      }
    } 
    # Priority 3: PT Sans
    else if ("PT Sans" %in% available_fonts) {
      if (.Platform$OS.type == "windows") {
        try(grDevices::windowsFonts(PTSans = grDevices::windowsFont("PT Sans")), silent = TRUE)
      }
      font_family <- "PT Sans"
    }
    
    # Font settings
    assign("txt_family", font_family, envir = .euiss_env)
    assign("txt_bold", "bold", envir = .euiss_env)
    assign("txt_height", 0.85, envir = .euiss_env)
    assign("txt_label", 2.66, envir = .euiss_env)
    assign("txt_size", 2.66, envir = .euiss_env)
  }
}

# =============================================================================
# Color Initialization
# =============================================================================

#' Initialize EUISS color palette
#' @keywords internal
.init_colors <- function() {
  if (!exists("col_grid", envir = .euiss_env, inherits = FALSE)) {
    
    # Basic colors
    assign("col_grid", "#C6C6C6", envir = .euiss_env)
    assign("col_grid0", "#F9F9F9", envir = .euiss_env)
    assign("col_axis", "#1D1D1B", envir = .euiss_env)
    assign("col_axis_text", "#646363", envir = .euiss_env)
    assign("grey25", "#646363", envir = .euiss_env)
    
    # Visual ID colors
    assign("blue", "#113655", envir = .euiss_env)
    assign("teal", "#309ebe", envir = .euiss_env)
    assign("grey", "#595959", envir = .euiss_env)
    
    # Cold colors with variants
    assign("teal0", "#64C2C7", envir = .euiss_env)
    assign("teal1", "#64c2c7", envir = .euiss_env)
    assign("teal1.1", "#ccffff", envir = .euiss_env)
    assign("teal1.2", "#C1E6E7", envir = .euiss_env)
    assign("teal2", "#376882", envir = .euiss_env)
    assign("teal2.1", "#3E4E6F", envir = .euiss_env)
    assign("teal3", "#1d3956", envir = .euiss_env)
    
    # Warm colors with variants
    assign("egg", "#ffde75", envir = .euiss_env)
    assign("egg0", "#FFFFA6", envir = .euiss_env)
    assign("lightorange", "#f9b466", envir = .euiss_env)
    assign("orange", "#f28d22", envir = .euiss_env)
    assign("fuchsia1", "#ec5f5b", envir = .euiss_env)
    assign("fuchsia1.0", "#EE726D", envir = .euiss_env)
    assign("fuchsia2", "#df3144", envir = .euiss_env)
    assign("fuchsia3", "#a41e26", envir = .euiss_env)
    assign("mauve", "#33163a", envir = .euiss_env)
    assign("mauve1", "#200E25", envir = .euiss_env)
    
    # Green colors
    assign("frog", "#4cb748", envir = .euiss_env)
    assign("mint", "#99cb92", envir = .euiss_env)
    
    # Measurement settings
    assign("lwd_grid", 0.176 * 1.32, envir = .euiss_env)
    assign("lwd_line", 0.353 * 1.325, envir = .euiss_env)
    assign("lwd_point", 2, envir = .euiss_env)
    
    # Output dimensions
    assign("width_cp_onecol", 65.767, envir = .euiss_env)
    assign("width_cp_twocol", 140, envir = .euiss_env)
    assign("width_cp_full", 180, envir = .euiss_env)
    assign("height_cp", 221.9, envir = .euiss_env)
    assign("width_book_col", 108, envir = .euiss_env)
    assign("width_book_half", 60, envir = .euiss_env)
    assign("width_book_full", 135, envir = .euiss_env)
    assign("height_book", 181.25, envir = .euiss_env)
    assign("width_brief_narrow", 56.1, envir = .euiss_env)
    assign("width_brief_onecol", 85, envir = .euiss_env)
    assign("width_brief_twocol", 180, envir = .euiss_env)
    assign("width_brief_full", 210, envir = .euiss_env)
    assign("height_brief", 258.233, envir = .euiss_env)
  }
}

# =============================================================================
# Palette Initialization
# =============================================================================

#' Initialize EUISS palettes
#' @keywords internal
.init_palettes <- function() {
  
  # Get colors from environment
  teal <- get("teal", envir = .euiss_env, inherits = FALSE)
  teal0 <- get("teal0", envir = .euiss_env, inherits = FALSE)
  teal1 <- get("teal1", envir = .euiss_env, inherits = FALSE)
  teal1.1 <- get("teal1.1", envir = .euiss_env, inherits = FALSE)
  teal1.2 <- get("teal1.2", envir = .euiss_env, inherits = FALSE)
  teal2 <- get("teal2", envir = .euiss_env, inherits = FALSE)
  teal2.1 <- get("teal2.1", envir = .euiss_env, inherits = FALSE)
  teal3 <- get("teal3", envir = .euiss_env, inherits = FALSE)
  fuchsia1 <- get("fuchsia1", envir = .euiss_env, inherits = FALSE)
  fuchsia1.0 <- get("fuchsia1.0", envir = .euiss_env, inherits = FALSE)
  fuchsia2 <- get("fuchsia2", envir = .euiss_env, inherits = FALSE)
  fuchsia3 <- get("fuchsia3", envir = .euiss_env, inherits = FALSE)
  egg <- get("egg", envir = .euiss_env, inherits = FALSE)
  egg0 <- get("egg0", envir = .euiss_env, inherits = FALSE)
  lightorange <- get("lightorange", envir = .euiss_env, inherits = FALSE)
  mauve <- get("mauve", envir = .euiss_env, inherits = FALSE)
  mauve1 <- get("mauve1", envir = .euiss_env, inherits = FALSE)
  col_grid0 <- get("col_grid0", envir = .euiss_env, inherits = FALSE)
  col_grid <- get("col_grid", envir = .euiss_env, inherits = FALSE)
  
  # Create palette functions
  pal_cat <- grDevices::colorRampPalette(c(fuchsia2, teal, egg, teal2, teal0, mauve))
  pal_div <- grDevices::colorRampPalette(c(mauve, teal, col_grid0, egg, fuchsia3))
  pal_seq_r <- grDevices::colorRampPalette(c(mauve, fuchsia2, lightorange, egg))
  pal_seq_g <- grDevices::colorRampPalette(c(mauve, teal2, teal1, egg))
  pal_seq_b <- grDevices::colorRampPalette(c(mauve, teal, teal1))
  pal_seq_r_light <- grDevices::colorRampPalette(c(mauve, fuchsia2, lightorange, egg0))
  pal_seq_g_light <- grDevices::colorRampPalette(c(mauve, teal2, teal1, egg))
  pal_seq_b_light <- grDevices::colorRampPalette(c(mauve, teal, teal1.1))
  pal_seq_v <- grDevices::colorRampPalette(c(col_grid, teal2, mauve, fuchsia2))
  pal_seq_vir <- grDevices::colorRampPalette(c(mauve1, teal2.1, fuchsia1.0, egg0))
  pal_seq_bathy <- grDevices::colorRampPalette(c(mauve, teal3, teal2, teal, teal1.2))
  
  # Store palette functions
  assign("pal_cat", pal_cat, envir = .euiss_env)
  assign("pal_div", pal_div, envir = .euiss_env)
  assign("pal_seq_r", pal_seq_r, envir = .euiss_env)
  assign("pal_seq_g", pal_seq_g, envir = .euiss_env)
  assign("pal_seq_b", pal_seq_b, envir = .euiss_env)
  assign("pal_seq_r_light", pal_seq_r_light, envir = .euiss_env)
  assign("pal_seq_g_light", pal_seq_g_light, envir = .euiss_env)
  assign("pal_seq_b_light", pal_seq_b_light, envir = .euiss_env)
  assign("pal_seq_v", pal_seq_v, envir = .euiss_env)
  assign("pal_seq_vir", pal_seq_vir, envir = .euiss_env)
  assign("pal_seq_bathy", pal_seq_bathy, envir = .euiss_env)
}

# =============================================================================
# Mode Initialization
# =============================================================================

#' Initialize mode system
#' @keywords internal
.init_mode <- function() {
  if (!exists("euiss_current_mode", envir = .euiss_env, inherits = FALSE)) {
    assign("euiss_current_mode", "draft", envir = .euiss_env)
  }
}

# =============================================================================
# Namespace Helper
# =============================================================================

#' Copy colors from .euiss_env to package namespace
#' @keywords internal
.copy_colors_to_namespace <- function() {
  
  color_names <- c(
    "col_grid", "col_grid0", "col_axis", "col_axis_text", "grey25",
    "blue", "teal", "grey",
    "teal0", "teal1", "teal1.1", "teal1.2", "teal2", "teal2.1", "teal3",
    "egg", "egg0", "lightorange", "orange",
    "fuchsia1", "fuchsia1.0", "fuchsia2", "fuchsia3",
    "mauve", "mauve1",
    "frog", "mint",
    "lwd_grid", "lwd_line", "lwd_point"
  )
  
  ns <- parent.env(environment())
  
  for (name in color_names) {
    if (exists(name, envir = .euiss_env, inherits = FALSE)) {
      value <- get(name, envir = .euiss_env, inherits = FALSE)
      assign(name, value, envir = ns)
    }
  }
  
  invisible(NULL)
}

# =============================================================================
# Public Functions
# =============================================================================

#' Get current font settings
#' @return Named list with font settings
#' @export
euiss_get_fonts <- function() {
  .init_fonts()
  
  list(
    family = get("txt_family", envir = .euiss_env, inherits = FALSE),
    bold = get("txt_bold", envir = .euiss_env, inherits = FALSE),
    height = get("txt_height", envir = .euiss_env, inherits = FALSE),
    label_size = get("txt_label", envir = .euiss_env, inherits = FALSE)
  )
}

#' Set fonts for euissR package
#' @param family Font family name
#' @param bold Font weight for bold text
#' @param height Line height
#' @param label_size Text label size
#' @return Invisibly returns updated settings
#' @export
euiss_set_fonts <- function(family = NULL, bold = NULL, height = NULL, label_size = NULL) {
  .init_fonts()
  
  current <- euiss_get_fonts()
  
  if (!is.null(family)) current$family <- family
  if (!is.null(bold)) current$bold <- bold
  if (!is.null(height)) current$height <- height
  if (!is.null(label_size)) current$label_size <- label_size
  
  assign("txt_family", current$family, envir = .euiss_env)
  assign("txt_bold", current$bold, envir = .euiss_env)
  assign("txt_height", current$height, envir = .euiss_env)
  assign("txt_label", current$label_size, envir = .euiss_env)
  
  message("Font updated to: ", current$family)
  invisible(current)
}

# =============================================================================
# Package Load Hooks
# =============================================================================

.onLoad <- function(libname, pkgname) {
  # Initialize all systems
  .init_fonts()
  .init_colors()
  .init_palettes()
  .init_mode()
  .copy_colors_to_namespace()
}

.onAttach <- function(libname, pkgname) {
  
  # Get current mode and set appropriate theme
  current_mode <- get("euiss_current_mode", envir = .euiss_env, inherits = FALSE)
  
  if (current_mode == "print") {
    ggplot2::theme_set(theme_euiss_print())
  } else {
    ggplot2::theme_set(theme_euiss_draft())
  }
  
  # Set ggplot2 default colors
  pal_cat <- get("pal_cat", envir = .euiss_env, inherits = FALSE)
  pal_seq_v <- get("pal_seq_v", envir = .euiss_env, inherits = FALSE)
  
  options(
    ggplot2.discrete.fill = pal_cat(6),
    ggplot2.ordinal.fill = pal_seq_v(4),
    ggplot2.binned.fill = pal_cat(6),
    ggplot2.discrete.colour = pal_cat(6),
    ggplot2.ordinal.colour = pal_seq_v(4),
    ggplot2.binned.colour = pal_cat(6)
  )
  
  # Startup message
  font_family <- get("txt_family", envir = .euiss_env, inherits = FALSE)
  
  packageStartupMessage("euissR loaded successfully.")
  packageStartupMessage("Mode: ", toupper(current_mode), " | Font: ", font_family)
  packageStartupMessage("")
  packageStartupMessage("Quick reference:")
  packageStartupMessage("  euiss_mode('draft')  - Preview/sharing (PNG, SVG)")
  packageStartupMessage("  euiss_mode('print')  - Illustrator workflow (PDF)")
  packageStartupMessage("  euiss_logo()         - Add branding (draft mode)")
  
  if (font_family == "sans") {
    packageStartupMessage("")
    packageStartupMessage("Note: PT Sans fonts not found. Install from Google Fonts:")
    packageStartupMessage("  https://fonts.google.com/specimen/PT+Sans+Narrow")
  }
}
