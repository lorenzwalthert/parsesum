#' Parse a file into a flat parse table
#'
#' @param path A path to an .R file.
parse_file <- function(path) {
  utils::getParseData(parse(path, keep.source = TRUE), includeText = TRUE) %>%
    as_tibble() %>%
    add_column(source = path)
}

#' @importFrom purrr flatten_dfr map invoke
parse_r <- function(root = ".") {
  file.path(root, "R") %>%
    parse_dir()
}

parse_tests <- function(root = ".") {
  file.path(root, "tests") %>%
    parse_dir()
}

parse_dir <- function(dir = ".", pattern = "\\.R$") {
  file_list <- dir %>%
    list.files(pattern = pattern, full.names = TRUE) %>%
    map(parse_file)

  invoke(rbind, file_list) %>%
    as_tibble()
}
