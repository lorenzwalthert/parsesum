
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
#> # A tibble: 15 x 4
#>    text                    n_lines source        line1
#>    <chr>                     <int> <chr>         <int>
#>  1 ls_named_fun_decs_of_pd      14 ./R/analyse.R     3
#>  2 n_lines_of_expr               4 ./R/analyse.R    18
#>  3 ls_fun_decs                   5 ./R/analyse.R    41
#>  4 fetch_child                   3 ./R/analyse.R    47
#>  5 ls_fun_calls                  5 ./R/analyse.R    56
#>  6 ls_fun_calls_of_pd            9 ./R/analyse.R    64
#>  7 token_is_fun_dec              3 ./R/expr-is.R     1
#>  8 token_is_left_assign          3 ./R/expr-is.R     5
#>  9 set_na_to                     4 ./R/expr-is.R     9
#> 10 token_is_fun_call             3 ./R/expr-is.R    14
#> 11 token_is_namespace            3 ./R/expr-is.R    18
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
#> The following object is masked from 'package:testthat':
#> 
#>     matches
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
#> 2 ./R/expr-is.R     5
#> 3 ./R/parse.R       4
```

Or list according to longest name?

``` r
decs %>%
  mutate(nchar = nchar(.data$text)) %>%
  arrange(desc(.data$nchar))
#> # A tibble: 15 x 5
#>    text                    n_lines source        line1 nchar
#>    <chr>                     <int> <chr>         <int> <int>
#>  1 ls_named_fun_decs_of_pd      14 ./R/analyse.R     3    23
#>  2 token_is_left_assign          3 ./R/expr-is.R     5    20
#>  3 ls_fun_calls_of_pd            9 ./R/analyse.R    64    18
#>  4 token_is_namespace            3 ./R/expr-is.R    18    18
#>  5 token_is_fun_call             3 ./R/expr-is.R    14    17
#>  6 token_is_fun_dec              3 ./R/expr-is.R     1    16
#>  7 n_lines_of_expr               4 ./R/analyse.R    18    15
#>  8 ls_fun_calls                  5 ./R/analyse.R    56    12
#>  9 ls_fun_decs                   5 ./R/analyse.R    41    11
#> 10 fetch_child                   3 ./R/analyse.R    47    11
#> 11 parse_tests                   4 ./R/parse.R      16    11
#> 12 parse_file                    5 ./R/parse.R       4    10
#> 13 set_na_to                     4 ./R/expr-is.R     9     9
#> 14 parse_dir                     8 ./R/parse.R      21     9
#> 15 parse_r                       4 ./R/parse.R      11     7
```

Or wanna see the function that is the shortest in terms of lines used?

``` r
decs %>%
  arrange(.data$n_lines)
#> # A tibble: 15 x 4
#>    text                    n_lines source        line1
#>    <chr>                     <int> <chr>         <int>
#>  1 fetch_child                   3 ./R/analyse.R    47
#>  2 token_is_fun_dec              3 ./R/expr-is.R     1
#>  3 token_is_left_assign          3 ./R/expr-is.R     5
#>  4 token_is_fun_call             3 ./R/expr-is.R    14
#>  5 token_is_namespace            3 ./R/expr-is.R    18
#>  6 n_lines_of_expr               4 ./R/analyse.R    18
#>  7 set_na_to                     4 ./R/expr-is.R     9
#>  8 parse_r                       4 ./R/parse.R      11
#>  9 parse_tests                   4 ./R/parse.R      16
#> 10 ls_fun_decs                   5 ./R/analyse.R    41
#> 11 ls_fun_calls                  5 ./R/analyse.R    56
#> 12 parse_file                    5 ./R/parse.R       4
#> 13 parse_dir                     8 ./R/parse.R      21
#> 14 ls_fun_calls_of_pd            9 ./R/analyse.R    64
#> 15 ls_named_fun_decs_of_pd      14 ./R/analyse.R     3
```

## Working with function calls

How many function calls does your package contain?

``` r
calls <- ls_fun_calls() 

calls
#> # A tibble: 33 x 4
#>    text                 source        line1 namespace
#>    <chr>                <chr>         <int> <chr>    
#>  1 token_is_fun_dec     ./R/analyse.R     4 <NA>     
#>  2 getParseData         ./R/parse.R       5 utils    
#>  3 parse                ./R/parse.R       5 <NA>     
#>  4 token_is_left_assign ./R/analyse.R     5 <NA>     
#>  5 c                    ./R/expr-is.R     6 <NA>     
#>  6 which                ./R/analyse.R     6 <NA>     
#>  7 as_tibble            ./R/parse.R       6 <NA>     
#>  8 lead                 ./R/analyse.R     7 <NA>     
#>  9 add_column           ./R/parse.R       7 <NA>     
#> 10 lead                 ./R/analyse.R     8 <NA>     
#> # … with 23 more rows

calls %>%
  nrow()
#> [1] 33
```
