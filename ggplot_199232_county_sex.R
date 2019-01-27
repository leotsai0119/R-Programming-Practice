rm(list = ls())
library(ggplot2)
library(dplyr)
load(file = "~/Documents/Rdata/Census 1990/199232.Rdata")

myData <- myData %>% mutate(
    NEW_City = case_when(
        myData$COUNTY %in% c("04", "06", "09", "14", "15",
                                              "22", "24", "25", "26") ~ "1", 
        TRUE ~ "0"
    )
)

#myData <- myData %>% mutate(
#    COUNTY = case_when(
#        myData$COUNTY == "09" ~ "19",
#        myData$COUNTY == "14" ~ "24",
#        myData$COUNTY == "15" ~ "26"
#    )
#)
