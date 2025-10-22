----vytvoreni View_Duration

CREATE VIEW dbo.View_Duration AS
SELECT
    uc.unique_call_id,
    MIN(uc.dateTimeConnect) AS dateTimeConnect,
    MAX(uc.dateTimeDisconnect) AS dateTimeDisconnect,
    DATEDIFF(SECOND, MIN(uc.dateTimeConnect), MAX(uc.dateTimeDisconnect)) AS duration_seconds
FROM dbo.fact_call AS uc
GROUP BY uc.unique_call_id

-------test 
SELECT TOP 10 *
FROM dbo.View_Duration