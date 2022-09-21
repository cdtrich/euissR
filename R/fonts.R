#' Fonts import for \code{eiussR}
#'
#' @export
#' @return

# load system fonts
library(extrafont)
library(extrafontdb)
library(Rttf2pt1)
extrafont::loadfonts(quiet = TRUE, device = "win")

# text params
# txt_family <- "PTSans-Narrow"
# txt_family <- "PT Sans Narrow"

utils::globalVariables(
  c(
    txt_family <- "sans",
    txt_bold <- "bold",            # fontface
    txt_height <- 0.85,             # lineheight
    txt_label <- 2.66             # label size
  )
)