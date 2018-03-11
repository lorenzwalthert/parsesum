#' @importFrom dplyr lag lead nth
#' @importFrom purrr map2_int
ls_named_fun_decs_of_pd <- function(pd) {
  fun_decs <- token_is_fun_dec(pd)
  left_assign <- token_is_left_assign(pd)
  name_pos <- which(
    lead(left_assign, n = 2, default = FALSE) &
      lead(fun_decs, n = 4, default = FALSE)
  )
  parents <- pd$parent[name_pos + 2]
  source <- pd$source[name_pos + 2]
  n_lines <- map2_int(parents, source, n_lines_of_expr, pd = pd)

  pd[name_pos, ] %>%
    add_column(n_lines)
}

n_lines_of_expr <- function(id, source, pd) {
  target_expr <- which((pd$id == id) & (pd$source == source))
  pd$line2[target_expr] - pd$line1[target_expr] + 1L
}


#' What functions are delared?
#'
#' List all named function declarations in a package.
#' @param path A path to a root directory of a package
#' List all named function delcarations
#'
#' @details
#' Returns a tibble with:
#'
#' * the names of all named function declarations made under `R/` (column
#'   `text`).
#' * where exactly they are defined (column `source`).
#' * on what line they start (column `line1`).
#' * and many lines long they are (column `n_lines`).
#' @export
#' @importFrom dplyr select
#' @importFrom rlang .data
ls_fun_decs <- function(path = ".") {
  parse_r(path) %>%
    ls_named_fun_decs_of_pd() %>%
    select(.data$text, .data$n_lines, .data$source, .data$line1)
}

fetch_child <- function(pd, pos_of_child, pos_in_child, attribute) {
  pd[[pos_of_child]][pos_in_child, attribute]
}


#' Lista ll function calls in a source package
#'
#' @inheritParams ls_fun_decs
#' @export
ls_fun_calls <- function(path = ".") {
  parse_r(path) %>%
    ls_fun_calls_of_pd() %>%
    select(.data$text, .data$source, .data$line1)
}

#' @importFrom dplyr select
#' @importFrom rlang .data
ls_fun_calls_of_pd <- function(pd) {
  pd[token_is_fun_call(pd), ]
}
