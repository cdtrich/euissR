#' Load commonly used packages for EUISS data analysis
#' 
#' This function loads the packages commonly used in EUISS data analysis workflows,
#' similar to the style_v8.R script functionality.
#' 
#' @param quietly logical, whether to suppress package startup messages
#' @param warn.conflicts logical, whether to warn about conflicts
#' @export
#' @examples
#' \dontrun{
#' # Load all common packages
#' euiss_load_packages()
#' }
euiss_load_packages <- function(quietly = TRUE, warn.conflicts = FALSE) {
  # List of packages commonly used (from style script)
  packages <- c(
    "readxl",
    "dplyr", 
    "tidyr",
    "ggplot2",
    "readr",
    "tibble", 
    "stringr"
  )
  
  # Optional packages that may not be available
  optional_packages <- c(
    "here"
  )
  
  # Function to load a package with error handling
  load_package <- function(pkg) {
    if (requireNamespace(pkg, quietly = TRUE)) {
      library(pkg, character.only = TRUE, quietly = quietly, 
              warn.conflicts = warn.conflicts)
      return(TRUE)
    } else {
      return(FALSE)
    }
  }
  
  # Load required packages
  loaded <- sapply(packages, load_package)
  
  # Try to load optional packages
  optional_loaded <- sapply(optional_packages, load_package)
  
  if (!quietly) {
    message("Loaded packages: ", paste(names(loaded)[loaded], collapse = ", "))
    
    if (any(!loaded)) {
      warning("Failed to load packages: ", 
              paste(names(loaded)[!loaded], collapse = ", "))
    }
    
    if (any(optional_loaded)) {
      message("Optional packages loaded: ", 
              paste(names(optional_loaded)[optional_loaded], collapse = ", "))
    }
  }
  
  invisible(list(
    required = loaded,
    optional = optional_loaded
  ))
}

#' Get output dimensions for EUISS publications
#' 
#' Returns a named list of output dimensions in mm for different EUISS publication types.
#' Based on the measurements from the style script.
#' 
#' @param publication character, one of "cp", "book", or "brief"
#' @return named list with width and height measurements
#' @export
#' @examples
#' # Get dimensions for CP publication
#' cp_dims <- euiss_get_dimensions("cp")
#' print(cp_dims)
euiss_get_dimensions <- function(publication = c("cp", "book", "brief")) {
  publication <- match.arg(publication)
  
  dims <- switch(publication,
    "cp" = list(
      onecol = get("width_cp_onecol", envir = .euiss_env, inherits = FALSE),
      twocol = get("width_cp_twocol", envir = .euiss_env, inherits = FALSE),
      full = get("width_cp_full", envir = .euiss_env, inherits = FALSE),
      height = get("height_cp", envir = .euiss_env, inherits = FALSE)
    ),
    "book" = list(
      half = get("width_book_half", envir = .euiss_env, inherits = FALSE),
      col = get("width_book_col", envir = .euiss_env, inherits = FALSE),
      full = get("width_book_full", envir = .euiss_env, inherits = FALSE),
      height = get("height_book", envir = .euiss_env, inherits = FALSE)
    ),
    "brief" = list(
      narrow = get("width_brief_narrow", envir = .euiss_env, inherits = FALSE),
      onecol = get("width_brief_onecol", envir = .euiss_env, inherits = FALSE),
      twocol = get("width_brief_twocol", envir = .euiss_env, inherits = FALSE),
      full = get("width_brief_full", envir = .euiss_env, inherits = FALSE),
      height = get("height_brief", envir = .euiss_env, inherits = FALSE)
    )
  )
  
  return(dims)
}

#' Create margin theme with minimal margins (like mar0 in style script)
#' 
#' @param t top margin in mm
#' @param r right margin in mm  
#' @param b bottom margin in mm
#' @param l left margin in mm
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) + 
#'   geom_point() + 
#'   euiss_mar0()
euiss_mar0 <- function(t = 0.1, r = 0.1, b = 0.1, l = 0.1) {
  ggplot2::theme(plot.margin = ggplot2::margin(t, r, b, l, "mm"))
}

#' Enhanced continuous color scale using EUISS palette
#' @export
#' @examples
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = cyl)) +
#'   ggplot2::geom_point() +
#'   euiss_color_continuous()
euiss_color_continuous <- function() {
  pal_seq_b <- get("pal_seq_b", envir = .euiss_env, inherits = FALSE)
  ggplot2::scale_color_gradientn(
    colors = pal_seq_b(4), 
    aesthetics = c("color", "fill")
  )
}

#' Set font priority for EUISS branding
#' 
#' Helper function to easily switch between PT Sans variants after installation.
#' Useful for branding consistency in R -> Illustrator workflow.
#' 
#' @param font_preference character, preferred font family. Options: "PT Sans Pro Narrow", "PT Sans Narrow", "PT Sans", or "auto"
#' @export
#' @examples
#' \dontrun{
#' # After installing Adobe PT Sans Pro Narrow
#' euiss_set_font_priority("PT Sans Pro Narrow")
#' 
#' # Or use Google Fonts alternative  
#' euiss_set_font_priority("PT Sans Narrow")
#' 
#' # Auto-detect best available
#' euiss_set_font_priority("auto")
#' }
euiss_set_font_priority <- function(font_preference = "auto") {
  
  if (requireNamespace("extrafont", quietly = TRUE)) {
    available_fonts <- extrafont::fonts()
    
    if (font_preference == "auto") {
      # Use the same priority logic as onLoad
      if ("PT Sans Pro Narrow" %in% available_fonts) {
        new_font <- "PT Sans Pro Narrow"
      } else if ("PT Sans Narrow" %in% available_fonts) {
        new_font <- "PT Sans Narrow" 
      } else if ("PT Sans" %in% available_fonts) {
        new_font <- "PT Sans"
      } else {
        new_font <- "sans"
      }
    } else {
      # Check if requested font is available
      if (font_preference %in% available_fonts) {
        new_font <- font_preference
      } else {
        warning("Font '", font_preference, "' not found. Available PT fonts: ", 
                paste(available_fonts[grepl("PT", available_fonts)], collapse = ", "))
        return(invisible(FALSE))
      }
    }
    
    # Update the package environment
    assign("txt_family", new_font, envir = .euiss_env)
    
    # Update ggplot2 theme
    ggplot2::theme_set(theme_euiss())
    
    message("Font updated to: ", new_font)
    message("ggplot2 theme refreshed with new font.")
    return(invisible(TRUE))
    
  } else {
    warning("extrafont package required for font management")
    return(invisible(FALSE))
  }
}

