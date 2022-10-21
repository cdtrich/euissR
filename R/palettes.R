#' \code{euissR} color palettes
#'
#' @name palettes
NULL
options(ggplot2.discrete.fill = pal_cat_euiss(6),
        # ggplot2.continuous.fill = pal_seq_vir_euiss(4),
        ggplot2.ordinal.fill = pal_seq_v_euiss(4),
        ggplot2.binned.fill = pal_cat_euiss(6), 
        ggplot2.discrete.colour = pal_cat_euiss(6),
        # ggplot2.continuous.colour = pal_seq_vir_euiss(4),
        ggplot2.ordinal.colour = pal_seq_v_euiss(4),
        ggplot2.binned.colour = pal_cat_euiss(6))