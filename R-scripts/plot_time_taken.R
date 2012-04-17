# metadata
nodes <- list("EU-west (Ireland)"="46.137.187.155","US-west (Oregon)"="50.112.111.248","US-east(Virginia)"="23.21.131.181","US-west(North California)"="184.169.142.250","AP-south(Singapore)"="175.41.134.210","AP-North(Tokyo)"="54.248.116.221","S-America (Sao Paulo)"="177.71.182.250")
node_ips <- unlist(nodes, use.names = FALSE)

logdata = read.table('sample_data/IIS/rdb-srv-webl25_ex120408.log', nrows=100000)

colnames(logdata)=c('date','time','s-sitename','s-computername','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs-version','cs(User-Agent)','cs(Cookie)','cs(Referer)','cs-host','sc-status','sc-substatus','sc-win32-status','sc-bytes','cs-bytes','time-taken')
logdata$datetime <- strptime(paste(logdata$date,logdata$time), "%Y-%m-%d %H:%M:%S")

node_latency <- subset(logdata, select=c("c-ip", "datetime", "cs-uri-stem", "time-taken"), subset=(logdata$"c-ip" %in% node_ips))

sessionCreate_latency <- subset(node_latency, subset=(node_latency$"cs-uri-stem"=="/TradingAPI/Session.svc/"))
sessionCreate_latency_ts <- xts(sessionCreate_latency$"time-taken", sessionCreate_latency$"datetime")
sessionDelete_latency <- subset(node_latency, subset=(node_latency$"cs-uri-stem"=="/TradingAPI/Session.svc/deletesession"))
sessionDelete_latency_ts <- xts(sessionDelete_latency$"time-taken", sessionDelete_latency$"datetime")
clientandtradingaccount_latency <- subset(node_latency, subset=(node_latency$"cs-uri-stem"=="/TradingAPI/AccountInformation.svc/useraccount/clientandtradingaccount"))
clientandtradingaccount_latency_ts <- xts(clientandtradingaccount_latency$"time-taken", clientandtradingaccount_latency$"datetime")
cfdmarkets_latency <- subset(node_latency, subset=(node_latency$"cs-uri-stem"=="/TradingAPI/CfdMarkets.svc/"))
cfdmarkets_latency_ts <- xts(cfdmarkets_latency$"time-taken", cfdmarkets_latency$"datetime")
spreadmarkets_latency <- subset(node_latency, subset=(node_latency$"cs-uri-stem"=="/TradingAPI/SpreadMarkets.svc/"))
spreadmarkets_latency_ts <- xts(spreadmarkets_latency$"time-taken", spreadmarkets_latency$"datetime")

plot(sessionCreate_latency_ts, type="n", ylim=c(0,4000), main="Comparative request latency", ylab="Latency (ms)", xlab="Timestamp (UTC)")
points(sessionCreate_latency_ts, col="black", cex=0.01)
points(sessionDelete_latency_ts, col="blue", cex=0.01)
points(clientandtradingaccount_latency_ts, col="red", cex=0.01)
points(cfdmarkets_latency_ts, col="yellow", cex=0.01)
points(spreadmarkets_latency_ts, col="green", cex=0.01)
legend(strptime("2012-04-08 03:30:00", "%Y-%m-%d %H:%M:%S"), 4000, c("Session create", "Session delete", "ClientAndTradingAccount", "CFD markets", "Spread markets"), pch=c(1,1,1,1,1), col=c("black", "blue", "red", "yellow", "green"), cex=0.65)