#' Check available PT fonts for branding
#' @export
#' @examples
#' euiss_check_fonts()
euiss_check_fonts <- function() {
  # Check extrafont first
  extrafont_fonts <- character(0)
  if (requireNamespace("extrafont", quietly = TRUE)) {
    try({
      extrafont_fonts <- extrafont::fonts()
    }, silent = TRUE)
  }
  
  # Check systemfonts for Adobe fonts
  system_fonts <- character(0)
  if (requireNamespace("systemfonts", quietly = TRUE)) {
    try({
      all_system_fonts <- systemfonts::system_fonts()
      system_fonts <- unique(all_system_fonts$family)
    }, silent = TRUE)
  }
  
  # Combine sources
  available_fonts <- unique(c(extrafont_fonts, system_fonts))
  pt_fonts <- available_fonts[grepl("PT", available_fonts)]
  
  current_font <- get("txt_family", envir = .euiss_env, inherits = FALSE)
  
  if (length(pt_fonts) > 0) {
    message("Available PT fonts:")
    for (font in pt_fonts) {
      source_info <- ""
      if (font %in% extrafont_fonts && font %in% system_fonts) {
        source_info <- " (extrafont + system)"
      } else if (font %in% extrafont_fonts) {
        source_info <- " (extrafont)"
      } else if (font %in% system_fonts) {
        source_info <- " (system - may need registration)"
      }
      
      current <- if (font == current_font) " (CURRENT)" else ""
      message("  - ", font, source_info, current)
    }
    
    if (any(pt_fonts %in% system_fonts & !pt_fonts %in% extrafont_fonts)) {
      message("\nNote: Some fonts found in system but not in extrafont.")
      message("Try: euiss_force_import_fonts() to register them.")
    }
    
  } else {
    message("No PT fonts found. Consider installing:")
    message("  1. PT Sans Pro Narrow (Adobe Creative Cloud)")
    message("  2. PT Sans Narrow (Google Fonts)")
    message("  3. PT Sans (Google Fonts)")
  }
  
  return(invisible(pt_fonts))
}

#' Force import/register fonts found in system but not in extrafont
#' @export
#' @examples
#' \dontrun{
#' euiss_force_import_fonts()
#' }
euiss_force_import_fonts <- function() {
  if (!requireNamespace("systemfonts", quietly = TRUE)) {
    stop("systemfonts package required for force import")
  }
  
  # Get system fonts
  all_system_fonts <- systemfonts::system_fonts()
  system_pt_fonts <- unique(all_system_fonts$family[grepl("PT", all_system_fonts$family)])
  
  # Get extrafont fonts
  extrafont_fonts <- character(0)
  if (requireNamespace("extrafont", quietly = TRUE)) {
    extrafont_fonts <- extrafont::fonts()
  }
  
  # Find fonts in system but not in extrafont
  missing_fonts <- setdiff(system_pt_fonts, extrafont_fonts)
  
  if (length(missing_fonts) > 0) {
    message("Attempting to register missing PT fonts:")
    
    success_count <- 0
    for (font in missing_fonts) {
      message("  Registering: ", font)
      
      # Try to register with windowsFonts
      if (.Platform$OS.type == "windows") {
        tryCatch({
          windowsFonts(!!font := windowsFont(font))
          
          # Test if it works
          test_result <- tryCatch({
            old_par <- par(family = font)
            par(old_par)
            TRUE
          }, error = function(e) FALSE)
          
          if (test_result) {
            message("    SUCCESS: ", font, " registered and working")
            success_count <- success_count + 1
          } else {
            message("    WARNING: ", font, " registered but may not work in plots")
          }
          
        }, error = function(e) {
          message("    FAILED: ", font, " - ", e$message)
        })
      }
    }
    
    message("\nSummary: ", success_count, "/", length(missing_fonts), " fonts successfully registered")
    
    if (success_count > 0) {
      message("Try reloading euissR package to use new fonts:")
      message("  library(euissR)")
      message("  euiss_set_font_priority('auto')")
    }
    
  } else {
    message("No missing PT fonts found. All system PT fonts are already available in R.")
  }
  
  invisible(missing_fonts)
}

#' Enhanced discrete color scale using EUISS palette
#' @export
#' @examples
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(wt, mpg, col = base::factor(cyl))) +
#'   ggplot2::geom_point() +
#'   euiss_color_discrete()
euiss_color_discrete <- function() {
  pal_cat <- get("pal_cat", envir = .euiss_env, inherits = FALSE)
  ggplot2::scale_color_manual(
    values = pal_cat(6), 
    aesthetics = c("color", "fill")
  )
}
