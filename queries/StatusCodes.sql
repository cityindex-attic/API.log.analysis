SELECT 	STRCAT(TO_STRING(sc-status), REPLACE_IF_NOT_NULL(TO_STRING(sc-substatus), STRCAT('.',TO_STRING(sc-substatus)))) AS Status, 
	COUNT(*) AS [Total by status code] 
FROM %InputIISLogs%
TO %OutputReport%
WHERE cs-uri-stem LIKE '%%%UriLikeFilter%%%'
GROUP BY Status 
ORDER BY Status ASC