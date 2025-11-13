# Custom colors for euissR package
# These are defined as global variables to avoid R CMD check notes

utils::globalVariables(
  c(
    # basic
    col_grid <- "#C6C6C6",
    col_axis <- "#1D1D1B",
    col_axis_text <- "#646363",
    grey25 <- "#646363",
    
    # visual ID
    # cold
    teal <- "#00A0C1", # euiss_col1
    grey <- "#595959", # euiss_col2
    teal0 <- "#86baac",
    teal1 <- "#64c2c7",
    teal2 <- "#376882",
    teal3 <- "#1d3956",
    
    # warm
    egg <- "#ffde74",
    lightorange <- "#f9b466",
    orange <- "#f28d22",
    fuchsia1 <- "#ec5f5b",
    fuchsia2 <- "#df3144",
    fuchsia3 <- "#a41e26",
    mauve <- "#33163a",
    
    # green
    frog <- "#4cb748",
    mint <- "#99cb92"
  )
)
