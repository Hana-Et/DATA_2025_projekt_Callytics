--kolik hovoru ma vice nez jeden radek: 682 784
SELECT 
    globalCallID_callManagerId,
    globalCallID_callId, 
    COUNT(*) AS pocet
FROM dbo.CMR_clean1
GROUP BY 
    globalCallID_callManagerId,
    globalCallID_callId
HAVING COUNT(*) > 2

--jak vypada napr par hovoru
-- 2 radky hovoru, vse normal
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    globalCallID_callManagerId = 2 AND
    globalCallID_callId = 10000000

--4 radky, jedno cislo nevypsane
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    globalCallID_callManagerId = 2 AND
    globalCallID_callId = 10000647

--7 radku, pricemz jeden nulovy
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    globalCallID_callManagerId = 2 AND
    globalCallID_callId = 10000680

--jeden nulovy radek
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    globalCallID_callManagerId = 2 AND
    globalCallID_callId = 10004770


--radky kde jsou nulove hodnoty u posilani a prijimani packetu a octetu, celkem 92761
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    numberOctetsSent = 0 AND
    numberOctetsSent = 0 AND
    numberPacketsReceived = 0 AND
    numberOctetsReceived = 0

--85 647 hovoru se jevi, ze ma zaznamenane cmr, ale jeji kvalita nebyla zaznamenana
SELECT 
    globalCallID_callManagerId,
    globalCallID_callId, 
    COUNT(*) AS pocet,
    jitter,
    latency
FROM dbo.CMR_clean1
WHERE
    numberOctetsSent = 0 AND
    numberOctetsSent = 0 AND
    numberPacketsReceived = 0 AND
    numberOctetsReceived = 0
GROUP BY 
    globalCallID_callManagerId,
    globalCallID_callId,
    jitter,
    latency
HAVING COUNT(*) = 1

--3361 hovoru na vice radku obsahuje alespon nektere radky s nulovymi hodnotami packetu a octetu
SELECT 
    globalCallID_callManagerId,
    globalCallID_callId, 
    COUNT(*) AS pocet,
    jitter,
    latency
FROM dbo.CMR_clean1
WHERE
    numberOctetsSent = 0 AND
    numberOctetsSent = 0 AND
    numberPacketsReceived = 0 AND
    numberOctetsReceived = 0
GROUP BY 
    globalCallID_callManagerId,
    globalCallID_callId,
    jitter,
    latency
HAVING COUNT(*) > 1
ORDER BY
    pocet DESC

--celkem 7076 nulovych zaznamu v hovorech, ktere jsou na vice radku
SELECT
    SUM(pocet)
FROM
(SELECT 
    globalCallID_callManagerId,
    globalCallID_callId, 
    COUNT(*) AS pocet,
    jitter,
    latency
FROM dbo.CMR_clean1
WHERE
    numberOctetsSent = 0 AND
    numberOctetsSent = 0 AND
    numberPacketsReceived = 0 AND
    numberOctetsReceived = 0
GROUP BY 
    globalCallID_callManagerId,
    globalCallID_callId,
    jitter,
    latency
HAVING COUNT(*) > 1
) a

--priklady hovoru s nulovymi radky
--10x nulovy radek
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    globalCallID_callManagerId = 2 AND
    globalCallID_callId = 10385190

--jevi se jako cmr zaznam hovoru, ale neni nic zapsane (9 radku)
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    globalCallID_callManagerId = 4 AND
    globalCallID_callId = 6180253

--8 radku s nulovymi hodnotami
SELECT
    *
FROM dbo.CMR_clean1
WHERE 
    globalCallID_callManagerId = 2 AND
    globalCallID_callId = 9749160

