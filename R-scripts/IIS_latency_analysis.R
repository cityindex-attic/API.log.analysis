library(stringr)
library(ggplot2)
# metadata
nodes <- list("EU-west (Ireland)"="79.125.25.36","US-west (Oregon)"="50.112.111.248","US-east(Virginia)"="23.21.131.181","US-west(North California)"="184.169.142.250","AP-south(Singapore)"="175.41.134.210","AP-North(Tokyo)"="54.248.116.221","S-America (Sao Paulo)"="177.71.182.250")
node_ips <- unlist(nodes, use.names = FALSE)
folder <- "C:/Dev/cityindex/API.log.analysis/data/201209-201301/"
datafile <- paste0(folder, '79.125.25.36_requests_session.log')
logdata <- read.table(datafile, blank.lines.skip=TRUE, stringsAsFactors=FALSE,skip=1)

colnames(logdata)=c('date','time','s-sitename','s-computername','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs-version','cs(User-Agent)','cs(Cookie)','cs(Referer)','cs-host','sc-status','sc-substatus','sc-win32-status','sc-bytes','cs-bytes','time-taken')

requests<- subset(logdata, select=c("c-ip", "date","time", "cs-uri-stem", "cs-uri-query", "sc-bytes", "time-taken"), subset=(logdata$"c-ip" %in% node_ips))
requests$datetime <- strptime(paste(str_sub(requests$date, start= -10),requests$time), "%Y-%m-%d %H:%M:%S", tz="GMT")

requests <- subset(requests, grepl("session$|newtradeorder$", requests$"cs-uri-stem"))

#requests$key <- sub('/TradingApi/session', 'CIAPI.LogIn',requests$"cs-uri-stem", fixed = TRUE)
#requests$key <- sub('/TradingApi/order/newtradeorder', 'CIAPI.Trade',requests$key, fixed = TRUE)

# logdata2$key <- sub('Latency CIAPI.message/.*', 'Latency CIAPI.LookupMessage',logdata2$key, perl = TRUE)

#hist(requests$"time-taken", br=300000, xlim = c(0, 500),  
#     main="Login latency histogram",  
#     xlab="Latency")

qplot(requests$"time-taken", binwidth=5, xlim = c(10, 300),
      main="Login latency histogram",  
      xlab="Latency")