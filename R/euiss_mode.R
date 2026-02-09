#' EUISS Mode System
#'
#' Toggle between draft mode (for preview/sharing) and print mode (for Illustrator post-production).
#'
#' @name euiss_mode
#' @aliases euiss-mode mode-system
NULL

# -----------------------------------------------------------------------------
# Mode Management
# -----------------------------------------------------------------------------

#' Set or get the current EUISS mode
#'
#' @param mode Character: "draft" or "print". If NULL, returns current mode.
#' @return Current mode (invisibly when setting)
#' @export
#'
#' @details
#' **Draft mode** (default):
#' - Optimized for preview and sharing with colleagues
#' - Uses PT Sans fonts (with fallback chain)
#' - Includes visual polish: shadows, refined spacing

#' - Can include EUISS logo via `euiss_logo()`
#' - Best for PNG/SVG exports
#'
#' **Print mode**:
#' - Optimized for PDF export → Adobe Illustrator workflow
#' - Uses Helvetica/Arial (reliable PDF embedding)
#' - All text left-aligned with baseline shift = 0
#' - Minimal margins (Illustrator will handle final layout)
#' - No decorative elements that complicate post-production
#'
#' @examples
#' # Check current mode
#' euiss_mode()
#'
#' # Switch to print mode for Illustrator work
#' euiss_mode("print")
#'
#' # Switch back to draft mode
#' euiss_mode("draft")
euiss_mode <- function(mode = NULL) {
  

  # Get current mode
  if (is.null(mode)) {
    current <- tryCatch(
      get("euiss_current_mode", envir = .euiss_env, inherits = FALSE),
      error = function(e) "draft"
    )
    return(current)
  }
  
  # Validate mode

  mode <- match.arg(mode, choices = c("draft", "print"))
  
  # Store mode

  assign("euiss_current_mode", mode, envir = .euiss_env)
  
  # Apply appropriate theme
  if (mode == "draft") {
    ggplot2::theme_set(theme_euiss_draft())
    message("EUISS mode: DRAFT")
    message("  - PT Sans fonts (with fallback)")
    message("  - Optimized for PNG/SVG preview")
    message("  - Use euiss_logo() to add branding")
  } else {
    ggplot2::theme_set(theme_euiss_print())
    message("EUISS mode: PRINT")
    message("
  - Helvetica/Arial (reliable PDF embedding)")
    message("  - Text baseline-aligned for Illustrator")
    message("  - Use ggsave_euiss(...) for PDF export")
  }
  
  invisible(mode)
}

# -----------------------------------------------------------------------------
# Draft Theme (Preview/Sharing)
# -----------------------------------------------------------------------------

#' EUISS Draft Theme
#'
#' Theme optimized for preview and sharing with colleagues.
#' Uses PT Sans fonts, refined spacing, and visual polish.
#'
#' @param base_size Base font size in points. Default 9.
#' @param base_family Base font family. Default uses PT Sans chain.
#' @return A ggplot2 theme object
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point() +
#'   theme_euiss_draft()
theme_euiss_draft <- function(base_size = 9, base_family = NULL) {
  
  # Ensure fonts are initialized
  .init_fonts()
  
  # Get font family (PT Sans chain)
  if (is.null(base_family)) {
    base_family <- get("txt_family", envir = .euiss_env, inherits = FALSE)
  }
  
  # Get colors from environment
  col_axis <- get("col_axis", envir = .euiss_env, inherits = FALSE)
  col_axis_text <- get("col_axis_text", envir = .euiss_env, inherits = FALSE)
  col_grid <- get("col_grid", envir = .euiss_env, inherits = FALSE)
  grey25 <- get("grey25", envir = .euiss_env, inherits = FALSE)
  lwd_grid <- get("lwd_grid", envir = .euiss_env, inherits = FALSE)
  
  # Relative sizes
  rel_small <- 0.75
  rel_tiny <- 0.65
  
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      
      # === TEXT ===
      text = ggplot2::element_text(
        family = base_family,
        colour = col_axis,
        lineheight = 0.9
      ),
      
      # === PLOT TITLES ===
      plot.title = ggplot2::element_text(
        face = "bold",
        size = ggplot2::rel(1.4),
        hjust = 0,
        vjust = 1,
        margin = ggplot2::margin(b = base_size * 0.5)
      ),
      plot.title.position = "plot",
      
      plot.subtitle = ggplot2::element_text(
        colour = grey25,
        size = ggplot2::rel(1.0),
        hjust = 0,
        vjust = 1,
        margin = ggplot2::margin(b = base_size * 0.75)
      ),
      
      plot.caption = ggplot2::element_text(
        colour = grey25,
        size = ggplot2::rel(rel_tiny),
        hjust = 1,
        margin = ggplot2::margin(t = base_size * 0.5)
      ),
      plot.caption.position = "plot",
      
      # === LEGEND ===
      legend.position = "top",
      legend.justification = c(0, 1),
      legend.direction = "horizontal",
      legend.box = "horizontal",
      legend.margin = ggplot2::margin(0, 0, base_size * 0.5, 0),
      legend.key.height = grid::unit(base_size * 0.6, "pt"),
      legend.key.width = grid::unit(base_size * 1.5, "pt"),
      legend.text = ggplot2::element_text(
        size = ggplot2::rel(rel_small),
        colour = col_axis
      ),
      legend.title = ggplot2::element_text(
        size = ggplot2::rel(rel_small),
        face = "bold",
        vjust = 0.5
      ),
      
      # === AXIS ===
      axis.title = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(
        size = ggplot2::rel(rel_small),
        colour = col_axis_text
      ),
      axis.text.x = ggplot2::element_text(
        margin = ggplot2::margin(t = base_size * 0.25)
      ),
      axis.text.y = ggplot2::element_text(
        hjust = 1,
        margin = ggplot2::margin(r = base_size * 0.25)
      ),
      axis.ticks = ggplot2::element_blank(),
      axis.ticks.length = grid::unit(0, "pt"),
      
      # === PANEL ===
      panel.background = ggplot2::element_rect(fill = NA, colour = NA),
      panel.border = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(
        colour = col_grid,
        linewidth = lwd_grid
      ),
      panel.grid.minor = ggplot2::element_blank(),
      panel.spacing = grid::unit(base_size, "pt"),
      
      # === FACETS ===
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(
        face = "bold",
        hjust = 0,
        vjust = 1,
        margin = ggplot2::margin(b = base_size * 0.5)
      ),
      strip.clip = "off",
      
      # === PLOT ===
      plot.background = ggplot2::element_rect(fill = "white", colour = NA),
      plot.margin = ggplot2::margin(
        t = base_size,
        r = base_size,
        b = base_size,
        l = base_size
      )
    )
}

