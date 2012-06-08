CIAPI latency - 01 June 2012 - 08 June 2012
===========================================


```
## Warning message: package 'ggplot2' was built under R version 2.14.2
```



```
## Loading required package: bitops
```



```
## Warning message: package 'scales' was built under R version 2.14.2
```






```r
webpage <- getURL(data_url, userpwd = metrics_credentials, httpauth = 1L)
logdata <- read.table(tc <- textConnection(webpage), header = F, 
    sep = "\t", fill = TRUE, as.is = c(1:4))
close(tc)
colnames(logdata) = c("session", "timestamp", "key", "value")
```






```r
nodes <- logdata[logdata$key %in% c("ClientIP"), ]
nodes$nodeName = nodes$value
nodes <- subset(nodes, select = c(-timestamp, -key, -value))
```






```r
rpc <- logdata[logdata$key %in% c("Latency DefaultPage"), ]
rpc$datetime <- strptime(rpc$timestamp, "%Y-%m-%d %H:%M:%S")
rpc <- join(rpc, nodes, by = "session", match = "first")

d <- ggplot(rpc, aes(x = datetime, y = as.double(value)))
d <- d + scale_y_log10()
d <- d + geom_hex()
d <- d + scale_fill_gradient(low = "grey", high = "red") + theme_bw()
d <- d + facet_grid(nodeName ~ key)
print(d)
```

![plot of chunk network_latency_plot](figure/network_latency_plot.png) 




```r
rpc2 <- logdata[logdata$key %in% c("Latency LogIn", "Latency ListCfdMarkets", 
    "Latency GetClientAndTradingAccount", "Latency GetMarketInformation", "Latency ListCfdMarkets", 
    "Latency GetPriceBars", "Latency ListOpenPositions", "Latency ListNewsHeadlinesWithSource", 
    "Latency ListTradeHistory"), ]
rpc2$datetime <- strptime(rpc2$timestamp, "%Y-%m-%d %H:%M:%S")
rpc2 <- join(rpc2, nodes, by = "session", match = "first")

d <- ggplot(rpc2, aes(x = datetime, y = as.double(value)))
d <- d + scale_y_log10()
d <- d + geom_hex()
d <- d + scale_fill_gradient(low = "grey", high = "red") + theme_bw()
d <- d + facet_grid(key ~ nodeName)
print(d)
```

![plot of chunk service_latency_plot](figure/service_latency_plot.png) 

