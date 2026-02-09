#' Replace file extensions in ggsave/ggsave_euiss calls
#'
#' Scans R files and replaces file extensions within ggsave() and ggsave_euiss()
#' filename arguments. Useful for batch-converting output formats across scripts.
#'
#' @param path Directory to search. Default is current working directory.
#' @param from File extension to replace (e.g., ".png", ".pdf"). Include the dot.
#' @param to New file extension (e.g., ".jpg", ".svg"). Include the dot.
#' @param recursive Logical, whether to search subdirectories. Default FALSE.
#' @param dry_run Logical, if TRUE shows what would change without modifying files. Default TRUE.
#' @param pattern File pattern to match. Default is "\\.R$" for R scripts.
#'
#' @return Invisibly returns a list with modified files and change counts.
#' @export
#'
#' @examples
#' \dontrun{
#' # Preview changes (dry run - safe default)
#' euiss_replace_save_format(from = ".png", to = ".jpg")
#' 
#' # Actually make changes
#' euiss_replace_save_format(from = ".png", to = ".jpg", dry_run = FALSE)
#' 
#' # Search specific directory recursively
#' euiss_replace_save_format(
#'   path = "scripts/", 
#'   from = ".pdf", 
#'   to = ".svg", 
#'   recursive = TRUE,
#'   dry_run = FALSE
#' )
#' }
euiss_replace_save_format <- function(path = ".",
                                      from = ".png",
                                      to = ".jpg",
                                      recursive = FALSE,
                                      dry_run = TRUE,
                                      pattern = "\\.R$") {
  
  
  # Validate extensions
  if (!grepl("^\\.", from)) {
    from <- paste0(".", from)
    message("Added leading dot to 'from': ", from)
  }
  if (!grepl("^\\.", to)) {
    to <- paste0(".", to)
    message("Added leading dot to 'to': ", to)
  }
  
  # Escape dots for regex
  
  from_escaped <- gsub("\\.", "\\\\.", from)
  
  # Build regex pattern to match extensions inside ggsave/ggsave_euiss filename arguments
  
  # This targets: ggsave("file.ext" or ggsave_euiss("file.ext" or filename = "file.ext"
  # Handles both single and double quotes
  ggsave_pattern <- paste0(
    "(ggsave(?:_euiss)?\\s*\\([^)]*?",        # ggsave( or ggsave_euiss( with content
    "(?:filename\\s*=\\s*)?",                   # optional filename = 
    "[\"'])([^\"']*?)", from_escaped, "([\"'])" # quoted string ending with extension
  )
  
  # Find R files
  
  r_files <- list.files(
    path = path, 
    pattern = pattern, 
    full.names = TRUE, 
    recursive = recursive
  )
  
  if (length(r_files) == 0) {
    message("No R files found in: ", normalizePath(path))
    return(invisible(list(modified = character(0), total_changes = 0)))
  }
  
  message("Scanning ", length(r_files), " R file(s)...")
  if (dry_run) {
    message("DRY RUN - no files will be modified\n")
  }
  
  modified_files <- character(0)
  total_changes <- 0
  
  for (f in r_files) {
    txt <- readLines(f, warn = FALSE)
    txt_collapsed <- paste(txt, collapse = "\n")
    
    # Find all matches for reporting
    matches <- gregexpr(ggsave_pattern, txt_collapsed, perl = TRUE)
    n_matches <- sum(matches[[1]] > 0)
    
    if (n_matches > 0) {
      # Perform replacement
      txt_new_collapsed <- gsub(
        ggsave_pattern,
        paste0("\\1\\2", to, "\\3"),
        txt_collapsed,
        perl = TRUE
      )
      
      # Split back to lines
      txt_new <- strsplit(txt_new_collapsed, "\n", fixed = TRUE)[[1]]
      
      # Report changes
      message("\n", basename(f), ": ", n_matches, " change(s)")
      
      # Show specific changes (compare line by line)
      for (i in seq_along(txt)) {
        if (i <= length(txt_new) && txt[i] != txt_new[i]) {
          message("  Line ", i, ":")
          message("    - ", trimws(txt[i]))
          message("    + ", trimws(txt_new[i]))
        }
      }
      
      # Write changes if not dry run
      if (!dry_run) {
        writeLines(txt_new, f)
        message("  [UPDATED]")
      }
      
      modified_files <- c(modified_files, f)
      total_changes <- total_changes + n_matches
    }
  }
  
  # Summary
  message("\n", paste(rep("-", 40), collapse = ""))
  message("Summary: ", total_changes, " replacement(s) in ", 
          length(modified_files), " file(s)")
  
  if (dry_run && total_changes > 0) {
    message("\nTo apply changes, run with: dry_run = FALSE")
  }
  
  invisible(list(
    modified = modified_files,
    total_changes = total_changes,
    from = from,
    to = to
  ))
}