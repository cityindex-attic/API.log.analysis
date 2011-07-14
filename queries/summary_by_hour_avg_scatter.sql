SELECT 
	 TO_LOCALTIME(QUANTIZE(TO_TIMESTAMP(date, time), 3600)) AS [Hour]
	,TO_REAL([Hour]) AS [Hour_TIMESTAMP]
	,time-taken as [Request Time]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
ORDER BY [Hour] ASC