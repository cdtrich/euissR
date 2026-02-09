#' Custom ggplot2::ggsave() with Mode-Aware Font Handling
#'
#' @param filename Name of file, including sub-folders and file extension.
#' @param plot Plot to save. Defaults to last plot.
#' @param publication Character: "book", "cp", or "brief".
#' @param w Character: "onecol", "twocol", "full", "spread", or "narrow" (brief only).
#' @param h Numeric: fraction of full height (0-1).
#' @param units Units for width/height. Default "mm".
#' @param dev Optional explicit device function.
#' @param mode Override current mode: "draft", "print", or NULL (use current).
#' @param embed_fonts Logical: attempt font embedding for PDF? Default TRUE.
#' @param dpi Resolution for raster formats. Default 300.
#' @param ... Additional arguments passed to ggsave().
#'
#' @return Invisible NULL. Called for side effect of saving file.
#' @importFrom magrittr %>%
#' @export
#'
#' @details
#' This function is mode-aware:
#'
#' **Draft mode** (PNG, SVG recommended):
#' - Uses PT Sans fonts with showtext for reliable rendering
#' - Higher DPI (300) for crisp preview
#' - White background
#'
#' **Print mode** (PDF recommended):
#' - Uses Helvetica/Arial (reliable embedding)
#' - Transparent background
#' - No font embedding attempt (fonts convert to outlines in Illustrator anyway)
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
#'
#' # Draft mode: PNG for preview
#' euiss_mode("draft")
#' ggsave_euiss("preview.png", p, publication = "cp", w = "onecol", h = 0.5)
#'
#' # Print mode: PDF for Illustrator
#' euiss_mode("print")
#' ggsave_euiss("for_illustrator.pdf", p, publication = "cp", w = "onecol", h = 0.5)
#' }
ggsave_euiss <- function(filename,
                         plot = ggplot2::last_plot(),
                         publication = c("book", "cp", "brief"),
                         w = NA,
                         h = 1,
                         units = "mm",
                         dev = NULL,
                         mode = NULL,
                         embed_fonts = TRUE,
                         dpi = 300,
                         ...) {
  
  # ---------------------------------------------------------------------------
  # Input Validation
  # ---------------------------------------------------------------------------
  
  if (!is.character(filename) || length(filename) != 1L) {
    stop("`filename` must be a single string.", call. = FALSE)
  }
  
  publication <- match.arg(publication)
  
  if (is.na(w)) {
    stop("`w` must be set to one of: 'onecol', 'twocol', 'full', 'spread'", 
         call. = FALSE)
  }
  
  ext <- tolower(tools::file_ext(filename))
  if (identical(ext, "")) {
    stop("`filename` must include a file extension (e.g., '.pdf', '.png').", 
         call. = FALSE)
  }
  
  # ---------------------------------------------------------------------------
  # Get Current Mode
  # ---------------------------------------------------------------------------
  
  if (is.null(mode)) {
    mode <- tryCatch(
      get("euiss_current_mode", envir = .euiss_env, inherits = FALSE),
      error = function(e) "draft"
    )
  } else {
    mode <- match.arg(mode, choices = c("draft", "print"))
  }
  
  # ---------------------------------------------------------------------------
  # Calculate Dimensions
  # ---------------------------------------------------------------------------
  
  dims <- .get_publication_dims(publication)
  
  width_loc <- dims[[w]]
  if (is.null(width_loc)) {
    valid_widths <- names(dims)[names(dims) != "height"]
    stop("`w` = '", w, "' not valid for publication '", publication, "'. ",
         "Options: ", paste(valid_widths, collapse = ", "), call. = FALSE)
  }
  
  height_loc <- dims$height * h
  
  # ---------------------------------------------------------------------------
  # Mode-Specific Export
  # ---------------------------------------------------------------------------
  
  message(sprintf("Exporting [%s mode] to %s: %.1f x %.1f mm",
                  toupper(mode), ext, width_loc, height_loc))
  
  if (mode == "draft") {
    .export_draft(filename, plot, width_loc, height_loc, units, ext, dev, dpi, ...)
  } else {
    .export_print(filename, plot, width_loc, height_loc, units, ext, dev, 
                  embed_fonts, dpi, ...)
  }
  
  invisible(NULL)
}

