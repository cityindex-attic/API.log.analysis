-- service aggregates
SELECT TOP 50 TO_LOWERCASE(SUBSTR(cs-uri-stem, 0, LAST_INDEX_OF(cs-uri-stem,'.svc'))) AS service
,MIN(time-taken) as [Min], AVG(time-taken) AS [Avg], max(time-taken) AS [Max] 
, COUNT(*) AS Hits
FROM C:\Dev\live_RESTWebService_logs\IIS_logs\u_ex*.log
GROUP BY service
ORDER BY Hits DESC

-- details / service
SELECT TOP 50 cs-uri-stem, cs-method
,MIN(time-taken) as [Min], AVG(time-taken) AS [Avg], max(time-taken) AS [Max] 
,COUNT(cs-uri-stem) AS Hits
FROM C:\Dev\live_RESTWebService_logs\IIS_logs\u_ex*.log
WHERE cs-uri-stem LIKE '/tradingapi/marketinformation%'
GROUP BY cs-uri-stem, cs-method
ORDER BY Hits DESC

-- requests / minute
SELECT TO_TIME(TO_LOCALTIME(QUANTIZE(time, 60))) AS [Minute]
,DIV ( MUL(1.0, SUM(time-taken)), Hits ) AS [Avg], SQRROOT ( SUB ( DIV ( MUL(1.0, SUM(SQR(time-taken)) ), Hits ) , SQR(AvgTime) ) ) AS [StDev], Min(time-taken) AS [Min], Max(time-taken) AS [Max]
,COUNT(cs-uri-stem) AS Hits
FROM C:\Dev\live_RESTWebService_logs\IIS_logs\u_ex*.log
WHERE cs-uri-stem LIKE '/tradingapi/marketpricehistory.svc%'
GROUP BY Minute
ORDER BY Minute ASC

--requests / client
SELECT c-ip AS [client]
,COUNT(cs-uri-stem) AS Hits
,DIV ( MUL(1.0, SUM(time-taken)), Hits ) AS [Avg], SQRROOT ( SUB ( DIV ( MUL(1.0, SUM(SQR(time-taken)) ), Hits ) , SQR([Avg]) ) ) AS [StDev], Min(time-taken) AS [Min], Max(time-taken) AS [Max]
FROM C:\Dev\live_RESTWebService_logs\IIS_logs\u_ex*.log
WHERE cs-uri-stem <> '/'
GROUP BY [client]
ORDER BY [Hits] DESC