#' Custom ggplot2::ggsave() with proper font handling for all formats
#'
#' Enhanced version that uses showtext for PDF exports (fixes Illustrator font issues)
#' while maintaining support for SVG, PNG, JPG, and other formats.
#'
#' @param plot last plot (default: ggplot2::last_plot())
#' @param filename name of file, incl. sub-folders, *incl. file extension*
#' @param publication \code{character}, one of \code{book}, \code{brief} or \code{cp}  
#' @param w \code{character}, one of \code{onecol}, \code{twocol} or \code{full} for width 
#' @param h \code{numeric} fraction of full height (default: 1)
#' @param units units of width and height, defaults to \code{mm}
#' @param dev optional explicit device; otherwise inferred from extension
#' @param pdf_method "showtext" (default, better for Illustrator) or "cairo" (standard)
#' @param embed_fonts logical, whether to attempt font embedding for PDF (requires GhostScript). Only used if pdf_method = "cairo"
#' @param dpi resolution for raster formats (PNG, JPG). Default 300 for print quality
#' @param ... other arguments that can be passed to \code{ggplot2::ggsave()}
#'
#' @return Parametrized \code{ggsave()}
#' @importFrom magrittr %>%
#' @export
#' 
#' @examples 
#' # Positional parameters (quick export style)
#' ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) + geom_point_euiss()
#' ggsave_euiss("plot.pdf", , "cp", "onecol", 1)
#' 
#' # Named parameters (explicit)
#' ggsave_euiss(filename = "plot.pdf", publication = "cp", w = "onecol", h = 1)
#' 
#' # Different formats
#' ggsave_euiss("plot.svg", , "cp", "onecol", 1)
#' ggsave_euiss("plot.png", , "cp", "onecol", 1, dpi = 600)
#' 
#' # Use old cairo method if needed
#' ggsave_euiss("plot.pdf", , "cp", "onecol", 1, pdf_method = "cairo")
ggsave_euiss <- function(filename,
                         plot = ggplot2::last_plot(),
                         publication = c("book", "cp", "brief"),
                         w = NA,
                         h = 1,
                         units = "mm",
                         dev = NULL,
                         pdf_method = c("showtext", "cairo"),
                         embed_fonts = FALSE,
                         dpi = 300,
                         ...) {
  
  # ---------------------------------------------------------------------------
  # basic argument checks
  # ---------------------------------------------------------------------------
  
  if (!is.character(filename) || length(filename) != 1L) {
    stop("`filename` must be a single string (length-1 character vector).", call. = FALSE)
  }
  
  publication <- match.arg(publication)
  pdf_method <- match.arg(pdf_method)
  
  if (is.na(w)) {
    stop("`w` must be set to one of 'onecol', 'twocol', 'full', 'spread', etc.", call. = FALSE)
  }
  
  # infer extension
  ext <- tolower(tools::file_ext(filename))
  if (identical(ext, "")) {
    stop("`filename` must include a file extension, e.g. '.pdf' or '.svg'.", call. = FALSE)
  }
  
  # ---------------------------------------------------------------------------
  # output dimensions
  # ---------------------------------------------------------------------------
  
  mm_book <- tibble::tibble(
    dim = c("height", "onecol", "twocol", "full", "spread"),
    mm  = c(181.25, 60, 108, 135, 135 * 2)
  )
  
  mm_cp <- tibble::tibble(
    dim = c("height", "onecol", "twocol", "full", "spread"),
    mm  = c(221.9, 65.767, 140, 180, 180 * 2)
  )
  
  mm_brief <- tibble::tibble(
    dim = c("height", "onecol", "twocol", "full", "spread", "narrow"),
    mm  = c(258.233, 85, 180, 210, 210 * 2, 56.1)
  )
  
  if (publication == "book") {
    width_loc <- mm_book %>%
      dplyr::filter(.$dim == w) %>%
      dplyr::pull(2)
    
    height_loc <- mm_book %>%
      dplyr::filter(.$dim == "height") %>%
      dplyr::mutate(mm = .$mm * h) %>%
      dplyr::pull(2)
    
  } else if (publication == "cp") {
    width_loc <- mm_cp %>%
      dplyr::filter(.$dim == w) %>%
      dplyr::pull(2)
    
    height_loc <- mm_cp %>%
      dplyr::filter(.$dim == "height") %>%
      dplyr::mutate(mm = .$mm * h) %>%
      dplyr::pull(2)
    
  } else if (publication == "brief") {
    width_loc <- mm_brief %>%
      dplyr::filter(.$dim == w) %>%
      dplyr::pull(2)
    
    height_loc <- mm_brief %>%
      dplyr::filter(.$dim == "height") %>%
      dplyr::mutate(mm = .$mm * h) %>%
      dplyr::pull(2)
    
  } else {
    stop("No known publication format!", call. = FALSE)
  }
  
  if (length(width_loc) != 1L || length(height_loc) != 1L) {
    stop("Could not determine unique width/height. Check that `w` is valid for this publication.", call. = FALSE)
  }
  
  # Convert to inches for devices that need it
  width_in <- width_loc / 25.4
  height_in <- height_loc / 25.4
  
  # Get current font from package
  current_font <- get("txt_family", envir = .euiss_env, inherits = FALSE)
  
  # ---------------------------------------------------------------------------
  # export
  # ---------------------------------------------------------------------------
  
  message(
    paste0(
      "Exporting to ", ext, ": width = ", width_loc,
      ", height = ", height_loc, " mm"
    )
  )
  
  # -------------------------------------------------------------------------
  # PDF EXPORT - Two methods
  # -------------------------------------------------------------------------
  if (identical(ext, "pdf")) {
    
    if (pdf_method == "showtext") {
      # -----------------------------------------------------------------
      # SHOWTEXT METHOD (Default - Better for Illustrator)
      # -----------------------------------------------------------------
      
      if (!requireNamespace("showtext", quietly = TRUE) || 
          !requireNamespace("sysfonts", quietly = TRUE)) {
        warning(
          "Showtext method requires 'showtext' and 'sysfonts' packages.\n",
          "  Install with: install.packages(c('showtext', 'sysfonts'))\n",
          "  Falling back to cairo method.",
          call. = FALSE
        )
        pdf_method <- "cairo"
      } else {
        message("Using showtext method for PDF (better Illustrator compatibility)")
        
        # Enable showtext
        showtext::showtext_auto()
        showtext::showtext_opts(dpi = 300)
        
        # Register PT Sans Narrow from Google Fonts if not available
        existing <- sysfonts::font_families()
        
        font_to_use <- current_font
        
        # If package is using PT Sans variant, ensure it's available
        if (grepl("PT Sans", current_font, ignore.case = TRUE)) {
          if (!"PT Sans Narrow" %in% existing) {
            message("Adding PT Sans Narrow from Google Fonts...")
            tryCatch({
              sysfonts::font_add_google("PT Sans Narrow", "PT Sans Narrow")
              font_to_use <- "PT Sans Narrow"
            }, error = function(e) {
              warning("Could not add Google Font. Using package default.", call. = FALSE)
            })
          } else {
            font_to_use <- "PT Sans Narrow"
          }
          
          # Override plot theme to ensure font is used
          plot <- plot + ggplot2::theme(
            text = ggplot2::element_text(family = font_to_use)
          )
        }
        
        # Create PDF with showtext
        grDevices::cairo_pdf(
          filename = filename,
          width = width_in,
          height = height_in
        )
        
        print(plot)
        grDevices::dev.off()
        
        showtext::showtext_auto(FALSE)
        
        message("✓ PDF exported with showtext")
        message("  Font: ", font_to_use)
        message("  This should display correctly in Illustrator")
        
        return(invisible(filename))
      }
    }
    
    # -----------------------------------------------------------------
    # CAIRO METHOD (Fallback or explicit choice)
    # -----------------------------------------------------------------
    if (pdf_method == "cairo") {
      message("Using cairo_pdf method")
      
      # Validate font availability for PDF
      if (current_font != "sans" && requireNamespace("extrafont", quietly = TRUE)) {
        pdf_fonts <- try(extrafont::fonttable(), silent = TRUE)
        
        if (inherits(pdf_fonts, "try-error") || 
            !current_font %in% pdf_fonts$FamilyName) {
          message("Loading fonts for PDF device...")
          try(extrafont::loadfonts(device = "pdf", quiet = TRUE), silent = TRUE)
        }
      }
      
      # Use cairo_pdf device
      device <- grDevices::cairo_pdf
      
      # Export
      ggplot2::ggsave(
        filename    = filename,
        plot        = plot,
        width       = width_loc,
        height      = height_loc,
        units       = units,
        device      = device,
        useDingbats = FALSE,
        ...
      )
      
      message("✓ PDF exported with cairo_pdf")
      message("  Font: ", current_font)
      
      # Attempt to embed fonts if requested
      if (embed_fonts) {
        if (!requireNamespace("extrafont", quietly = TRUE)) {
          message("Note: extrafont package needed for font embedding. Skipping.")
        } else {
          gs_result <- tryCatch({
            extrafont::embed_fonts(filename, outfile = filename)
            "success"
          }, error = function(e) {
            if (grepl("GhostScript|ghostscript|gs", e$message, ignore.case = TRUE)) {
              message(
                "\nNote: GhostScript not found - fonts not embedded.\n",
                "  PDF will work in Illustrator if PT Sans is installed.\n",
                "  Only needed if sharing with users who lack PT Sans."
              )
              "no_ghostscript"
            } else {
              warning("Font embedding failed: ", e$message, call. = FALSE)
              "error"
            }
          })
          
          if (identical(gs_result, "success")) {
            message("✓ Fonts embedded successfully")
          }
        }
      } else {
        message("  Note: Fonts not embedded (embed_fonts = FALSE)")
        message("  If Illustrator shows Arial, try pdf_method = 'showtext'")
      }
    }
    
    # -------------------------------------------------------------------------
    # SVG EXPORT
    # -------------------------------------------------------------------------
  } else if (identical(ext, "svg")) {
    
    if (requireNamespace("svglite", quietly = TRUE)) {
      message("Using svglite for SVG export")
      
      svglite::svglite(
        filename = filename,
        width = width_in,
        height = height_in,
        ...
      )
      print(plot)
      grDevices::dev.off()
      
      message("✓ SVG exported with svglite (custom fonts supported)")
    } else {
      warning(
        "svglite package not found. Custom fonts may not work.\n",
        "  Install with: install.packages('svglite')\n",
        "  Falling back to grDevices::svg",
        call. = FALSE
      )
      
      ggplot2::ggsave(
        filename = filename,
        plot     = plot,
        width    = width_loc,
        height   = height_loc,
        units    = units,
        device   = grDevices::svg,
        ...
      )
    }
    
    # -------------------------------------------------------------------------
    # RASTER FORMATS (PNG, JPG, etc.)
    # -------------------------------------------------------------------------
  } else {
    
    message("Using standard ggsave for ", toupper(ext), " export")
    
    # Determine device
    if (!is.null(dev)) {
      device <- dev
    } else {
      device <- ext
    }
    
    ggplot2::ggsave(
      filename = filename,
      plot     = plot,
      width    = width_loc,
      height   = height_loc,
      units    = units,
      device   = device,
      dpi      = dpi,
      ...
    )
    
    message("✓ ", toupper(ext), " exported at ", dpi, " dpi")
  }
  
  invisible(filename)
}