library("ggplot2")
data_dir <- "/home/mrdavidlaing/2012-04"
files <- list.files(path=sprintf("%s/rdb-srv-webl24",data_dir)
                                  ,pattern=".log"
                                  ,full.names=TRUE)
files <- append(files, list.files(path=sprintf("%s/rdb-srv-webl25",data_dir)
                                  ,pattern=".log"
                                  ,full.names=TRUE))

read.tables <- function(file.names, ...) {
  require(plyr)
  ldply(file.names, function(fn)
    data.frame(Filename=fn, read.table(fn, ...)))
}

logdata <- read.tables(files, fill=TRUE)
colnames(logdata)=c('source_filename', 'date','time','s-sitename','scomputername','s-ip','cs-method','cs-uri-stem','cs-uri-query','s-port','cs-username','c-ip','cs-version','cs(User-Agent)','cs(Cookie)','cs(Referer)','cs-host','sc-status','sc-substatus','sc-win32-status','sc-bytes','cs-bytes','timetaken')
logdata$datetime <- strptime(paste(logdata$date,logdata$time), "%Y-%m-%d %H:%M:%S")

d <- ggplot(logdata, aes(x=datetime, y=timetaken))
d <- d + geom_hex(bins=100)
d <- d + ylim(0,1000)
d <- d + scale_fill_gradient(low="white", high="red")
d <- d + facet_grid(scomputername ~ .)
print(d)