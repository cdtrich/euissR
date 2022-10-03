#' Fonts import for \code{eiussR}
#'
#' @return sets global font \code{ggplot2} plots
#' 
#' @name fonts

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
    # txt_family <- "PT Sans Narrow", # font family
    txt_family <- "sans",         # font family
    txt_bold <- "bold",             # font face
    txt_height <- 0.85,             # line height
    txt_label <- 2.66               # text size
  )
)