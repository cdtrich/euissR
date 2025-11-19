#' Access EUISS Colors with Variants
#'
#' @name euiss_color_functions
#' @return Hex color code as character string
#'
#' @examples
#' # Basic colors
#' euiss_teal()           # Base teal: #309ebe
#' euiss_teal(0)          # Variant 0: #64C2C7
#' euiss_teal(1)          # Variant 1: #64c2c7
#' euiss_teal(2)          # Variant 2: #376882
#' euiss_teal(3)          # Variant 3: #1d3956
#' 
#' # Use in plots
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg)) +
#'   geom_point(color = euiss_teal()) +
#'   geom_smooth(color = euiss_fuchsia(1))
NULL

#' @rdname euiss_color_functions
#' @param variant Numeric variant (0, 1, 2, 3, etc.) or NULL for base color
#' @export
euiss_teal <- function(variant = NULL) {
  if (is.null(variant)) {
    return(get("teal", envir = .euiss_env, inherits = FALSE))
  }
  
  # Handle numeric variants including decimals
  var_name <- paste0("teal", variant)
  
  tryCatch({
    get(var_name, envir = .euiss_env, inherits = FALSE)
  }, error = function(e) {
    available <- c("0", "1", "1.1", "1.2", "2", "2.1", "3")
    stop("Teal variant '", variant, "' not found. Available variants: ", 
         paste(available, collapse = ", "), call. = FALSE)
  })
}

#' @rdname euiss_color_functions
#' @export
euiss_fuchsia <- function(variant = NULL) {
  if (is.null(variant)) {
    # Base fuchsia is fuchsia2
    return(get("fuchsia2", envir = .euiss_env, inherits = FALSE))
  }
  
  var_name <- paste0("fuchsia", variant)
  
  tryCatch({
    get(var_name, envir = .euiss_env, inherits = FALSE)
  }, error = function(e) {
    available <- c("1", "1.0", "3")
    stop("Fuchsia variant '", variant, "' not found. Available variants: ", 
         paste(available, collapse = ", "), "\nNote: base fuchsia is variant 2", 
         call. = FALSE)
  })
}

#' @rdname euiss_color_functions
#' @export
euiss_egg <- function(variant = NULL) {
  if (is.null(variant)) {
    return(get("egg", envir = .euiss_env, inherits = FALSE))
  }
  
  var_name <- paste0("egg", variant)
  
  tryCatch({
    get(var_name, envir = .euiss_env, inherits = FALSE)
  }, error = function(e) {
    available <- c("0")
    stop("Egg variant '", variant, "' not found. Available variants: ", 
         paste(available, collapse = ", "), call. = FALSE)
  })
}

#' @rdname euiss_color_functions
#' @export
euiss_mauve <- function(variant = NULL) {
  if (is.null(variant)) {
    return(get("mauve", envir = .euiss_env, inherits = FALSE))
  }
  
  var_name <- paste0("mauve", variant)
  
  tryCatch({
    get(var_name, envir = .euiss_env, inherits = FALSE)
  }, error = function(e) {
    available <- c("1")
    stop("Mauve variant '", variant, "' not found. Available variants: ", 
         paste(available, collapse = ", "), call. = FALSE)
  })
}

#' @rdname euiss_color_functions
#' @export
euiss_orange <- function() {
  get("orange", envir = .euiss_env, inherits = FALSE)
}

#' @rdname euiss_color_functions
#' @export
euiss_lightorange <- function() {
  get("lightorange", envir = .euiss_env, inherits = FALSE)
}

#' @rdname euiss_color_functions
#' @export
euiss_blue <- function() {
  get("blue", envir = .euiss_env, inherits = FALSE)
}

#' @rdname euiss_color_functions
#' @export
euiss_grey <- function() {
  get("grey", envir = .euiss_env, inherits = FALSE)
}

#' @rdname euiss_color_functions
#' @export
euiss_frog <- function() {
  get("frog", envir = .euiss_env, inherits = FALSE)
}

#' @rdname euiss_color_functions
#' @export
euiss_mint <- function() {
  get("mint", envir = .euiss_env, inherits = FALSE)
}

#' Get EUISS grid/axis colors
#' @rdname euiss_color_functions
#' @export
euiss_col_grid <- function(variant = NULL) {
  if (is.null(variant)) {
    return(get("col_grid", envir = .euiss_env, inherits = FALSE))
  }
  
  var_name <- paste0("col_grid", variant)
  
  tryCatch({
    get(var_name, envir = .euiss_env, inherits = FALSE)
  }, error = function(e) {
    available <- c("0")
    stop("Grid color variant '", variant, "' not found. Available variants: ", 
         paste(available, collapse = ", "), call. = FALSE)
  })
}

#' @rdname euiss_color_functions
#' @export
euiss_col_axis <- function() {
  get("col_axis", envir = .euiss_env, inherits = FALSE)
}

#' @rdname euiss_color_functions
#' @export
euiss_col_axis_text <- function() {
  get("col_axis_text", envir = .euiss_env, inherits = FALSE)
}

#' @rdname euiss_color_functions
#' @export
euiss_grey25 <- function() {
  get("grey25", envir = .euiss_env, inherits = FALSE)
}