# -----------------------------------------------------------------------------
# Helper: Get Publication Dimensions
# -----------------------------------------------------------------------------

.get_publication_dims <- function(publication) {
  switch(publication,
    "book" = list(
      height = 181.25,
      onecol = 60,        # called "half" in some places
      twocol = 108,       # called "col" in some places
      full = 135,
      spread = 135 * 2
    ),
    "cp" = list(
      height = 221.9,
      onecol = 65.767,
      twocol = 140,
      full = 180,
      spread = 180 * 2
    ),
    "brief" = list(
      height = 258.233,
      narrow = 56.1,
      onecol = 85,
      twocol = 180,
      full = 210,
      spread = 210 * 2
    )
  )
}

# -----------------------------------------------------------------------------
# Helper: Draft Mode Export
# -----------------------------------------------------------------------------

.export_draft <- function(filename, plot, width, height, units, ext, dev, dpi, ...) {
  
  # For draft mode, showtext provides reliable font rendering
  use_showtext <- requireNamespace("showtext", quietly = TRUE)
  
  if (use_showtext) {
    # Ensure PT Sans is loaded via Google Fonts
    .ensure_showtext_fonts()
    showtext::showtext_auto()
  }
  
  if (ext == "svg") {
    .export_svg(filename, plot, width, height, ...)
    
  } else if (ext == "pdf") {
    # For draft PDF, we still try to make it look good
    # But recommend PNG/SVG for sharing
    message("Tip: For draft sharing, PNG or SVG often work better than PDF.")
    
    # Convert mm to inches for cairo_pdf
    width_in <- width / 25.4
    height_in <- height / 25.4
    
    if (use_showtext) {
      grDevices::cairo_pdf(filename, width = width_in, height = height_in)
      showtext::showtext_begin()
      print(plot)
      showtext::showtext_end()
      grDevices::dev.off()
    } else {
      ggplot2::ggsave(
        filename = filename,
        plot = plot,
        width = width,
        height = height,
        units = units,
        device = grDevices::cairo_pdf,
        ...
      )
    }
    
  } else {
    # PNG, JPG, etc.
    if (use_showtext) {
      # Use showtext for reliable font rendering
      showtext::showtext_auto()
    }
    
    ggplot2::ggsave(
      filename = filename,
      plot = plot,
      width = width,
      height = height,
      units = units,
      dpi = dpi,
      bg = "white",
      ...
    )
    
    if (use_showtext) {
      showtext::showtext_auto(FALSE)
    }
  }
  
  message("✓ Draft export complete: ", filename)
}

# -----------------------------------------------------------------------------
# Helper: Print Mode Export  
# -----------------------------------------------------------------------------

.export_print <- function(filename, plot, width, height, units, ext, dev, 
                          embed_fonts, dpi, ...) {
  
  # Print mode uses system fonts (Helvetica/Arial) - no showtext needed
  
  if (ext == "pdf") {
    # This is the primary print mode format
    
    # Convert mm to inches
    width_in <- width / 25.4
    height_in <- height / 25.4
    
    if (!is.null(dev)) {
      # Use explicit device
      ggplot2::ggsave(
        filename = filename,
        plot = plot,
        width = width,
        height = height,
        units = units,
        device = dev,
        ...
      )
    } else {
      # Use cairo_pdf for better text handling
      grDevices::cairo_pdf(
        filename = filename,
        width = width_in,
        height = height_in,
        family = if (.Platform$OS.type == "windows") "Arial" else "Helvetica"
      )
      print(plot)
      grDevices::dev.off()
    }
    
    message("✓ Print PDF ready for Illustrator: ", filename)
    message("  Note: Convert text to outlines in Illustrator if sharing further")
    
  } else if (ext == "svg") {
    .export_svg(filename, plot, width, height, ...)
    
  } else {
    # Other formats (PNG, etc.) - less common for print workflow
    ggplot2::ggsave(
      filename = filename,
      plot = plot,
      width = width,
      height = height,
      units = units,
      dpi = dpi,
      bg = "transparent",  # Transparent for print compositing
      ...
    )
  }
  
  message("✓ Print export complete: ", filename)
}

