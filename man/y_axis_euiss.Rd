% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/y_axis_euiss.R
\name{y_axis_euiss}
\alias{y_axis_euiss}
\title{Custom ggplot2::geom_vline()}
\usage{
y_axis_euiss(xintercept = 0, size = lwd_grid, col = col_grid, ...)
}
\arguments{
\item{xintercept}{position of y-axis. `default = 0`}

\item{size}{line width}

\item{col}{line color}

\item{...}{other arguments that can be passed to `ggplot2::geom_hline()`}
}
\value{
Pre-styled `geom_vline()` that inserts a grey y-axis at `x-intercept = 0`
}
\description{
Custom ggplot2::geom_vline()
}
\examples{
ggplot2::ggplot(data = mtcars, ggplot2::aes(disp, wt)) + 
  geom_point_euiss() + 
  y_axis_euiss()
}
