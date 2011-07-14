SELECT 
	TO_LOCALTIME(QUANTIZE(TO_TIMESTAMP(date, time), 3600)) AS [Hour]
	,AVG(time-taken) as [Avg by hour]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
GROUP BY [Hour]
ORDER BY [Hour] ASC