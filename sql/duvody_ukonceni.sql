
--takhle mi to pise 482514 hovoru u neprijatych hovoru
SELECT
    unique_call_id
FROM fact_call
GROUP BY 
    unique_call_id
HAVING
    MIN(dateTimeConnect) IS NULL

--duvody ukonceni u vsech jedinecnych hovoru z posledniho radku (2234015) na strane volajiciho
;WITH last_rows AS (
    SELECT
        unique_call_id,
        origCause_value,
        dateTimeConnect,
        ROW_NUMBER() OVER (
            PARTITION BY unique_call_id
            ORDER BY dateTimeDisconnect DESC
        ) AS rn
    FROM fact_call
)
SELECT
    unique_call_id,
    origCause_value
FROM last_rows
WHERE rn = 1

--duvody ukonceni hovoru z posledniho radku na strane volajiciho
;WITH last_rows AS (
    SELECT
        unique_call_id,
        origCause_value,
        dateTimeConnect,
        ROW_NUMBER() OVER (
            PARTITION BY unique_call_id
            ORDER BY dateTimeDisconnect DESC
        ) AS rn
    FROM fact_call
)
SELECT
    origCause_value,
    COUNT(*) AS pocet
FROM last_rows
WHERE rn = 1
GROUP BY origCause_value
ORDER BY pocet DESC

--duvody ukonceni hovoru z poslednuho radku na strane volaneho
;WITH last_rows AS (
    SELECT
        unique_call_id,
        destCause_value,
        dateTimeConnect,
        ROW_NUMBER() OVER (
            PARTITION BY unique_call_id
            ORDER BY dateTimeDisconnect DESC
        ) AS rn
    FROM fact_call
)
SELECT
    destCause_value,
    COUNT(*) AS pocet
FROM last_rows
WHERE rn = 1
GROUP BY destCause_value
ORDER BY pocet DESC

--duvody neprijeti hovoru na strane volajiciho (482514)
;WITH calls AS 
    (
    SELECT
        unique_call_id,
        origCause_value,
        dateTimeConnect,
        ROW_NUMBER() OVER (
            PARTITION BY unique_call_id
            ORDER BY dateTimeConnect DESC
        ) AS rn
    FROM fact_call
    ),
unanswered AS 
    (
    SELECT unique_call_id
    FROM fact_call
    GROUP BY unique_call_id
    HAVING MIN(dateTimeConnect) IS NULL
    )
SELECT
    c.origCause_value,
    COUNT(*) AS pocet_neprijatych
FROM calls c
    JOIN unanswered u ON c.unique_call_id = u.unique_call_id
WHERE 
    c.rn = 1
GROUP BY 
    c.origCause_value
ORDER BY
    pocet_neprijatych DESC

--duvody neprijeti hovoru na strane volaneho
;WITH calls AS 
    (
    SELECT
        unique_call_id,
        destCause_value,
        dateTimeConnect,
        ROW_NUMBER() OVER (
            PARTITION BY unique_call_id
            ORDER BY dateTimeConnect DESC
        ) AS rn
    FROM fact_call
    ),
unanswered AS 
    (
    SELECT unique_call_id
    FROM fact_call
    GROUP BY unique_call_id
    HAVING MIN(dateTimeConnect) IS NULL
    )
SELECT
    c.destCause_value,
    COUNT(*) AS pocet_neprijatych
FROM calls c
    JOIN unanswered u ON c.unique_call_id = u.unique_call_id
WHERE 
    c.rn = 1
GROUP BY 
    c.destCause_value
ORDER BY
    pocet_neprijatych DESC