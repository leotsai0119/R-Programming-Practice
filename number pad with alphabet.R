#vanilla
#number pad with alphabets
rm(list = ls())
l <- split(letters, rep(2:9, c(3, 3, 3, 3, 3, 4, 3, 4))) #list
l <- unlist(l, recursive = FALSE); l #unlist

#query. numbers in, letters out.
n <- "212223313233"
n <- strsplit(n, split = "")[[1]]; n
q <- paste0(n[c(TRUE, FALSE)], n[c(FALSE, TRUE)]); q
df <- data.frame(row.names = names(l), value = l)
df[q, ]

#reverse query. letters in, numbers out.
hello <- "helloworld"
sp <- unlist(strsplit(hello, split = "", fixed = TRUE)); sp #list
dff <- data.frame(row.names = l, value = names(l))
dff[sp, ]

####### 

n <- "2122232425262728"
n <- strsplit(n, split = "")[[1]]
out1 <- paste0(n[c(TRUE, FALSE)], n[c(FALSE, TRUE)]); out1
out2 <- paste(n[c(TRUE, FALSE)], n[c(FALSE, TRUE)], sep = ",")
#
text <- "aabbccccdd"
sst <- strsplit(text, "")[[1]] ; sst
#sst <- strsplit(text, split = "") ; sst
out <- paste0(sst[c(TRUE, FALSE)], sst[c(FALSE, TRUE)]) ; out
        
####### matching and selecting

1:10 %in% c(1,3,5,9)
sstr <- c("c","ab","B","bba","c","@","bla","a","Ba","%")
sstr[sstr %in% c(letters,LETTERS)]

grep("[a-z]", letters)

vec=c("b","a","c"); vec
df=data.frame(row.names=letters[1:5],values=1:5); df
df[rownames(df) %in% vec,1]
df[vec, ]


#######
x <- "abcdefggh"
y <- strsplit(x, split = "")
charmatch(y[[1]][1], letters) == 1

x <- 1
y <- 1
if(x == y){print("Hello World")}

#pmatch
x <- c("abcd", "bcde", "cdef", "defg")
y <- c("a", "b", "c")
letters %in% y
