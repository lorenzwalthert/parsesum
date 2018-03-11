
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
*This is highly expermantal*

# parsesum

parsesum provides tools to analyze source code. To this end, it
leverages the R base parser.

## Example

For example, did you want to know how many functions you declared in
your R package? Here is how you can get the names of all your named
delared functions, enriched with some useful information, for example
how many line each function declaration spans.

``` r
library(parsesum)
fun_decs <- ls_fun_decs(".")
fun_decs
#> # A tibble: 15 x 4
#>    text                    n_lines source        line1
#>    <chr>                     <int> <chr>         <int>
#>  1 ls_named_fun_decs_of_pd      15 ./R/analyse.R     3
#>  2 n_lines_of_expr               4 ./R/analyse.R    19
#>  3 ls_fun_decs                   4 ./R/analyse.R    40
#>  4 fetch_child                   3 ./R/analyse.R    45
#>  5 select_for_ui                 4 ./R/analyse.R    51
#>  6 ls_fun_calls                  4 ./R/analyse.R    60
#>  7 ls_fun_calls_of_pd            3 ./R/analyse.R    65
#>  8 token_is_fun_dec              3 ./R/expr-is.R     1
#>  9 token_is_left_assign          3 ./R/expr-is.R     5
#> 10 set_na_to                     4 ./R/expr-is.R     9
#> 11 token_is_fun_call             3 ./R/expr-is.R    14
#> 12 parse_file                    5 ./R/parse.R       4
#> 13 parse_r                       4 ./R/parse.R      11
#> 14 parse_tests                   4 ./R/parse.R      16
#> 15 parse_dir                     8 ./R/parse.R      21
```

Wanna know which file contains most delcarations?

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
fun_decs %>%
  group_by(.data$source) %>%
  count() %>%
  arrange(desc(n))
#> # A tibble: 3 x 2
#> # Groups:   source [3]
#>   source            n
#>   <chr>         <int>
#> 1 ./R/analyse.R     7
#> 2 ./R/expr-is.R     4
#> 3 ./R/parse.R       4
```

Or list according to longest name?

``` r
fun_decs %>%
  mutate(nchar = nchar(.data$text)) %>%
  arrange(desc(.data$nchar))
#> # A tibble: 15 x 5
#>    text                    n_lines source        line1 nchar
#>    <chr>                     <int> <chr>         <int> <int>
#>  1 ls_named_fun_decs_of_pd      15 ./R/analyse.R     3    23
#>  2 token_is_left_assign          3 ./R/expr-is.R     5    20
#>  3 ls_fun_calls_of_pd            3 ./R/analyse.R    65    18
#>  4 token_is_fun_call             3 ./R/expr-is.R    14    17
#>  5 token_is_fun_dec              3 ./R/expr-is.R     1    16
#>  6 n_lines_of_expr               4 ./R/analyse.R    19    15
#>  7 select_for_ui                 4 ./R/analyse.R    51    13
#>  8 ls_fun_calls                  4 ./R/analyse.R    60    12
#>  9 ls_fun_decs                   4 ./R/analyse.R    40    11
#> 10 fetch_child                   3 ./R/analyse.R    45    11
#> 11 parse_tests                   4 ./R/parse.R      16    11
#> 12 parse_file                    5 ./R/parse.R       4    10
#> 13 set_na_to                     4 ./R/expr-is.R     9     9
#> 14 parse_dir                     8 ./R/parse.R      21     9
#> 15 parse_r                       4 ./R/parse.R      11     7
```

Or wanna see the function that is the shortest in terms of lines used?

``` r
fun_decs %>%
  arrange(.data$n_lines)
#> # A tibble: 15 x 4
#>    text                    n_lines source        line1
#>    <chr>                     <int> <chr>         <int>
#>  1 fetch_child                   3 ./R/analyse.R    45
#>  2 ls_fun_calls_of_pd            3 ./R/analyse.R    65
#>  3 token_is_fun_dec              3 ./R/expr-is.R     1
#>  4 token_is_left_assign          3 ./R/expr-is.R     5
#>  5 token_is_fun_call             3 ./R/expr-is.R    14
#>  6 n_lines_of_expr               4 ./R/analyse.R    19
#>  7 ls_fun_decs                   4 ./R/analyse.R    40
#>  8 select_for_ui                 4 ./R/analyse.R    51
#>  9 ls_fun_calls                  4 ./R/analyse.R    60
#> 10 set_na_to                     4 ./R/expr-is.R     9
#> 11 parse_r                       4 ./R/parse.R      11
#> 12 parse_tests                   4 ./R/parse.R      16
#> 13 parse_file                    5 ./R/parse.R       4
#> 14 parse_dir                     8 ./R/parse.R      21
#> 15 ls_named_fun_decs_of_pd      15 ./R/analyse.R     3
```
