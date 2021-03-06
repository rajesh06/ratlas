#' Only If
#'
#' Adverb for conditionally skipping steps in a piped workflow.
#'
#' @param condition Logical condition to be evaluated
#' @examples
#' d <- tibble::as_tibble(mtcars)
#' d %>%
#'   only_if(TRUE)(dplyr::filter)(.data$mpg > 25)
#'
#' d %>%
#'   only_if(FALSE)(dplyr::filter)(.data$mpg > 25)
#' @author David Robinson, https://twitter.com/drob/status/785880369073500161
#' @export
only_if <- function(condition) {
  function(func) {
    if (condition) {
      func
    } else {
      function(., ...) .
    }
  }
}


#' Append row and/or column summaries
#'
#' Add row and/or column summaries (e.g., total counts) to a data frame.
#'
#' @param df A data frame to append summaries to.
#' @param row logical indicating whether a summary row should be added (i.e.,
#'   summarizing each column)
#' @param col logical indicating whether a summary column should be added (i.e.,
#'   summarizing each row)
#' @param .f Function to use for calculating summaries
#'
#' @return A data frame with the summary row and/or column appended
#' @export
#'
#' @examples
#' set.seed(9416)
#' df <- tibble::tibble(char = letters[1:5], x = rnorm(5), y = rnorm(5))
#' append_summary(df, row = TRUE, col = TRUE, .f = sum)
#' append_summary(df, row = FALSE, .f = mean)
append_summary <- function(df, row = TRUE, col = TRUE, .f = sum) {
  func_name <- as.character(substitute(.f))

  df %>%
    only_if(row)(dplyr::bind_rows)(
      dplyr::summarize_all(., ~ if (is.numeric(.)) .f(.) else NA)
    ) %>%
    only_if(col)(dplyr::bind_cols)(
      dplyr::select_if(., is.numeric) %>%
        tibble::rowid_to_column(var = "rowid") %>%
        tidyr::gather(key = "col_name", value = "value", -.data$rowid) %>%
        dplyr::rename(!!func_name := .data$value) %>%
        dplyr::select(-.data$col_name) %>%
        dplyr::group_by(.data$rowid) %>%
        dplyr::summarize_all(list(~ .f(.))) %>%
        dplyr::arrange(.data$rowid) %>%
        dplyr::select(-.data$rowid)
    )
}
