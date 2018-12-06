library(rvest)
library(magrittr)
library(data.table)
library(progress)

rm(list = ls())

#set the parameter
keyword <- "APEC"
DateB <- 20170101
DateE <- 20180101
news <- "聯合報"
p <- 1 #擷取的頁數
t <- 10 #間隔秒數

#url
UDNsearch <- function(keyword, DateB, DateE, news, page = 1, sharepage = 50){
        
        root <- "http://udndata.com/ndapp/Searchdec?" #root
        
        paste(keyword, "+" , "日期", ">=", DateB, "+", "日期", "<=", 
              DateE, "+" , "報別", "=", news, sep="") %>% iconv(from = "UTF-8", to = "Big5") %>%
                URLencode() -> searchstring
        
        url <- paste(root, "&udndbid=udndata",  "&page=", page, "&SearchString=", 
                     searchstring, "&sharepage=", sharepage, "&select=0", "&kind=2",
                     "&showSearchString=", sep="")
        
        return(url)
        }

#crawler
UDNcrawler <- function(){
        #set locale to C
        Sys.setlocale(locale = "C")
        
        #progress bar
        pb <- progress_bar$new(
                format = "處理中 [:bar]:percent | 尚需: :eta | 費時: :elapsed", 
                total = p, clear = FALSE, width= 80, show_after = 0
        ) 
        
        start <- Sys.time() #紀錄開始時間
        
        #list
        title <- list()
        date <- list()
        
        #for.loop
        for(i in 1:p){
                url <- UDNsearch(keyword, DateB, DateE, news, page = i)
                doc <- read_html(url)
                html_nodes(doc, ".control-pic a") %>% html_text() -> title[[i]]
                html_nodes(doc, ".news span") %>% html_text() -> date[[i]]
                pb$tick()
                Sys.sleep(t)
        }
        
        #set locale to default UTF-8 (in MacOS or Linux)
        Sys.setlocale(locale = "UTF-8")
        
        #unlist
        title <- unlist(title)
        date <- unlist(date)
        
        #data.frame
        tstrsplit(date, "．") -> d1 #分割日期、報別、記者
        d1[[1]] %>% tstrsplit("-") -> d2 #分割年月日
        
        #dataframe 合併年、月、日、標題、報別、記者
        df <- cbind.data.frame(d2[[1]], d2[[2]], d2[[3]], title, d1[[2]], d1[[5]])
        
        #作keyword變數
        df$keyword <- keyword
        
        #variable names
        names(df) <- c("year", "month", "day", "title", "paper", "author", "keyword")
        
        #結束
        end <- Sys.time() #紀錄結束時間
        print(end - start) #輸出總花費時間
        
        return(df)
        }

#執行UDNcrawler 
df <- UDNcrawler()

#存檔
save(df, file = "~/Desktop/df.rda")

#關機
shutdown()
