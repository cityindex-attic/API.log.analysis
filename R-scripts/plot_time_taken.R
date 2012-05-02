library("xts")

# metadata
nodes <- list("EU-west (Ireland)"="46.137.187.155","US-west (Oregon)"="50.112.111.248","US-east(Virginia)"="23.21.131.181","US-west(North California)"="184.169.142.250","AP-south(Singapore)"="175.41.134.210","AP-North(Tokyo)"="54.248.116.221","S-America (Sao Paulo)"="177.71.182.250")
node_ips <- unlist(nodes, use.names = FALSE)
colours <- c("#490A3D","#BD1550","#E97F02","#F8CA00","#8A9B0F")   #From http://www.colourlovers.com/palette/848743/

logdata = read.table('/home/mrdavidlaing/Downloads/ciapi_logs_for_session_speedup.log', fill=TRUE)

colnames(logdata)=c('date','time','s-sitename','s-computername','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs-version','cs(User-Agent)','cs(Cookie)','cs(Referer)','cs-host','sc-status','sc-substatus','sc-win32-status','sc-bytes','cs-bytes','time-taken')
logdata$datetime <- strptime(paste(logdata$date,logdata$time), "%Y-%m-%d %H:%M:%S")

node_latency <- subset(logdata, select=c("c-ip", "datetime", "cs-uri-stem", "cs-uri-query", "sc-bytes", "time-taken"), subset=(logdata$"c-ip" %in% node_ips))

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

plot(sessionCreate_latency_ts["2012-04-08 00:00:00::2012-04-08 04:30:00"], type="n", ylim=c(0,4000), main="Comparative request latency", ylab="Latency (ms)", xlab="Timestamp (UTC)")
points(sessionCreate_latency_ts["2012-04-08 00:00:00::2012-04-08 04:30:00"], col=colours[1], cex=0.05)
points(sessionDelete_latency_ts["2012-04-08 00:00:00::2012-04-08 04:30:00"], col=colours[2], cex=0.01)
points(clientandtradingaccount_latency_ts["2012-04-08 00:00:00::2012-04-08 04:30:00"], col=colours[3], cex=0.01)
points(cfdmarkets_latency_ts["2012-04-08 00:00:00::2012-04-08 04:30:00"], col=colours[4], cex=0.01)
points(spreadmarkets_latency_ts["2012-04-08 00:00:00::2012-04-08 04:30:00"], col=colours[5], cex=0.01)
legend(strptime("2012-04-08 03:30:00", "%Y-%m-%d %H:%M:%S"), 4000, c("Session create", "Session delete", "ClientAndTradingAccount", "CFD markets (100 mkts)", "Spread markets (0 mkts)"), pch=c(1,1,1,1,1), col=colours, cex=0.8)

plot(sessionCreate_latency_ts["2012-04-08 01:30:00::"], type="n", ylim=c(0,1000), main="Session create request latency", ylab="Latency (ms)", xlab="Timestamp (UTC)")
points(sessionCreate_latency_ts["2012-04-08 01:30:00::"], col=colours[1], cex=0.01)

plot(sessionDelete_latency_ts, type="n", ylim=c(0,300), main="Session delete request latency", ylab="Latency (ms)", xlab="Timestamp (UTC)")
points(sessionDelete_latency_ts, col=colours[2], cex=0.01)

plot(clientandtradingaccount_latency_ts, type="n", ylim=c(0,300), main="ClientAndTradingAccount request latency", ylab="Latency (ms)", xlab="Timestamp (UTC)")
points(clientandtradingaccount_latency_ts, col=colours[3], cex=0.01)

plot(cfdmarkets_latency_ts, type="n", ylim=c(0,300), main="CFD markets request latency ( 100 markets )", ylab="Latency (ms)", xlab="Timestamp (UTC)")
points(cfdmarkets_latency_ts, col=colours[4], cex=0.01)

plot(spreadmarkets_latency_ts, type="n", ylim=c(0,1000), main="Spread markets request latency ( 0 markets )", ylab="Latency (ms)", xlab="Timestamp (UTC)")
points(spreadmarkets_latency_ts, col=colours[5], cex=0.01)
