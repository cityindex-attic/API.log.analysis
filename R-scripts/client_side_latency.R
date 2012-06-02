library("ggplot2")
data_dir <- "/mnt/cityindex.appmetrics/2012-05"
files <- list.files(path=sprintf("%s/23",data_dir)
                                  ,pattern=".txt"
                                  ,full.names=TRUE)
#files <- append(files, list.files(path=sprintf("%s/rdb-srv-webl25",data_dir)
#                                  ,pattern=".log"
#                                  ,full.names=TRUE))

read.tables <- function(file.names, ...) {
  require(plyr)
  ldply(file.names, function(fn)
    data.frame(Filename=fn, read.table(fn, ...)))
}

logdata <- read.tables(files, header=F, sep="\t", fill=TRUE)
colnames(logdata)=c('source_filename', 'timestamp','key','value')
logdata$datetime <- strptime(logdata$timestamp, "%Y-%m-%d %H:%M:%S")
rpc <- logdata[logdata$"key" %in% c("Latency LogIn", 
                                    "Latency ListCfdMarkets", 
                                    "Latency GetClientAndTradingAccount", 
                                    "Latency DefaultPage",
                                    "Latency GetMarketInformation",
                                    "Latency GetPriceBars"), ]

d <- ggplot(rpc, aes(x=datetime, y=as.double(value)))
#d <- d + geom_hex(bins=500)
d <- d + geom_point()
#d <- d + ylim(0,3000)
#d <- d + scale_fill_gradient(low="white", high="red")
d <- d + facet_grid(key ~ .)
print(d)