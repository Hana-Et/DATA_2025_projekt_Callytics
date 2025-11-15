**Legenda**
01. tvorba_db.sql                -vytvoreni dimenzi a faktove tabulky
02. create_View_Duration.sql     - vytvoreni pohledu, ktery shrnuje informaci o trvani hovoru
03. create_View_CMR_unique_calls.sql -vytvoreni pohledu nad CMR daty s unikátním identifikátorem hovoru  pro určení počtu unikátních hovorů
04. cmr_zero_rows.sql            - pohled na nulove radky v soboru cmr
05. duvody ukonceni.sql          - skripty k duvodum ukonceni pro cely soubor crd, duvody ukonceni jen zmeskanych hovoru
06. statistika2                 -aktualizace s novými daty, distribuce hovorů dle měsíce, dnů a hodin, TOP10 volajících a volaných