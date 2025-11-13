# Create package environment to store font settings
.euiss_env <- new.env(parent = emptyenv())

#' Initialize font settings if not already done
.init_fonts <- function() {
  if (!exists("txt_family", envir = .euiss_env, inherits = FALSE)) {
    library(extrafont)
    library(extrafontdb)
    library(Rttf2pt1)
    extrafont::loadfonts(quiet = TRUE, device = "win")
    
    assign("txt_family", "PT Sans Narrow", envir = .euiss_env)
    assign("txt_bold", "bold", envir = .euiss_env)
    assign("txt_height", 0.85, envir = .euiss_env)
    assign("txt_label", 2.66, envir = .euiss_env)
  }
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

#' Set fonts for eiussR package  
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
    extrafont::loadfonts(quiet = TRUE, device = "win")
    available_fonts <- fonts()
    if (!current$family %in% available_fonts) {
      warning(paste("Font", current$family, "not available. Using 'sans'."))
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

# Initialize with defaults when package loads
.onLoad <- function(libname, pkgname) {
  .init_fonts()
}