# -----------------------------------------------------------------------------
# Print Theme (Illustrator Post-Production)
# -----------------------------------------------------------------------------

#' EUISS Print Theme
#'
#' Theme optimized for PDF export and Adobe Illustrator post-production.
#' Uses reliably-embedding fonts, baseline-aligned text, minimal decoration.
#'
#' @param base_size Base font size in points. Default 8.
#' @param base_family Base font family. Default "Helvetica" (or "Arial" on Windows).
#' @return A ggplot2 theme object
#' @export
#'
#' @details
#' Key differences from draft theme:
#' - Uses Helvetica/Arial (always embeds in PDF)
#' - All text uses hjust=0 (left-aligned) and vjust=0 (baseline)
#' - Minimal margins (Illustrator handles final layout)
#' - No plot background (transparent)
#' - Axis text positioned for easy paragraph style application
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point() +
#'   theme_euiss_print()
theme_euiss_print <- function(base_size = 8, base_family = NULL) {
  
  # Use Helvetica on Mac/Linux, Arial on Windows
  if (is.null(base_family)) {
    base_family <- if (.Platform$OS.type == "windows") "Arial" else "Helvetica"
  }
  
  # Get colors from environment
  col_axis <- get("col_axis", envir = .euiss_env, inherits = FALSE)
  col_axis_text <- get("col_axis_text", envir = .euiss_env, inherits = FALSE)
  col_grid <- get("col_grid", envir = .euiss_env, inherits = FALSE)
  grey25 <- get("grey25", envir = .euiss_env, inherits = FALSE)
  lwd_grid <- get("lwd_grid", envir = .euiss_env, inherits = FALSE)
  
  # Relative sizes (consistent with draft for easier Illustrator replacement)
  rel_small <- 0.75
  rel_tiny <- 0.65
  
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      
      # === TEXT ===
      # All text baseline-aligned (vjust = 0) for Illustrator paragraph styles
      text = ggplot2::element_text(
        family = base_family,
        colour = col_axis,
        lineheight = 1.0  # Predictable for Illustrator
      ),
      
      # === PLOT TITLES ===
      # Left-aligned, baseline-anchored
      plot.title = ggplot2::element_text(
        face = "bold",
        size = ggplot2::rel(1.4),
        hjust = 0,
        vjust = 0,  # Baseline anchor
        margin = ggplot2::margin(b = base_size * 0.5)
      ),
      plot.title.position = "panel",  # Aligns with panel for easier repositioning
      
      plot.subtitle = ggplot2::element_text(
        colour = grey25,
        size = ggplot2::rel(1.0),
        hjust = 0,
        vjust = 0,
        margin = ggplot2::margin(b = base_size * 0.5)
      ),
      
      plot.caption = ggplot2::element_text(
        colour = grey25,
        size = ggplot2::rel(rel_tiny),
        hjust = 0,  # Left-aligned (not right) for consistent baseline
        vjust = 0,
        margin = ggplot2::margin(t = base_size * 0.25)
      ),
      plot.caption.position = "panel",
      
      # === LEGEND ===
      legend.position = "top",
      legend.justification = c(0, 0),  # Baseline anchor
      legend.direction = "horizontal",
      legend.box = "horizontal",
      legend.margin = ggplot2::margin(0, 0, base_size * 0.5, 0),
      legend.key.height = grid::unit(base_size * 0.5, "pt"),
      legend.key.width = grid::unit(base_size * 1.2, "pt"),
      legend.text = ggplot2::element_text(
        size = ggplot2::rel(rel_small),
        colour = col_axis,
        vjust = 0
      ),
      legend.title = ggplot2::element_text(
        size = ggplot2::rel(rel_small),
        face = "bold",
        vjust = 0
      ),
      
      # === AXIS ===
      axis.title = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(
        size = ggplot2::rel(rel_small),
        colour = col_axis_text,
        vjust = 0  # Baseline anchor
      ),
      axis.text.x = ggplot2::element_text(
        hjust = 0.5,  # Center for x-axis
        vjust = 0,
        margin = ggplot2::margin(t = 2)  # Minimal, precise
      ),
      axis.text.y = ggplot2::element_text(
        hjust = 0,  # Right-aligned for y-axis labels
        vjust = 0,
        margin = ggplot2::margin(r = 2)
      ),
      axis.ticks = ggplot2::element_blank(),
      axis.ticks.length = grid::unit(0, "pt"),
      
      # === PANEL ===
      panel.background = ggplot2::element_rect(fill = NA, colour = NA),
      panel.border = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(
        colour = col_grid,
        linewidth = lwd_grid
      ),
      panel.grid.minor = ggplot2::element_blank(),
      panel.spacing = grid::unit(base_size, "pt"),
      
      # === FACETS ===
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(
        face = "bold",
        hjust = 0,
        vjust = 0,  # Baseline anchor
        margin = ggplot2::margin(b = base_size * 0.25)
      ),
      strip.clip = "off",
      
      # === PLOT ===
      # Transparent background for Illustrator
      plot.background = ggplot2::element_rect(fill = NA, colour = NA),
      # Minimal margins - Illustrator handles final layout
      plot.margin = ggplot2::margin(
        t = 2,
        r = 2,
        b = 2,
        l = 2
      )
    )
}

