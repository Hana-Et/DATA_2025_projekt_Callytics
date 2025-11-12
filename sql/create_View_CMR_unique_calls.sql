---vytvoreni view pro unikatni kod

CREATE VIEW dbo.vw_CMR_unique_calls AS
SELECT
    CAST(globalCallID_callManagerId AS NVARCHAR(50)) + '-' +
    CAST(globalCallID_callId AS NVARCHAR(50)) + '-' +
    CONVERT(NVARCHAR(10), dateTimeStamp, 120) AS unique_call_id,

    CONVERT(date, dateTimeStamp) AS datum,
    CONVERT(time, dateTimeStamp) AS cas,

    *
FROM dbo.CMR_clean1


--test
SELECT TOP 10 unique_call_id, datum, cas, dateTimeStamp
FROM dbo.vw_CMR_unique_calls


---Pocet unikatnich hovoru
SELECT COUNT(DISTINCT unique_call_id) AS PocetUnikatnichHovoru
FROM dbo.vw_CMR_unique_calls