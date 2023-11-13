#' Custom ggplot2::ggsave()
#'
#' @param filename name of file, incl. sub-folders, excl. file extension
#' @param plot last plot
#' @param publication \code{character}, one of \code{book}, \code{brief} or \code{cp}  
#' @param w \code{character}, one of \code{onecol}, \code{twocol} or \code{full} for width 
#' @param h \code{numeric} fraction of full height 
#' @param units units of width and height, defaults to \code{mm}
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
                         ...) {
  
  # output dimensions
  mm_book <- tibble::tibble(dim = c("height", "onecol", "twocol", "full", "spread"),
                            mm = c(181.25, 60, 108, 135, 135*2))
  mm_cp <- tibble::tibble(dim = c("height", "onecol", "twocol", "full", "spread"),
                          mm = c(221.9, 65.767, 140, 180, 180*2))
  mm_brief <- tibble::tibble(dim = c("height", "onecol", "twocol", "full", "spread"),
                             mm = c(258.233, 85, 180, 210, 210*2))
  
  # infer device
  dev <- stringr::str_sub(filename, 
                          stringr::str_length(filename) - 2,
                          stringr::str_length(filename))
  
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
  } else { stop("No known publication format!") 
  }
  
  if (dev != "pdf") {
    message(paste0("Exporting to ", dev, ": width = ", width_loc, 
                   ", height ", height_loc, " mm"))
    ggplot2::ggsave(
      filename = filename,
      plot = plot,
      width = width_loc * 10,
      height = height_loc * 10,
      units = "px",
      device = dev,
      ...
    ) 
  } else if (dev == "pdf") {
    message(paste0("Exporting to ", dev, ": width = ", width_loc, 
                   ", height ", height_loc, " mm"))
    ggplot2::ggsave(
      filename = filename,
      plot = plot,
      width = width_loc,
      height = height_loc,
      units = units,
      device = dev,
      useDingbats = FALSE,
      ...
    )
  } else { stop("No known device!") 
  }
  # warning(paste0("Exporting to ", dev, " with a width of ", width_loc, 
  #                " and a height of ", height_loc, " mm."))
}