# -----------------------------------------------------------------------------
# Logo Annotation (Draft Mode)
# -----------------------------------------------------------------------------

#' Add EUISS Logo to Plot
#'
#' Adds the EUISS logo to the bottom-left corner of a plot (draft mode only).
#'
#' @param logo_path Path to logo file. If NULL, uses built-in placeholder.
#' @param x X position (0-1, from left). Default 0.02.
#' @param y Y position (0-1, from bottom). Default 0.02.
#' @param width Logo width as fraction of plot width. Default 0.12.
#' @param alpha Logo transparency. Default 0.9.
#' @return A ggplot2 annotation layer
#' @export
#'
#' @details
#' For this to work, place your EUISS logo PNG at one of these locations:
#' - `inst/logo/euiss_logo.png` in the package
#' - Path specified by `options(euiss.logo_path = "path/to/logo.png")`
#' - Explicit `logo_path` argument
#'
#' In print mode, this function returns NULL (no logo added).
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point() +
#'   euiss_logo()
#' }
euiss_logo <- function(logo_path = NULL,
                       x = 0.02,
                       y = 0.02,
                       width = 0.12,
                       alpha = 0.9) {
  
  # Skip in print mode
  current_mode <- euiss_mode()
  if (current_mode == "print") {
    message("Note: Logo skipped in print mode (use draft mode for branded exports)")
    return(NULL)
  }
  
  # Find logo
  if (is.null(logo_path)) {
    # Check options first
    logo_path <- getOption("euiss.logo_path")
    
    # Then check package inst folder
    if (is.null(logo_path) || !file.exists(logo_path)) {
      pkg_logo <- system.file("logo", "euiss_logo.png", package = "euissR")
      if (nzchar(pkg_logo) && file.exists(pkg_logo)) {
        logo_path <- pkg_logo
      }
    }
  }
  
  # Check if logo exists
  if (is.null(logo_path) || !file.exists(logo_path)) {
    message("Logo not found. Set path with:")
    message('  options(euiss.logo_path = "path/to/euiss_logo.png")')
    message("Or place logo at: inst/logo/euiss_logo.png")
    return(NULL)
  }
  
  # Check for required packages
  if (!requireNamespace("png", quietly = TRUE) ||
      !requireNamespace("grid", quietly = TRUE)) {
    message("Packages 'png' and 'grid' required for logo. Install with:")
    message('  install.packages(c("png", "grid"))')
    return(NULL)
  }
  
  # Read and add logo
  tryCatch({
    logo <- png::readPNG(logo_path)
    logo_grob <- grid::rasterGrob(
      logo,
      x = grid::unit(x, "npc"),
      y = grid::unit(y, "npc"),
      width = grid::unit(width, "npc"),
      hjust = 0,
      vjust = 0,
      interpolate = TRUE
    )
    
    ggplot2::annotation_custom(
      logo_grob,
      xmin = -Inf, xmax = Inf,
      ymin = -Inf, ymax = Inf
    )
  }, error = function(e) {
    message("Could not load logo: ", e$message)
    return(NULL)
  })
}

