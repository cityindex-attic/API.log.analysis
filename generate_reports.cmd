REM Clean
del /S /Q reports
mkdir reports

logparser.exe -i:IISW3C file:queries\summary.sql?InputIISLogs=sample_data\IIS\*.log+OutputReport=reports\summary.html -o:TPL -tpl:queries\summary.tpl
logparser.exe -i:IISW3C file:queries\summary.sql?InputIISLogs=sample_data\IIS\*.log+OutputReport=reports\summary.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js

REM tools\log_parser\logparser.exe -i:IISW3C file:queries\summary.sql  -chartType:Bar3D -groupSize:640x480 -view:on
logparser.exe -i:IISW3C file:queries\StatusCodes.sql?InputIISLogs=sample_data\IIS\*.log+OutputReport=reports\StatusCodes.html -o:TPL -tpl:queries\StatusCodes.tpl
logparser.exe -i:IISW3C file:queries\StatusCodes.sql?InputIISLogs=sample_data\IIS\*.log+OutputReport=reports\StatusCodes.gif -o:CHART -chartType:ColumnClustered -config:queries\chart_config.js