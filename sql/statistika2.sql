-----pocet hovoru, 

SELECT 
    COUNT(*) AS total_calls,
    SUM(CASE WHEN dateTimeConnect IS NULL THEN 1 ELSE 0 END) AS not_connected_calls,
    SUM(CASE WHEN dateTimeConnect IS NOT NULL THEN 1 ELSE 0 END) AS connected_calls
FROM (
    SELECT unique_call_id, MAX(dateTimeConnect) AS dateTimeConnect
    FROM dbo.View_Duration
    WHERE unique_call_id IS NOT NULL
    GROUP BY unique_call_id
) AS calls



-----------------hovory za jednotl.mesice
SELECT 
    DATEPART(YEAR, dateTimeConnect) AS Rok,
    DATEPART(MONTH, dateTimeConnect) AS Mesic,
    COUNT(DISTINCT unique_call_id) AS Pocet_hovoru
FROM dbo.View_Duration
WHERE dateTimeConnect >= '2024-01-01'
  AND dateTimeConnect < '2024-04-01'
  AND duration_seconds >0
GROUP BY 
    DATEPART(YEAR, dateTimeConnect),
    DATEPART(MONTH, dateTimeConnect)
ORDER BY 
    Rok,
    Mesic

----------------------------------------jednotl.dny
WITH Dny AS (
    SELECT 
        CASE 
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 2 THEN 'Po'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 3 THEN 'Út'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 4 THEN 'St'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 5 THEN 'Čt'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 6 THEN 'Pá'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 7 THEN 'So'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 1 THEN 'Ne'
        END AS Den_v_tydnu,
        COUNT(DISTINCT unique_call_id) AS Pocet_hovoru
    FROM dbo.View_Duration
    WHERE duration_seconds > 0
    GROUP BY 
        CASE 
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 2 THEN 'Po'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 3 THEN 'Út'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 4 THEN 'St'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 5 THEN 'Čt'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 6 THEN 'Pá'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 7 THEN 'So'
            WHEN DATEPART(WEEKDAY, dateTimeConnect) = 1 THEN 'Ne'
        END
)
SELECT 
    Den_v_tydnu,
    Pocet_hovoru
FROM Dny
ORDER BY 
    CASE Den_v_tydnu
        WHEN 'Po' THEN 1
        WHEN 'Út' THEN 2
        WHEN 'St' THEN 3
        WHEN 'Čt' THEN 4
        WHEN 'Pá' THEN 5
        WHEN 'So' THEN 6
        WHEN 'Ne' THEN 7
    END

-----------------------------------------top 10volajicich
SELECT TOP 10
    callingPartyNumber,
    COUNT(DISTINCT unique_call_id) AS pocet_unikatnich_hovoru
FROM dbo.fact_call
WHERE callingPartyNumber IS NOT NULL
 AND callingPartyNumber NOT IN ('<NA>', '</NA>', 'NA', '')
GROUP BY callingPartyNumber
ORDER BY COUNT(DISTINCT unique_call_id) DESC

-------------------10 TOP  volanych
SELECT 
    originalCalledPartyNumber,
    COUNT(DISTINCT unique_call_id) AS Pocet_hovoru
FROM dbo.fact_call
WHERE originalCalledPartyNumber IS NOT NULL
     AND originalCalledPartyNumber NOT IN ('<NA>', '</NA>', 'NA', '')

GROUP BY originalCalledPartyNumber
ORDER BY Pocet_hovoru DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY




SELECT 
    CASE 
        WHEN v.duration_seconds <= 10 THEN '0-10 s'
        WHEN v.duration_seconds BETWEEN 11 AND 60 THEN '11-60 s'
        WHEN v.duration_seconds BETWEEN 61 AND 1800 THEN '1-30 min'
        WHEN v.duration_seconds BETWEEN 1801 AND 3600 THEN '30-60 min'
        WHEN v.duration_seconds BETWEEN 3601 AND 18000 THEN '1-5 hod'
        ELSE 'více než 5 hod'
    END AS DurationRange,
    COUNT(*) AS CountCalls
FROM dbo.View_Duration AS v
WHERE v.duration_seconds IS NOT NULL
GROUP BY 
    CASE 
        WHEN v.duration_seconds <= 10 THEN '0-10 s'
        WHEN v.duration_seconds BETWEEN 11 AND 60 THEN '11-60 s'
        WHEN v.duration_seconds BETWEEN 61 AND 1800 THEN '1-30 min'
        WHEN v.duration_seconds BETWEEN 1801 AND 3600 THEN '30-60 min'
        WHEN v.duration_seconds BETWEEN 3601 AND 18000 THEN '1-5 hod'
        ELSE 'více než 5 hod'
    END
ORDER BY 
    MIN(v.duration_seconds)