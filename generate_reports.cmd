REM Clean
del /S /Q reports
mkdir reports

xcopy /e templates\*.* reports

SET InputIISLogs=sample_data\IIS\*.log
REM SET InputIISLogs=C:\Dev\live_RESTWebService_logs\IIS_logs\*.log

set UriLikeFilter=svc
logparser.exe -i:IISW3C file:queries\summary.sql?UriLikeFilter=svc+InputIISLogs=%InputIISLogs%+OutputReport=reports\svc-summary.html -o:TPL -tpl:queries\summary.tpl
logparser.exe -i:IISW3C file:queries\summary-chart.sql?UriLikeFilter=svc+InputIISLogs=%InputIISLogs%+OutputReport=reports\svc-summary.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js -groupSize:1024x768

call :generate_reports svc
call :generate_reports session
call :generate_reports marketpricehistory
call :generate_reports order
call :generate_reports messages
call :generate_reports marketinformation
call :generate_reports accountinformation
call :generate_reports cfdmarkets
call :generate_reports spreadmarkets
call :generate_reports hedge
call :generate_reports watchlist
call :generate_reports trade
call :generate_reports news

GOTO :end

:generate_reports
	set UriLikeFilter=%1

	logparser.exe -i:IISW3C file:queries\StatusCodes.sql?UriLikeFilter=%1+InputIISLogs=%InputIISLogs%+OutputReport=reports\%1-StatusCodes.html -o:TPL -tpl:queries\StatusCodes.tpl
	logparser.exe -i:IISW3C file:queries\StatusCodes.sql?UriLikeFilter=%1+InputIISLogs=%InputIISLogs%+OutputReport=reports\%1-StatusCodes.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js 

	logparser.exe -i:IISW3C file:queries\summary_by_hour.sql?UriLikeFilter=%1+InputIISLogs=%InputIISLogs%+OutputReport=reports\%1-summary_by_hour.html -o:TPL -tpl:queries\summary_by_hour.tpl
	logparser.exe -i:IISW3C file:queries\summary_by_hour_hits.sql?UriLikeFilter=%1+InputIISLogs=%InputIISLogs%+OutputReport=reports\%1-summary_by_hour_hits.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js -groupSize:2000x768
	logparser.exe -i:IISW3C file:queries\summary_by_hour_avg.sql?UriLikeFilter=%1+InputIISLogs=%InputIISLogs%+OutputReport=reports\%1-summary_by_hour_avg.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js -groupSize:2000x768
	logparser.exe -i:IISW3C file:queries\summary_by_hour_avg_scatter.sql?UriLikeFilter=%1+InputIISLogs=%InputIISLogs%+OutputReport=reports\%1-summary_by_hour_avg_scatter.gif -o:CHART -chartType:ScatterMarkers -config:queries\scatter_chart_config.js -groupSize:2000x768

	GOTO :eof

:end
echo DONE!