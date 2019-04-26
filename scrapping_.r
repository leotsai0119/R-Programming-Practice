rm(list = ls())
l <- c("rvest", "openssl", "progress", 
       "tidyverse", "curl", "httr")
lapply(l, require, character.only = TRUE)
rm(l)

# source web page
w <- read_html("https://dep.mohw.gov.tw/DOS/lp-2985-113.html")

dl_links <- w %>% 
        # extract nodes
        html_nodes("tr td a") %>% 
        # extract all the attritubes of elements
        html_attrs()

# dates, titles and urls
dl_book <- dl_links %>% 
        # xls and xlsx formats
        .[grep(".xls", .)] %>% 
        # slice the string
        lapply(., strsplit, "\n") %>% 
        bind_rows() %>% .[ , -1]

# uploading dates, renew dates and downloading counts
dates <- w %>% 
        html_nodes("tr td") %>% 
        # extract text
        html_text() %>% 
        .[4:93]

# downloading date and file_names
formats <- dl_book$title %>% 
        strsplit("(", fixed = T) %>% 
        unlist()
dl_book$formats <- formats[c(seq(2, 41, by = 3), 45, 48, 51, 54)] %>% 
        strsplit(")", fixed = T) %>% 
        unlist() %>% 
        strsplit("檔案下載", fixed = T) %>% 
        unlist()
        

dl_book$file_names <- dates[seq(1, 86, by = 5)] %>% 
        paste(Sys.Date(), "-", "DL-", ., dl_book$formats, sep = "")

# upload
upload <- dates[seq(2, 87, by = 5)] %>%
        str_split("-") %>%
        unlist()
# upload year, month and day
dl_book$upload_y <- upload[seq(1, 52, by = 3)]
dl_book$upload_m <- upload[seq(2, 53, by = 3)]
dl_book$upload_d <- upload[seq(3, 54, by = 3)]

# renew
renew <- dates[seq(3, 88, by = 5)] %>% 
        str_split("-") %>% 
        unlist()
# renew year, month and day
dl_book$renew_y <- renew[seq(1, 52, by = 3)]
dl_book$renew_m <- renew[seq(2, 53, by = 3)]
dl_book$renew_d <- renew[seq(3, 54, by = 3)]
# downloading counts
dl_book$dl_counts <- dates[seq(5, 90, by = 5)]

nrow(dl_book)
curl_download("test.xls")

# pb
p <- nrow(dl_book)
t <- 3
pb <- progress_bar$new(
        format = "processing [:bar]:percent | :eta | :elapsed",
        total = p, clear = F, width = 80, show_after = 0
        )
download.path <- paste("~/Downloads/test/", dl_book$file_names, sep = "")
# for loop
for (i in 1:p) {
        a <- try(curl_download(dl_book$href[i], download.path[i], quiet = T))
        if(inherits(a, "try-error") == TRUE) next
        pb$tick()
        Sys.sleep(t)
}