#' Get all EUISS colors as a named list
#'
#' Returns all available EUISS colors organized by category.
#'
#' @param category Character: "all", "basic", "cold", "warm", "green", or NULL for structured list
#' @return Named character vector of hex colors, or nested list if category is NULL
#' @export
#'
#' @examples
#' # Get all colors as flat vector
#' all_colors <- euiss_colors("all")
#' 
#' # Get structured list by category
#' color_list <- euiss_colors()
#' color_list$cold
#' color_list$warm
#' 
#' # Get specific category
#' cold_colors <- euiss_colors("cold")
euiss_colors <- function(category = NULL) {
  
  # Build comprehensive color list
  colors <- list(
    basic = c(
      col_grid = get("col_grid", envir = .euiss_env, inherits = FALSE),
      col_grid0 = get("col_grid0", envir = .euiss_env, inherits = FALSE),
      col_axis = get("col_axis", envir = .euiss_env, inherits = FALSE),
      col_axis_text = get("col_axis_text", envir = .euiss_env, inherits = FALSE),
      grey25 = get("grey25", envir = .euiss_env, inherits = FALSE)
    ),
    cold = c(
      blue = get("blue", envir = .euiss_env, inherits = FALSE),
      teal = get("teal", envir = .euiss_env, inherits = FALSE),
      grey = get("grey", envir = .euiss_env, inherits = FALSE),
      teal0 = get("teal0", envir = .euiss_env, inherits = FALSE),
      teal1 = get("teal1", envir = .euiss_env, inherits = FALSE),
      teal1.1 = get("teal1.1", envir = .euiss_env, inherits = FALSE),
      teal1.2 = get("teal1.2", envir = .euiss_env, inherits = FALSE),
      teal2 = get("teal2", envir = .euiss_env, inherits = FALSE),
      teal2.1 = get("teal2.1", envir = .euiss_env, inherits = FALSE),
      teal3 = get("teal3", envir = .euiss_env, inherits = FALSE)
    ),
    warm = c(
      egg = get("egg", envir = .euiss_env, inherits = FALSE),
      egg0 = get("egg0", envir = .euiss_env, inherits = FALSE),
      lightorange = get("lightorange", envir = .euiss_env, inherits = FALSE),
      orange = get("orange", envir = .euiss_env, inherits = FALSE),
      fuchsia1 = get("fuchsia1", envir = .euiss_env, inherits = FALSE),
      fuchsia1.0 = get("fuchsia1.0", envir = .euiss_env, inherits = FALSE),
      fuchsia2 = get("fuchsia2", envir = .euiss_env, inherits = FALSE),
      fuchsia3 = get("fuchsia3", envir = .euiss_env, inherits = FALSE),
      mauve = get("mauve", envir = .euiss_env, inherits = FALSE),
      mauve1 = get("mauve1", envir = .euiss_env, inherits = FALSE)
    ),
    green = c(
      frog = get("frog", envir = .euiss_env, inherits = FALSE),
      mint = get("mint", envir = .euiss_env, inherits = FALSE)
    )
  )
  
  if (is.null(category)) {
    return(colors)
  }
  
  if (category == "all") {
    return(unlist(colors))
  }
  
  if (category %in% names(colors)) {
    return(colors[[category]])
  }
  
  stop("Unknown category '", category, "'. Use: all, basic, cold, warm, green, or NULL", 
       call. = FALSE)
}

#' Display EUISS color palette
#'
#' @param plot Logical, whether to create a visual plot
#' @param category Character: "all", "basic", "cold", "warm", "green"
#' @return Invisibly returns color list
#' @export
#'
#' @examples
#' # Print colors
#' euiss_show_colors()
#' 
#' # Visual plot
#' euiss_show_colors(plot = TRUE)
#' euiss_show_colors(plot = TRUE, category = "warm")
euiss_show_colors <- function(plot = FALSE, category = "all") {
  
  if (category == "all") {
    colors <- euiss_colors("all")
  } else {
    colors <- euiss_colors(category)
  }
  
  if (!plot) {
    cat("EUISS Colors (", category, "):\n\n", sep = "")
    cat(sprintf("  %-20s %s\n", "Name", "Hex"))
    cat(sprintf("  %-20s %s\n", paste(rep("-", 20), collapse = ""), 
                paste(rep("-", 7), collapse = "")))
    for (i in seq_along(colors)) {
      cat(sprintf("  %-20s %s\n", names(colors)[i], colors[i]))
    }
    cat("\nAccess colors with:\n")
    cat("  euiss_teal()      euiss_teal(1)      euiss_teal(2)\n")
    cat("  euiss_fuchsia()   euiss_fuchsia(1)   euiss_fuchsia(3)\n")
    cat("  euiss_egg()       euiss_mauve()      euiss_orange()\n")
    cat("  euiss_colors('cold')  euiss_colors('warm')\n")
    return(invisible(colors))
  }
  
  # Create visual plot
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    message("ggplot2 required for plots. Showing text instead:")
    return(euiss_show_colors(plot = FALSE, category = category))
  }
  
  color_df <- data.frame(
    name = names(colors),
    hex = unname(colors),
    x = 1,
    y = rev(seq_along(colors)),  # Reverse so first color is on top
    stringsAsFactors = FALSE
  )
  
  p <- ggplot2::ggplot(color_df, ggplot2::aes(x = x, y = y, fill = hex)) +
    ggplot2::geom_tile(width = 0.9, height = 0.9, color = "white", linewidth = 2) +
    ggplot2::geom_text(ggplot2::aes(label = name), x = 0.3, hjust = 1, 
                       size = 3.5, fontface = "bold") +
    ggplot2::geom_text(ggplot2::aes(label = hex), x = 1.7, hjust = 0,
                       size = 3, family = "mono") +
    ggplot2::scale_fill_identity() +
    ggplot2::xlim(0, 2.5) +
    ggplot2::labs(title = paste("EUISS Color Palette:", category)) +
    ggplot2::theme_void() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5, face = "bold", size = 16,
                                         margin = ggplot2::margin(10, 0, 10, 0)),
      plot.margin = ggplot2::margin(10, 10, 10, 10)
    )
  
  print(p)
  invisible(colors)
}
