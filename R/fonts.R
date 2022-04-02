#' euissR fonts import 
#'
#' @export
library(showtext)
sysfonts::font_add_google(name = "PT Sans Narrow", 
                          family = "ptsansnarrow",
                          db_cache = TRUE)
showtext::showtext_auto()