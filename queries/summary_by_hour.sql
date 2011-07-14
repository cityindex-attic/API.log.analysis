SELECT 
	TO_LOCALTIME(QUANTIZE(TO_TIMESTAMP(date, time), 3600)) AS [Hour]
	,COUNT(cs-uri-stem) AS [Hits by hour]
	,DIV ( MUL(1.0, SUM(time-taken)), [Hits by hour] ) AS [Avg by hour]  --must be calculated this way to enable StDev calc
	,SQRROOT ( SUB ( DIV ( MUL(1.0, SUM(SQR(time-taken)) ), [Hits by hour] ) 
	,SQR([Avg by hour]) ) ) AS [StDev by hour]
	,Min(time-taken) AS [Min by hour]
	,Max(time-taken) AS [Max by hour]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
GROUP BY [Hour]
ORDER BY [Hour] ASC