library(xml2)
library(XML)
library(magrittr)
library(data.table)
library(progress)
library(fun)
library(stringi)

rm(list = ls())

#encoding URL
UDNsearch <- function(keyword, dateB, dateE, news="聯合報|經濟日報|聯合晚報|Upaper", page, sharepage=50){
  root <- "http://udndata.com/ndapp/Searchdec2007?" #root
  searchstring <- paste(keyword, "+" , "日期", ">=", dateB, "+", "日期", "<=", dateE, "+" , "報別", "=", news, sep="")
  searchstring <- iconv(searchstring, from = "UTF-8", to = "CP950") #Mac: UTF-8, UDN: big5
  searchstring <- URLencode(searchstring, reserved = TRUE)
  url <- paste(root, "page=", page, "&udndbid=udndata", "&SearchString=", searchstring, "&sharepage=", sharepage, "&select=1", "&kind=3", "&showUserSearch=", sep="")
  return(url)
}
#crawler
UDNcrawler <- function(){
  #turn off locale-specific sorting （程式開始處，先將locale 轉成選項'C'）
  Sys.setlocale(locale = "C")
  
  #progress bar
  pb <- progress_bar$new(
    format = "處理中 [:bar]:percent | 尚需: :eta | 費時: :elapsed", 
    total = p, clear = FALSE, width= 80
  ) 
  #開始
  start <- Sys.time() #紀錄開始時間
  
  #list
  title <- list()
  date <- list()
  
  #loop
  for(i in 1:p){
    #xml2::
    url <- UDNsearch(keyword, DateB, DateE, page=i)
    doc <- read_html(url)
    xml_find_all(doc, xpath = "//a[@class='t']") %>% xml_text() %>% iconv(from = "UTF-8", to = "UTF-8") -> title[[i]]
    xml_find_all(doc, xpath = "//span[@class='date']") %>% xml_text() %>% iconv(from = "UTF-8", to = "UTF-8") -> date[[i]]
    pb$tick()
    Sys.sleep(t)
  }
  
  #turn of locale-specific sorting （程式結束，將locale轉回預設的en.US.UTF-8）
  Sys.setlocale(locale = "en_US.UTF-8")
  
  #unlist
  title <- unlist(title)
  date <- unlist(date)
  
  #data.frame
  tstrsplit(date, "．") -> d1 #分割日期、報別、記者
  d1[[1]] %>% tstrsplit("-") -> d2 #分割年月日
  
  #dataframe 合併年、月、日、標題、報別、記者
  df <- cbind.data.frame(d2[[1]], d2[[2]], d2[[3]], title, d1[[2]], d1[[3]])
  
  #作keyword變數
  df$keyword <- keyword
  
  #variable names
  names(df) <- c("year", "month", "day", "title", "paper", "author", "keyword")
  
  #結束
  end <- Sys.time() #紀錄結束時間
  print(end - start) #輸出總花費時間
  
  return(df)
}
#shutdown computer
shutdown <- function(wait = 0){
  Sys.sleep(wait)
  ifelse(.Platform$OS.type == "windows", shell("shutdown -s -t 0"), 
         system("shutdown -h now"))
}

#前置作業
#到UDN網站確認關鍵字搜尋後頁面數p #簡目 #每頁顯示數要選擇50
keyword <- "((拼經濟OR拚經濟)+資本主義)"    #設定關鍵字
DateB <- 19500101    #設定起始日期
DateE <- 20151231    #設定結束日期
p <- 1            #設定爬的頁數
t <- 10              #設定間隔秒數
#設定完畢

#用這一行檢查能不能正確導引到查詢網址產生結果，可以之後再進loop
UDNsearch(keyword, DateB, DateE, page=1) %>% cat()
url <- UDNsearch(page = 1)

#執行UDNcrawler 
df <- UDNcrawler(keyword, DateB, DateE, page = 1)

#存檔
save(df, file = "~/Desktop/df.rda") #存檔路徑用桌面會無法寫入

#關機
shutdown()

#單一頁面
#loop
#xml2::
url <- UDNsearch(keyword, DateB, DateE, page=1)
doc <- htmlParse(url, useInternalNodes = TRUE)
doc <- read_html(url, encoding = "CP950")
xml_find_all(doc, xpath = "//a[@class='t']") %>% xml_text() %>% iconv(from = "UTF-8", to = "UTF-8") -> title
xml_find_all(doc, xpath = "//span[@class='date']") %>% xml_text() -> date
