# Package environment for font and variable settings
.euiss_env <- new.env(parent = emptyenv())

#' Enhanced font initialization with better error handling
.init_fonts <- function() {
  if (!exists("txt_family", envir = .euiss_env, inherits = FALSE)) {
    
    # Initialize font family to default
    font_family <- "sans"
    
    # Method 1: Try extrafont first
    extrafont_fonts <- character(0)
    if (requireNamespace("extrafont", quietly = TRUE)) {
      try({
        extrafont::loadfonts(quiet = TRUE, device = "win")
        extrafont::loadfonts(quiet = TRUE, device = "pdf")
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
      # Register with Windows if found via systemfonts
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
    # Priority 3: PT Sans (from style script)
    else if ("PT Sans" %in% available_fonts) {
      if (.Platform$OS.type == "windows") {
        try(grDevices::windowsFonts(PTSans = grDevices::windowsFont("PT Sans")), silent = TRUE)
      }
      font_family <- "PT Sans"
    } else {
      # Try to import PT Sans fonts if not found
      font_paths <- c(
        file.path(Sys.getenv("USERPROFILE"), "AppData", "Local", "Microsoft", "Windows", "Fonts"),
        file.path(Sys.getenv("SystemRoot"), "Fonts"),
        "/System/Library/Fonts",  # macOS
        "/usr/share/fonts"        # Linux
      )
      
      for (path in font_paths) {
        if (dir.exists(path)) {
          try({
            extrafont::font_import(paths = path, recursive = FALSE, 
                                   pattern = "PT", prompt = FALSE)
            extrafont::loadfonts(quiet = TRUE, device = "win")
            
            updated_fonts <- extrafont::fonts()
            # Check in priority order after import
            if ("PT Sans Pro Narrow" %in% updated_fonts) {
              font_family <- "PT Sans Pro Narrow"
              break
            } else if ("PT Sans Narrow" %in% updated_fonts) {
              font_family <- "PT Sans Narrow"
              break
            } else if ("PT Sans" %in% updated_fonts) {
              if (.Platform$OS.type == "windows") {
                grDevices::windowsFonts(PTSans = grDevices::windowsFont("PT Sans"))
              }
              font_family <- "PT Sans"
              break
            }
          }, silent = TRUE)
        }
      }
    }
    
    # Font settings
    assign("txt_family", font_family, envir = .euiss_env)
    assign("txt_bold", "bold", envir = .euiss_env)
    assign("txt_height", 0.85, envir = .euiss_env)
    assign("txt_label", 2.66, envir = .euiss_env)
    assign("txt_size", 2.66, envir = .euiss_env)
    
    # Enhanced color settings (from style script)
    # Basic colors
    assign("col_grid", "#C6C6C6", envir = .euiss_env)
    assign("col_grid0", "#F9F9F9", envir = .euiss_env)  # New from style
    assign("col_axis", "#1D1D1B", envir = .euiss_env)
    assign("col_axis_text", "#646363", envir = .euiss_env)
    assign("grey25", "#646363", envir = .euiss_env)
    
    # Updated visual ID colors (from style script)
    assign("blue", "#113655", envir = .euiss_env)  # New
    assign("teal", "#309ebe", envir = .euiss_env)  # Updated from #00A0C1
    assign("grey", "#595959", envir = .euiss_env)
    
    # Cold colors with variants
    assign("teal0", "#64C2C7", envir = .euiss_env)  # Updated
    assign("teal1", "#64c2c7", envir = .euiss_env)
    assign("teal1.1", "#ccffff", envir = .euiss_env)  # New
    assign("teal1.2", "#C1E6E7", envir = .euiss_env)  # New
    assign("teal2", "#376882", envir = .euiss_env)
    assign("teal2.1", "#3E4E6F", envir = .euiss_env)  # New
    assign("teal3", "#1d3956", envir = .euiss_env)
    
    # Warm colors with variants
    assign("egg", "#ffde75", envir = .euiss_env)  # Updated from #ffde74
    assign("egg0", "#FFFFA6", envir = .euiss_env)  # New
    assign("lightorange", "#f9b466", envir = .euiss_env)
    assign("orange", "#f28d22", envir = .euiss_env)
    assign("fuchsia1", "#ec5f5b", envir = .euiss_env)
    assign("fuchsia1.0", "#EE726D", envir = .euiss_env)  # New
    assign("fuchsia2", "#df3144", envir = .euiss_env)
    assign("fuchsia3", "#a41e26", envir = .euiss_env)
    assign("mauve", "#33163a", envir = .euiss_env)
    assign("mauve1", "#200E25", envir = .euiss_env)  # New
    
    # Green colors
    assign("frog", "#4cb748", envir = .euiss_env)
    assign("mint", "#99cb92", envir = .euiss_env)
    
    # Measurement settings
    assign("lwd_grid", 0.176 * 1.32, envir = .euiss_env)
    assign("lwd_line", 0.353 * 1.325, envir = .euiss_env)
    assign("lwd_point", 2, envir = .euiss_env)
    
    # Output dimensions (from style script)
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

#' Enhanced palette functions using updated colors
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
  
  # Enhanced palettes from style script
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

#' Get current font settings
#' @export
euiss_get_fonts <- function() {
  .init_fonts()  # Ensure fonts are initialized
  
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
#' @export
euiss_set_fonts <- function(family = NULL, bold = NULL, height = NULL, label_size = NULL) {
  .init_fonts()  # Ensure fonts are initialized
  
  # Get current settings
  current <- euiss_get_fonts()
  
  # Update only provided parameters
  if (!is.null(family)) current$family <- family
  if (!is.null(bold)) current$bold <- bold  
  if (!is.null(height)) current$height <- height
  if (!is.null(label_size)) current$label_size <- label_size
  
  # Validate font availability
  if (current$family != "sans") {
    # Try to load fonts if not already loaded
    if (requireNamespace("extrafont", quietly = TRUE)) {
      extrafont::loadfonts(quiet = TRUE, device = "win")
      available_fonts <- extrafont::fonts()
      if (!current$family %in% available_fonts) {
        warning(paste("Font", current$family, "not available. Using 'sans'."))
        current$family <- "sans"
      }
    } else {
      warning("extrafont package not available. Using 'sans'.")
      current$family <- "sans"
    }
  }
  
  # Store in package environment
  assign("txt_family", current$family, envir = .euiss_env)
  assign("txt_bold", current$bold, envir = .euiss_env) 
  assign("txt_height", current$height, envir = .euiss_env)
  assign("txt_label", current$label_size, envir = .euiss_env)
  
  message(paste("Font updated to:", current$family))
  invisible(current)
}

#' Copy colors from .euiss_env to package namespace
#' 
#' This allows functions to use colors directly in default parameters.
#' For example: geom_col_euiss(fill = teal) works because teal is
#' available in the package namespace, not just in .euiss_env.
.copy_colors_to_namespace <- function() {
  
  color_names <- c(
    # basic
    "col_grid", "col_grid0", "col_axis", "col_axis_text", "grey25",
    
    # cold
    "blue", "teal", "grey",
    "teal0", "teal1", "teal1.1", "teal1.2", 
    "teal2", "teal2.1", "teal3",
    
    # warm
    "egg", "egg0", "lightorange", "orange",
    "fuchsia1", "fuchsia1.0", "fuchsia2", "fuchsia3",
    "mauve", "mauve1",
    
    # green
    "frog", "mint",
    
    # line widths
    "lwd_grid", "lwd_line", "lwd_point"
  )
  
  # Get package namespace (parent environment of current function environment)
  ns <- parent.env(environment())
  
  # Copy each variable from .euiss_env to package namespace
  for (name in color_names) {
    if (exists(name, envir = .euiss_env, inherits = FALSE)) {
      value <- get(name, envir = .euiss_env, inherits = FALSE)
      assign(name, value, envir = ns)
    }
  }
  
  invisible(NULL)
}

.onLoad <- function(libname, pkgname) {
  .init_fonts()
  .init_palettes()
  .copy_colors_to_namespace()  # <-- ADD THIS LINE
}

.onAttach <- function(libname, pkgname) {
  # Set the enhanced theme after everything is loaded
  ggplot2::theme_set(theme_euiss())
  
  # Set ggplot2 default colors (from style script)
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
  
  font_family <- get("txt_family", envir = .euiss_env, inherits = FALSE)
  packageStartupMessage("euissR loaded successfully.")
  packageStartupMessage("Default ggplot2 theme set to theme_euiss().")
  packageStartupMessage("Font family: ", font_family)
  
  if (font_family == "PT Sans Pro Narrow") {
    packageStartupMessage("PT Sans Pro Narrow loaded - perfect for branding consistency!")
  } else if (font_family == "PT Sans Narrow") {
    packageStartupMessage("PT Sans Narrow loaded - excellent for branding!")
  } else if (font_family %in% c("PT Sans", "PT Sans Narrow")) {
    packageStartupMessage("PT fonts loaded successfully.")
  } else {
    packageStartupMessage("Using default font. For branding: install PT Sans Pro Narrow (Adobe) or PT Sans Narrow (Google).")
    packageStartupMessage("Use euiss_set_font_priority() to set preferred font after installation.")
  }
}