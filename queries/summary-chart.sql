SELECT TOP 50 
	TO_LOWERCASE(SUBSTR(cs-uri-stem, 0, LAST_INDEX_OF(cs-uri-stem,'.svc'))) AS Service
   ,COUNT(*) AS Hits
   ,SUM(time-taken) As [CulmulativeTimeTaken]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
GROUP BY Service
ORDER BY Hits DESC