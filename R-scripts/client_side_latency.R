library("ggplot2")
library("RCurl")

metrics_credentials <- Sys.getenv(c("APPMETRICS_CREDENTIALS"))

data_url <- URLencode("http://metrics.labs.cityindex.com/GetRecords.ashx?Application=CIAPILatencyCollector&StartTime=2012-06-07 00:00:00")
webpage <- getURL(data_url,userpwd=metrics_credentials, httpauth = 1L)
logdata <- read.table(tc <- textConnection(webpage), header=F, sep="\t", fill=TRUE, as.is=c(1:4)); 
close(tc)

colnames(logdata)=c('session', 'timestamp','key','value')
logdata$datetime <- strptime(logdata$timestamp, "%Y-%m-%d %H:%M:%S")
rpc <- logdata[logdata$"key" %in% c("Latency LogIn", 
                                    "Latency ListCfdMarkets", 
                                    "Latency GetClientAndTradingAccount", 
                                    #"Latency DefaultPage",
                                    #"Latency GetMarketInformation",
                                    #"Latency GetPriceBars",
                                    "Latency PriceStream"), ]

d <- ggplot(rpc, aes(x=datetime, y=as.double(value)))
d <- d + scale_y_log10()
#d <- d + ylim(-10,100)
#d <- d + geom_point()
#d <- d + stat_smooth(se = FALSE) 
#d <- d + stat_quantile() 
d <- d + geom_hex(bins=100)
d <- d + scale_fill_gradient(low="orange", high="red")

d <- d + facet_grid(key ~ .)
print(d)