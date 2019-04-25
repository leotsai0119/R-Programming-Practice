library(rvest)
library(openssl)
library(progress)
library(tidyverse)
library(curl)
library(httr)

rm(list = ls())

# source web page
w <- read_html("https://dep.mohw.gov.tw/DOS/lp-2985-113.html")

#
dl_links <- w %>% 
        # extract nodes
        html_nodes("tr td a") %>% 
        # extract attritubes of elements
        html_attrs()

dates <- w %>% 
        html_nodes("tr td") %>% 
        # extract text
        html_text() %>% 
        # uploading dates, renew dates and downloading counts
        .[4:93]

file_names <- dates[seq(1, 86, by = 5)]
up_load <- dates[seq(2, 87, by = 5)]
renew <- dates[seq(3, 85, by = 5)]
dl_counts <- dates[seq(5, 90, by = 5)]
# dates, titles and urls
dl_book <- dl_links %>% 
        .[grep(".xls", .)] %>% 
        lapply(., strsplit, "\n") %>% 
        bind_rows() %>% .[ , -1]


curl_download(dl_list[1], "test.xls")
tmp