# -----------------------------------------------------------------------------
# Helper: SVG Export
# -----------------------------------------------------------------------------

.export_svg <- function(filename, plot, width, height, ...) {
  
  # Convert mm to inches
  width_in <- width / 25.4
  height_in <- height / 25.4
  
  if (requireNamespace("svglite", quietly = TRUE)) {
    svglite::svglite(
      filename = filename,
      width = width_in,
      height = height_in
    )
    print(plot)
    grDevices::dev.off()
    message("✓ SVG exported with svglite (custom fonts preserved)")
  } else {
    warning(
      "svglite not found. Install with: install.packages('svglite')\n",
      "Falling back to grDevices::svg (fonts may not render correctly)",
      call. = FALSE
    )
    grDevices::svg(
      filename = filename,
      width = width_in,
      height = height_in
    )
    print(plot)
    grDevices::dev.off()
  }
}

# -----------------------------------------------------------------------------
# Helper: Ensure showtext fonts are loaded
# -----------------------------------------------------------------------------

.ensure_showtext_fonts <- function() {
  
  if (!requireNamespace("showtext", quietly = TRUE)) return()
  if (!requireNamespace("sysfonts", quietly = TRUE)) return()
  
  # Check if PT Sans Narrow is already loaded
  loaded_fonts <- sysfonts::font_families()
  
  if (!"PT Sans Narrow" %in% loaded_fonts) {
    tryCatch({
      sysfonts::font_add_google("PT Sans Narrow", "PT Sans Narrow")
      message("Loaded PT Sans Narrow from Google Fonts")
    }, error = function(e) {
      # Silently fall back to sans
    })
  }
}

# -----------------------------------------------------------------------------
# Convenience Wrappers
# -----------------------------------------------------------------------------

#' Quick Draft Export (PNG)
#'
#' Convenience function for common draft workflow: export PNG for sharing.
#'
#' @inheritParams ggsave_euiss
#' @export
#'
#' @examples
#' \dontrun{
#' p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
#' euiss_save_draft(p, "preview", publication = "cp", w = "onecol", h = 0.5)
#' }
euiss_save_draft <- function(plot = ggplot2::last_plot(),
                             filename = "draft",
                             publication = "cp",
                             w = "onecol",
                             h = 0.5,
                             dpi = 300,
                             ...) {
  
  # Add .png extension if missing
  if (!grepl("\\.png$", filename, ignore.case = TRUE)) {
    filename <- paste0(filename, ".png")
  }
  
  ggsave_euiss(
    filename = filename,
    plot = plot,
    publication = publication,
    w = w,
    h = h,
    mode = "draft",
    dpi = dpi,
    ...
  )
}

#' Quick Print Export (PDF)
#'
#' Convenience function for print workflow: export PDF for Illustrator.
#'
#' @inheritParams ggsave_euiss
#' @export
#'
#' @examples
#' \dontrun{
#' p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
#' euiss_save_print(p, "for_illustrator", publication = "cp", w = "onecol", h = 0.5)
#' }
euiss_save_print <- function(plot = ggplot2::last_plot(),
                             filename = "print",
                             publication = "cp",
                             w = "onecol",
                             h = 0.5,
                             ...) {
  
  # Add .pdf extension if missing
  if (!grepl("\\.pdf$", filename, ignore.case = TRUE)) {
    filename <- paste0(filename, ".pdf")
  }
  
  ggsave_euiss(
    filename = filename,
    plot = plot,
    publication = publication,
    w = w,
    h = h,
    mode = "print",
    ...
  )
}
