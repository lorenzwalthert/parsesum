
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

*This is highly expermantal*

# parsesum

parsesum provides tools to analyze source code. To this end, it
leverages the R base parser.

## Working with function delcarations

For example, did you want to know how many functions you declared in
your R package? Here is how you can get the names of all your named
delared functions, enriched with some useful information, for example
how many line each function declaration spans.

``` r
library(parsesum)
decs <- ls_fun_decs(".")
decs
#> # A tibble: 14 x 4
#>    text                    n_lines source        line1
#>    <chr>                     <int> <chr>         <int>
#>  1 ls_named_fun_decs_of_pd      14 ./R/analyse.R     3
#>  2 n_lines_of_expr               4 ./R/analyse.R    18
#>  3 ls_fun_decs                   5 ./R/analyse.R    41
#>  4 fetch_child                   3 ./R/analyse.R    47
#>  5 ls_fun_calls                  5 ./R/analyse.R    56
#>  6 ls_fun_calls_of_pd            3 ./R/analyse.R    64
#>  7 token_is_fun_dec              3 ./R/expr-is.R     1
#>  8 token_is_left_assign          3 ./R/expr-is.R     5
#>  9 set_na_to                     4 ./R/expr-is.R     9
#> 10 token_is_fun_call             3 ./R/expr-is.R    14
#> 11 parse_file                    5 ./R/parse.R       4
#> 12 parse_r                       4 ./R/parse.R      11
#> 13 parse_tests                   4 ./R/parse.R      16
#> 14 parse_dir                     8 ./R/parse.R      21
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
decs %>%
  group_by(.data$source) %>%
  count() %>%
  arrange(desc(n))
#> # A tibble: 3 x 2
#> # Groups:   source [3]
#>   source            n
#>   <chr>         <int>
#> 1 ./R/analyse.R     6
#> 2 ./R/expr-is.R     4
#> 3 ./R/parse.R       4
```

Or list according to longest name?

``` r
decs %>%
  mutate(nchar = nchar(.data$text)) %>%
  arrange(desc(.data$nchar))
#> # A tibble: 14 x 5
#>    text                    n_lines source        line1 nchar
#>    <chr>                     <int> <chr>         <int> <int>
#>  1 ls_named_fun_decs_of_pd      14 ./R/analyse.R     3    23
#>  2 token_is_left_assign          3 ./R/expr-is.R     5    20
#>  3 ls_fun_calls_of_pd            3 ./R/analyse.R    64    18
#>  4 token_is_fun_call             3 ./R/expr-is.R    14    17
#>  5 token_is_fun_dec              3 ./R/expr-is.R     1    16
#>  6 n_lines_of_expr               4 ./R/analyse.R    18    15
#>  7 ls_fun_calls                  5 ./R/analyse.R    56    12
#>  8 ls_fun_decs                   5 ./R/analyse.R    41    11
#>  9 fetch_child                   3 ./R/analyse.R    47    11
#> 10 parse_tests                   4 ./R/parse.R      16    11
#> 11 parse_file                    5 ./R/parse.R       4    10
#> 12 set_na_to                     4 ./R/expr-is.R     9     9
#> 13 parse_dir                     8 ./R/parse.R      21     9
#> 14 parse_r                       4 ./R/parse.R      11     7
```

Or wanna see the function that is the shortest in terms of lines used?

``` r
decs %>%
  arrange(.data$n_lines)
#> # A tibble: 14 x 4
#>    text                    n_lines source        line1
#>    <chr>                     <int> <chr>         <int>
#>  1 fetch_child                   3 ./R/analyse.R    47
#>  2 ls_fun_calls_of_pd            3 ./R/analyse.R    64
#>  3 token_is_fun_dec              3 ./R/expr-is.R     1
#>  4 token_is_left_assign          3 ./R/expr-is.R     5
#>  5 token_is_fun_call             3 ./R/expr-is.R    14
#>  6 n_lines_of_expr               4 ./R/analyse.R    18
#>  7 set_na_to                     4 ./R/expr-is.R     9
#>  8 parse_r                       4 ./R/parse.R      11
#>  9 parse_tests                   4 ./R/parse.R      16
#> 10 ls_fun_decs                   5 ./R/analyse.R    41
#> 11 ls_fun_calls                  5 ./R/analyse.R    56
#> 12 parse_file                    5 ./R/parse.R       4
#> 13 parse_dir                     8 ./R/parse.R      21
#> 14 ls_named_fun_decs_of_pd      14 ./R/analyse.R     3
```

## Working with function calls

How many function calls does your package contain?

``` r
calls <- ls_fun_calls() 

calls
#> # A tibble: 29 x 3
#>    text                    source        line1
#>    <chr>                   <chr>         <int>
#>  1 token_is_fun_dec        ./R/analyse.R     4
#>  2 token_is_left_assign    ./R/analyse.R     5
#>  3 which                   ./R/analyse.R     6
#>  4 lead                    ./R/analyse.R     7
#>  5 lead                    ./R/analyse.R     8
#>  6 map2_int                ./R/analyse.R    12
#>  7 add_column              ./R/analyse.R    15
#>  8 which                   ./R/analyse.R    19
#>  9 parse_r                 ./R/analyse.R    42
#> 10 ls_named_fun_decs_of_pd ./R/analyse.R    43
#> # ... with 19 more rows

calls %>%
  nrow()
#> [1] 29
```