# -----------------------------------------------------------------------------
# Mode-Aware Text Geom
# -----------------------------------------------------------------------------

#' Mode-Aware Text Annotation
#'
#' A wrapper around geom_text_euiss that respects print mode baseline alignment.
#'
#' @inheritParams geom_text_euiss
#' @return A ggplot2 geom layer
#' @export
#'
#' @details
#' In print mode, this automatically sets vjust = 0 for baseline alignment.
#' In draft mode, it uses the standard geom_text_euiss defaults.
geom_text_euiss_mode <- function(mapping = NULL,
                                 data = NULL,
                                 col = NULL,
                                 family = NULL,
                                 size = NULL,
                                 hjust = "left",
                                 vjust = NULL,
                                 lineheight = 0.85,
                                 nudge_x = NA,
                                 show.legend = NA,
                                 inherit.aes = TRUE,
                                 ...) {
  
  current_mode <- euiss_mode()
  
  # In print mode, force baseline alignment
  if (current_mode == "print") {
    vjust <- 0
    lineheight <- 1.0
    
    # Use Helvetica/Arial
    if (is.null(family)) {
      family <- if (.Platform$OS.type == "windows") "Arial" else "Helvetica"
    }
  } else {
    # Draft mode defaults
    if (is.null(vjust)) vjust <- 0.5
    
    if (is.null(family)) {
      family <- get("txt_family", envir = .euiss_env, inherits = FALSE)
    }
  }
  
  # Get remaining defaults
  if (is.null(col)) {
    col <- get("col_axis", envir = .euiss_env, inherits = FALSE)
  }
  if (is.null(size)) {
    size <- get("txt_label", envir = .euiss_env, inherits = FALSE)
  }
  
  ggplot2::geom_text(
    data = data,
    mapping = mapping,
    col = col,
    family = family,
    size = size,
    hjust = hjust,
    vjust = vjust,
    lineheight = lineheight,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    ...
  )
}

# -----------------------------------------------------------------------------
# Backward Compatibility
# -----------------------------------------------------------------------------

#' EUISS Theme (Backward Compatible)
#'
#' This function now dispatches to either theme_euiss_draft() or theme_euiss_print()
#' based on the current mode. Maintains backward compatibility.
#'
#' @return A ggplot2 theme object
#' @export
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point() +
#'   theme_euiss()
theme_euiss <- function() {
  current_mode <- tryCatch(
    get("euiss_current_mode", envir = .euiss_env, inherits = FALSE),
    error = function(e) "draft"
  )
  
  if (current_mode == "print") {
    theme_euiss_print()
  } else {
    theme_euiss_draft()
  }
}
