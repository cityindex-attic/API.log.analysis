SELECT 
	TO_LOCALTIME(QUANTIZE(TO_TIMESTAMP(date, time), 3600)) AS [Hour]
	,COUNT(cs-uri-stem) as [Hits]
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
      AND c-ip <> '172.25.49.2' AND c-ip <> '172.25.49.3' --The load balancers
GROUP BY [Hour], c-ip
HAVING [Hits] >= 10
ORDER BY [Hour] ASC
