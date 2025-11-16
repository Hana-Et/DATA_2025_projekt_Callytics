--kolik hovoru ma alespon 1 zaznam o kvalite 1298380
SELECT
    COUNT(DISTINCT c.unique_call_id)
FROM fact_call c 
    LEFT JOIN cmr_filtered r ON c.globalCallID_callManagerId = r.globalCallID_callManagerId
                    AND c.globalCallID_callId = r.globalCallID_callId
WHERE
    r.unique_call_id IS NOT NULL

--vytvoreni sloupce avg mos a vklad dat pomoci regex, vybran parametr MLQKav
ALTER TABLE cmr_filtered
ADD avg_mos float

UPDATE cmr_filtered --(avg_mos)
SET 
    avg_mos = CAST(REGEXP_SUBSTR(CAST(varVQMetrics AS NVARCHAR(500)), 'MLQKav=([\d.]+)', 1, 1, 'c', 1) AS float)
FROM 
    cmr_filtered


--pocet hovoru ktere maji avg mos - 105017
SELECT
    COUNT(*)
FROM (
    SELECT
        unique_call_id,
        AVG(avg_mos) AS avg_avg
    FROM cmr_filtered
    GROUP BY
        unique_call_id 
    ) x 
WHERE avg_avg IS NOT NULL

--rozdeleni hovoru, ktere maji avg mos do kategorii podle kvality
SELECT
    CASE
            WHEN avg_avg < 3.6 THEN 'unacceptable'
            WHEN avg_avg >= 3.6 AND avg_avg < 4.0 THEN 'fair'
            WHEN avg_avg >= 4.0 AND avg_avg < 4.3 THEN 'good'
            WHEN avg_avg >= 4.3 THEN 'excellent' 
        END AS quality,
        COUNT(*) AS CountCalls
FROM
    (SELECT
        unique_call_id,
        AVG(avg_mos) AS avg_avg
    FROM cmr_filtered
    WHERE avg_mos IS NOT NULL
    GROUP BY
        unique_call_id) x 
GROUP BY
    CASE
            WHEN avg_avg < 3.6 THEN 'unacceptable'
            WHEN avg_avg >= 3.6 AND avg_avg < 4.0 THEN 'fair'
            WHEN avg_avg >= 4.0 AND avg_avg < 4.3 THEN 'good'
            WHEN avg_avg >= 4.3 THEN 'excellent' 
        END
ORDER BY
    quality

