SELECT 
	TO_LOCALTIME(QUANTIZE(TO_TIMESTAMP(date, time), 60)) AS [Minute]
	,COUNT(cs-uri-stem) as [Hits by minute]
	,c-ip as [Client]
	,DIV ( MUL(1.0, SUM(time-taken)), [Hits by minute] ) AS [Avg by minute]  --must be calculated this way to enable StDev calc
	,SQRROOT ( SUB ( DIV ( MUL(1.0, SUM(SQR(time-taken)) ), [Hits by minute] ) 
	,SQR([Avg by minute]) ) ) AS [StDev by minute]
	,Min(time-taken) AS [Min by minute]
	,Max(time-taken) AS [Max by minute]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
      AND c-ip <> '172.25.49.2' AND c-ip <> '172.25.49.3' --The load balancers
GROUP BY [Minute], c-ip
HAVING [Hits by minute] >= 10
ORDER BY [Minute] ASC
