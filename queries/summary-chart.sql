SELECT TOP 50 
	TO_LOWERCASE(SUBSTR(cs-uri-stem, 0, LAST_INDEX_OF(cs-uri-stem,'.svc'))) AS Service
   ,COUNT(*) AS Hits
   ,DIV ( MUL(1.0, SUM(time-taken)), Hits ) AS [Avg] --must be caculated this way to enable StDev calc
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%.svc%'
GROUP BY Service
ORDER BY Hits DESC