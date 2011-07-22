SELECT 
	TO_LOCALTIME(QUANTIZE(TO_TIMESTAMP(date, time), 3600)) AS [Hour]
	,COUNT(cs-uri-stem) as [Hits by Hour]
	,c-ip as [Client]
	,DIV ( MUL(1.0, SUM(time-taken)), [Hits by Hour] ) AS [Avg by Hour]  --must be calculated this way to enable StDev calc
	,SQRROOT ( SUB ( DIV ( MUL(1.0, SUM(SQR(time-taken)) ), [Hits by Hour] ) 
	,SQR([Avg by Hour]) ) ) AS [StDev by Hour]
	,Min(time-taken) AS [Min by Hour]
	,Max(time-taken) AS [Max by Hour]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
      AND c-ip <> '172.25.49.2' AND c-ip <> '172.25.49.3' --The load balancers
GROUP BY [Hour], c-ip
HAVING [Hits by Hour] >= 10
ORDER BY [Hour] ASC
