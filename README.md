
<!-- README.md is generated from README.Rmd. Please edit that file -->

# euissR

<!-- badges: start -->
<!-- badges: end -->

The goal of euissR is to make plotting coherent with the EUISS's visual identity
in ggplot2 less verbose. It provides functions for various pre-styled ggplot2 
geoms, enhanced color palettes, utility functions, and streamlined workflows for more efficient plotting with ggplot2 in R.

euissR comes with a custom ggplot2 theme that is automatically set as default
when loading the package, along with enhanced font handling and comprehensive color management.

## Features

- **Custom ggplot2 theme** with EUISS visual identity
- **Pre-styled geoms** for consistent plotting
- **Enhanced color palettes** with light variants and specialized palettes
- **Automatic font management** with PT Sans/PT Sans Narrow support
- **Utility functions** for common data analysis workflows
- **Publication dimensions** for EUISS reports, briefs, and books
- **Automatic package loading** for streamlined setup

## Installation

You can install the development version of euissR from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("cdtrich/euissR")
```

## Quick Start

```r
library(euissR)
# Package automatically:
# - Sets theme_euiss() as default
# - Configures colors and fonts
# - Reports font status

# Optional: Load common packages for analysis
euiss_load_packages()  # loads dplyr, ggplot2, readr, etc.

# Create plots with enhanced styling
mtcars %>% 
  ggplot(aes(wt, mpg)) +
  geom_point_euiss() +
  geom_text_euiss(aes(label = row.names(mtcars)))
```

## Enhanced Features

### Color Palettes

```r
# Enhanced categorical palette
ggplot(mtcars, aes(wt, mpg, col = factor(cyl))) + 
  geom_point() + 
  scale_color_manual(values = pal_cat_euiss_enhanced(3))

# Light sequential palettes
ggplot(mtcars, aes(wt, mpg, col = hp)) + 
  geom_point() + 
  scale_color_gradientn(colors = pal_seq_r_light_euiss(4))

# Specialized bathymetry palette
ggplot(mtcars, aes(wt, mpg, col = disp)) + 
  geom_point() + 
  scale_color_gradientn(colors = pal_seq_bathy_euiss(6))
```

### Publication Dimensions

```r
# Get dimensions for different publication types
cp_dims <- euiss_get_dimensions("cp")
book_dims <- euiss_get_dimensions("book")  
brief_dims <- euiss_get_dimensions("brief")

# Use with ggsave_euiss or ggplot2::ggsave
ggsave("plot.pdf", 
       width = cp_dims$onecol, 
       height = cp_dims$height * 0.6, 
       units = "mm")
```

### Utility Functions

```r
# Minimal margins (like mar0 in style scripts)
ggplot(mtcars, aes(wt, mpg)) + 
  geom_point_euiss() + 
  euiss_mar0()

# Enhanced color scales
ggplot(mtcars, aes(wt, mpg, col = hp)) + 
  geom_point() + 
  euiss_color_continuous()
```

## Fonts

euissR automatically manages fonts with the following priority:
1. **PT Sans** (preferred, from Google Fonts)
2. **PT Sans Narrow** (fallback)  
3. **Sans** (system default)

The package will attempt to import PT fonts from common system locations and provide informative messages about font availability.

To install PT Sans:
- Download from [Google Fonts](https://fonts.google.com/specimen/PT+Sans)
- Or use: `extrafont::font_import(pattern = "PT")`

## Available Geoms

All geoms are pre-styled with EUISS visual identity:

- `geom_point_euiss()` - Styled points
- `geom_line_euiss()` - Styled lines  
- `geom_text_euiss()` - Styled text with proper colors
- `geom_col_euiss()` - Styled columns
- `geom_area_euiss()` - Styled areas
- `geom_linerange_x_euiss()` / `geom_linerange_y_euiss()` - Styled ranges

## Color Palettes

### Basic Palettes
- `pal_cat_euiss()` - Categorical colors
- `pal_div_euiss()` - Diverging colors
- `pal_seq_b_euiss()`, `pal_seq_g_euiss()`, `pal_seq_r_euiss()` - Sequential colors
- `pal_seq_v_euiss()`, `pal_seq_vir_euiss()` - Specialized sequential

### Enhanced Palettes  
- `pal_cat_euiss_enhanced()` - Enhanced categorical
- `pal_seq_r_light_euiss()` - Light red sequential
- `pal_seq_g_light_euiss()` - Light green sequential
- `pal_seq_b_light_euiss()` - Light blue sequential
- `pal_seq_bathy_euiss()` - Bathymetry/depth visualization

## Themes

- `theme_euiss()` - Main EUISS theme (set automatically)
- `theme_euiss_ticks()` - Version with axis ticks
- `theme_euiss_mar0()` - Version with custom margins
- `euiss_mar0()` - Minimal margin utility

## Chart Functions

- `chart_col_horizontal()` - Complete horizontal column chart
- `chart_line()` - Complete line chart with labels

## Publication Tools

- `ggsave_euiss()` - Enhanced save function with publication presets
- `euiss_get_dimensions()` - Get standard publication dimensions

## Package Integration

The package now integrates functionality similar to style_v8.R:

- Automatic theme and color setup
- Optional package loading with `euiss_load_packages()`
- Enhanced font management
- Publication dimension management
- Utility functions for common workflows

## Development

To regenerate documentation:
```r
roxygen2::roxygenise()
```

To render README:
```r
devtools::build_readme()
```

## Version History

- **0.1.2**: Enhanced integration with style script functionality, improved font handling, additional color palettes, utility functions
- **0.1.1**: Initial stable release
- **0.1.0**: Initial development version
