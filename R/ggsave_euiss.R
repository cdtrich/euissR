#' Custom ggplot2::ggsave()
#'
#' @param filename name of file, incl. sub-folders, *incl. file extension*
#' @param plot last plot
#' @param publication \code{character}, one of \code{book}, \code{brief} or \code{cp}  
#' @param w \code{character}, one of \code{onecol}, \code{twocol} or \code{full} for width 
#' @param h \code{numeric} fraction of full height 
#' @param units units of width and height, defaults to \code{mm}
#' @param dev optional explicit device (e.g. \code{svglite::svglite}); otherwise inferred
#' @param ... other arguments that can be passed to \code{ggplot2::ggsave()}
#'
#' @return Parametrized \code{ggsave()}
#' @importFrom magrittr %>%
#' @export
#' 
#' @examples 
#' ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt, label = wt)) + 
#'   geom_text_euiss() +
#'   geom_line_euiss() 
#'   # NOT RUN 
#'   # ggsave_euiss("test.pdf", publication = "cp", w = "onecol", h = 1)
#'   # END NOT RUN 
ggsave_euiss <- function(filename,
                         plot = ggplot2::last_plot(),
                         publication = c("book", "cp", "brief"),
                         w = NA,
                         h = 1,
                         units = "mm",
                         dev = NULL,
                         ...) {
  
  # ---------------------------------------------------------------------------
  # basic argument checks
  # ---------------------------------------------------------------------------
  
  if (!is.character(filename) || length(filename) != 1L) {
    stop("`filename` must be a single string (length-1 character vector).", call. = FALSE)
  }
  
  publication <- match.arg(publication)
  
  if (is.na(w)) {
    stop("`w` must be set to one of 'onecol', 'twocol', 'full', 'spread', etc.", call. = FALSE)
  }
  
  # infer extension (used mainly to distinguish pdf vs non-pdf)
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
  
  # ---------------------------------------------------------------------------
  # device selection
  # ---------------------------------------------------------------------------
  # priority:
  # 1) use explicit `dev` if provided
  # 2) else: svg -> svglite::svglite; pdf -> cairo_pdf; otherwise pass extension to ggsave
  
  if (!is.null(dev)) {
    device <- dev
  } else if (identical(ext, "svg")) {
    device <- svglite::svglite
  } else if (identical(ext, "pdf")) {
    device <- grDevices::cairo_pdf
  } else {
    device <- ext
  }
  
  # ---------------------------------------------------------------------------
  # export
  # ---------------------------------------------------------------------------
  
  if (!identical(ext, "pdf")) {
    
    message(
      paste0(
        "Exporting to ", ext, ": width = ", width_loc,
        ", height ", height_loc, " mm"
      )
    )
    
    ggplot2::ggsave(
      filename = filename,
      plot     = plot,
      width    = width_loc * 10,   # convert mm -> px approximation (for Illustrator fine-tuning)
      height   = height_loc * 10,
      units    = "px",
      device   = device,
      ...
    )
    
  } else {
    
    message(
      paste0(
        "Exporting to ", ext, ": width = ", width_loc,
        ", height ", height_loc, " mm"
      )
    )
    
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
  }
}
