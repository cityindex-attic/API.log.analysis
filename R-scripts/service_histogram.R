#
#    grep --no-filename '/TradingApi/[Ss]ession' */u*052*.log > session.log 
#    fgrep --no-filename -i '/clientandtradingaccount' */u*052*.log > accountinformation.log   
#    fgrep --no-filename -i 'markets' */u*052*.log > markets.log 
#    grep --no-filename 'rading' */u*052*.log > all.log
#    grep --no-filename '80\.169\.172\.178' */u*052*.log > all.log
#
#
library("ggplot2")

logdata = read.table('/mnt/data/2012-05/80.169.172.178.log', fill=TRUE)
colnames(logdata1)=c('date','time','s-sitename','scomputername','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs-version','cs(User-Agent)','cs(Cookie)','cs(Referer)','cs-host','sc-status','sc-substatus','sc-win32-status','sc-bytes','cs-bytes','timetaken')
logdata$datetime <- strptime(paste(logdata$date,logdata$time), "%Y-%m-%d %H:%M:%S")

d <- ggplot(logdata, aes(x=datetime, y=timetaken))
d <- d + geom_hex(bins=100)
d <- d + ylim(0,1000)
d <- d + scale_fill_gradient(low="white", high="red")
d <- d + facet_grid(scomputername ~ .)
print(d)