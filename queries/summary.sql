SELECT TOP 50 
	TO_LOWERCASE(SUBSTR(cs-uri-stem, 0, LAST_INDEX_OF(cs-uri-stem,'.svc'))) AS Service
   ,COUNT(*) AS Hits
   ,MIN(time-taken) as [Min]
   ,max(time-taken) AS [Max] 
   ,DIV ( MUL(1.0, SUM(time-taken)), Hits ) AS [Avg] --must be caculated this way to enable StDev calc
   ,SQRROOT ( SUB ( DIV ( MUL(1.0, SUM(SQR(time-taken)) ), Hits ) , SQR([Avg]) ) ) AS [StDev]
   ,SUM(time-taken) As [CulmulativeTimeTaken]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
GROUP BY Service
ORDER BY Hits DESC