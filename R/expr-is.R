token_is_fun_dec <- function(pd) {
  pd$token == "FUNCTION"
}

token_is_left_assign <- function(pd) {
  pd$token %in% c("EQ_ASSIGN", "LEFT_ASSIGN")
}

set_na_to <- function(vec, default) {
  is_na <- is.na(vec)
  vec[is_na] <- default
}

token_is_fun_call <- function(pd) {
  pd$token == "SYMBOL_FUNCTION_CALL"
}

token_is_namespace <- function(pd) {
  pd$token == "SYMBOL_PACKAGE"
}
