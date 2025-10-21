--vytvoreni dim_tabulek
CREATE TABLE dim_Cause_value
(
    id bigint NOT NULL,
    nazev nvarchar(max) NOT NULL,
    CONSTRAINT PK_dim_Cause_value__id PRIMARY KEY CLUSTERED (id)
)

INSERT INTO
    dim_Cause_value (id, nazev)
SELECT Code, Description FROM dbo.Cause_value


CREATE TABLE dim_OnBehalfOf
(
    id int NOT NULL,
    nazev nvarchar(max) NOT NULL,
    CONSTRAINT PK_dim_OnBehalfOf__id PRIMARY KEY CLUSTERED (id)
)

INSERT INTO
    dim_OnBehalfOf (id, nazev)
SELECT Value, Description FROM dbo.OnBehalfof_codes


CREATE TABLE dim_CallSecuredStatus
(
    id int NOT NULL,
    nazev nvarchar(max) NOT NULL,
    CONSTRAINT PK_dim_CallSecuredStatus__id PRIMARY KEY CLUSTERED (id)
)

INSERT INTO
    dim_CallSecuredStatus (id, nazev)
SELECT Value, Description FROM dbo.callSecuredStatus


CREATE TABLE dim_RedirectReason
(
    id int NOT NULL,
    nazev nvarchar(max) NOT NULL,
    CONSTRAINT PK_dim_RedirectReason__id PRIMARY KEY CLUSTERED (id)
)

INSERT INTO
    dim_RedirectReason (id, nazev)
SELECT Value, Description FROM dbo.Redirect_Reason_Codes


--vytvoreni fact_tabulky
CREATE TABLE fact_call
(
    globalCallID_callManagerId          int                 NOT NULL,
    globalCallID_callId                 bigint              NOT NULL,
    origLegCallIdentifier               bigint              NOT NULL,
    dateTimeOrigination                 datetime            NOT NULL,
    callingPartyNumber                  nvarchar(100)       ,
    origCause_value                     bigint              NOT NULL,
    destLegIdentifier                   bigint              NOT NULL,
    originalCalledPartyNumber           nvarchar(100)       ,
    finalCalledPartyNumber              nvarchar(100)       ,
    destCause_value                     bigint              NOT NULL,
    dateTimeConnect                     datetime            ,
    dateTimeDisconnect                  datetime            NOT NULL,
    lastRedirectDn                      nvarchar(100)       ,
    pkid                                nvarchar(100)       NOT NULL,
    duration_s                          bigint              NOT NULL,
    origDeviceName                      nvarchar(100)       ,
    destDeviceName                      nvarchar(100)       ,
    origCallTerminationOnBehalfOf       int                 NOT NULL,
    destCallTerminationOnBehalfOf       int                 NOT NULL,
    origCalledPartyRedirectOnBehalfOf   int                 NOT NULL,
    lastRedirectRedirectOnBehalfOf      int                 NOT NULL,
    origCalledPartyRedirectReason       int                 NOT NULL,
    lastRedirectRedirectReason          int                 NOT NULL,
    joinOnBehalfOf                      int                 NOT NULL,
    callSecuredStatus_id                int                 NOT NULL,
    unique_call_id                      bigint              NOT NULL
)

INSERT INTO
    fact_call
    (
    globalCallID_callManagerId,
    globalCallID_callId,
    origLegCallIdentifier,
    dateTimeOrigination,
    callingPartyNumber,
    origCause_value,
    destLegIdentifier,
    originalCalledPartyNumber,
    finalCalledPartyNumber,
    destCause_value,
    dateTimeConnect,
    dateTimeDisconnect,
    lastRedirectDn,
    pkid,
    duration_s,
    origDeviceName,
    destDeviceName,
    origCallTerminationOnBehalfOf,
    destCallTerminationOnBehalfOf,
    origCalledPartyRedirectOnBehalfOf,
    lastRedirectRedirectOnBehalfOf,
    origCalledPartyRedirectReason,
    lastRedirectRedirectReason,
    joinOnBehalfOf,
    callSecuredStatus_id,
    unique_call_id 
    )
SELECT globalCallID_callManagerId,
    globalCallID_callId,
    origLegCallIdentifier,
    dateTimeOrigination,
    callingPartyNumber,
    origCause_value,
    destLegIdentifier,
    originalCalledPartyNumber,
    finalCalledPartyNumber,
    destCause_value,
    dateTimeConnect,
    dateTimeDisconnect,
    lastRedirectDn,
    pkid,
    duration,
    origDeviceName,
    destDeviceName,
    origCallTerminationOnBehalfOf,
    destCallTerminationOnBehalfOf,
    origCalledPartyRedirectOnBehalfOf,
    lastRedirectRedirectOnBehalfOf,
    origCalledPartyRedirectReason,
    lastRedirectRedirectReason,
    joinOnBehalfOf,
    callSecuredStatus,
    unique_call_id 
    FROM dbo.cdr_unique_calls


--vytvoreni FK
ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__origCause_value
FOREIGN KEY
    (origCause_value)
REFERENCES
    dim_Cause_value (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__destCause_value
FOREIGN KEY
    (destCause_value)
REFERENCES
    dim_Cause_value (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__origCallTerminationOnBehalfOf
FOREIGN KEY
    (origCallTerminationOnBehalfOf)
REFERENCES
    dim_OnBehalfOf (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__destCallTerminationOnBehalfOf
FOREIGN KEY
    (destCallTerminationOnBehalfOf)
REFERENCES
    dim_OnBehalfOf (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__origCalledPartyRedirectOnBehalfOf
FOREIGN KEY
    (origCalledPartyRedirectOnBehalfOf)
REFERENCES
    dim_OnBehalfOf (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__lastRedirectRedirectOnBehalfOf
FOREIGN KEY
    (lastRedirectRedirectOnBehalfOf)
REFERENCES
    dim_OnBehalfOf (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__joinOnBehalfOf
FOREIGN KEY
    (joinOnBehalfOf)
REFERENCES
    dim_OnBehalfOf (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__origCalledPartyRedirectReason
FOREIGN KEY
    (origCalledPartyRedirectReason)
REFERENCES
    dim_RedirectReason (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__lastRedirectRedirectReason
FOREIGN KEY
    (lastRedirectRedirectReason)
REFERENCES
    dim_RedirectReason (id)


ALTER TABLE
    fact_call
ADD CONSTRAINT
    FK_fact_call__callSecuredStatus_id
FOREIGN KEY
    (callSecuredStatus_id)
REFERENCES
    dim_CallSecuredStatus
    
