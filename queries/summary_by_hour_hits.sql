SELECT 
	TO_LOCALTIME(QUANTIZE(TO_TIMESTAMP(date, time), 3600)) AS [Hour]
	,COUNT(cs-uri-stem) AS [Hits by hour]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
GROUP BY [Hour]
ORDER BY [Hour] ASC