REM Clean
del /S /Q reports
mkdir reports

SET InputIISLogs=sample_data\IIS\*.log
REM SET InputIISLogs=C:\Dev\live_RESTWebService_logs\IIS_logs\*.log


logparser.exe -i:IISW3C file:queries\summary.sql?InputIISLogs=%InputIISLogs%+OutputReport=reports\summary.html -o:TPL -tpl:queries\summary.tpl
logparser.exe -i:IISW3C file:queries\summary.sql?InputIISLogs=%InputIISLogs%+OutputReport=reports\summary.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js

logparser.exe -i:IISW3C file:queries\StatusCodes.sql?InputIISLogs=%InputIISLogs%+OutputReport=reports\StatusCodes.html -o:TPL -tpl:queries\StatusCodes.tpl
logparser.exe -i:IISW3C file:queries\StatusCodes.sql?InputIISLogs=%InputIISLogs%+OutputReport=reports\StatusCodes.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js