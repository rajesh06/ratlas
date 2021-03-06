#' Create an R Markdown Word Document Topic Guide
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard DLM topic guide word document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::word_document2]`
#'
#' @return A modified `word_document2` with the standard topic guide formatting.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::topicguide_docx
#' }
topicguide_docx <- function(...) {
  template <- find_resource("topicguide", "template.docx")
  base <- bookdown::word_document2(reference_docx = template, ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 8
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "png"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  # nolint end

  base
}


#' Create an R Markdown PDF Document Tech Report
#'
#' This is a function called in the output of the yaml of the Rmd file to
#' specify using the standard DLM tech report pdf document formatting.
#'
#' @param ... Arguments to be passed to `[bookdown::pdf_document2]`
#'
#' @return A modified `pdf_document2` with the standard tech report formatting.
#' @export
#'
#' @examples
#' \dontrun{
#'   output: ratlas::techreport_pdf
#' }
techreport_pdf <- function(...) {
  tech_report_template <- find_resource("techreport", "template.tex")
  base <- bookdown::pdf_document2(template = tech_report_template,
                                  latex_engine = "xelatex",
                                  citation_package = "biblatex",
                                  keep_tex = TRUE, ...)

  # nolint start
  base$knitr$opts_chunk$comment <- "#>"
  base$knitr$opts_chunk$message <- FALSE
  base$knitr$opts_chunk$warning <- FALSE
  base$knitr$opts_chunk$error <- FALSE
  base$knitr$opts_chunk$echo <- FALSE
  base$knitr$opts_chunk$cache <- FALSE
  base$knitr$opts_chunk$fig.width <- 8
  base$knitr$opts_chunk$fig.asp <- 0.618
  base$knitr$opts_chunk$fig.ext <- "pdf"
  base$knitr$opts_chunk$fig.align <- "center"
  base$knitr$opts_chunk$fig.retina <- 3
  base$knitr$opts_chunk$fig.path <- "figures/"
  base$knitr$opts_chunk$fig.pos <- "H"
  base$knitr$opts_chunk$out.extra <- ""
  base$knitr$opts_chunk$out.width <- "90%"
  base$knitr$opts_chunk$fig.show <- "hold"
  # nolint end

  base
}
