SELECT TOP 50 
	TO_LOWERCASE(SUBSTR(cs-uri-stem, 0, LAST_INDEX_OF(cs-uri-stem,'.svc'))) AS Service
   ,MIN(time-taken) as [Min]
   ,AVG(time-taken) AS [Avg]
   ,max(time-taken) AS [Max] 
   ,COUNT(*) AS Hits
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%.svc%'
GROUP BY Service
ORDER BY Hits DESC