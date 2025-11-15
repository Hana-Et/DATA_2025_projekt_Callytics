**Legenda**

- 01 oba_celkem_pickle.py                         Sloučení CDR a CMR dat pomocí pickel
- 02 chosen_columns_pickle.ipynb                  vybranné sloupce u cdr
- 03 chosen_columns_dataTypes_pickle.ipynb        uprava datatypů - string, timestamp (0 =NaT)
- ~~04 file_cdr_clean_nob00.ipynb                   počet hodnot b00, odstranění řádků začínajících na b00~~
- 05 diff_numbers_cdr_clean_NOb00.ipynb           počet telefonních číslel končících na .0, různé zápisy volajících čísel, různé zápisy volaných čísel, přehled délek tel. čísel
- 06 information_cdr_clean_nob00.ipynb            duplicity, počet unikátních hovorů v rámci měsíce a týdne
- 07 statistika.ipynb                             počet řádků a sloupců, počet chybějících nan hodnot, skutečný počet unikátních hovorů, celkový počet řádků, skutečný počet hovorů, počet duplicitních záznamů
- ~~08 statistika2.ipynb                            TOP 10 volaných a volajících, poměr přijatých a nepřijatých, , zabezpečení hovorů, délka hovorů, distribuce hovoru - mesíc, dny, casové bloky~~

- data_cleaning.ipynb 
- file_cdr_clean_nob00.ipynb                        nové
- find_null.ipynb                                   kontrola pro pocet NULL(NaN/NaT) v jednolivych sloupcich u souboru:cdr_files_chosen_columns.pkl/cdr_clean.pkl/cdr_clean_unique_calls_update_num.pkl/
 
- statistika2.ipynb                                   aktualizace s novými daty, distribuce hovorů dle měsíce, dnů a hodin, TOP1 volajícíc a volaný
- pkl_to_csv.py                                       převedení aktuálních do csv pro potřeby PowerBi (cdr_clean_unique_calls_update_num2.csv)
-CMR_clean1.ipynb                                      uprava datatypů - string (zde NULL=Unknown), timestamp, directoryNum - integer (NULL='-1')


------------------------------
- ** staré skripty, nepoužívané
------------------------------
- ** chosen_columns.ipynb
- ** data_cleaning.ipynb
- ** data_cleaning_2.ipynb
- ** hrani.ipynb
- ** joining_cmr_cdr.py Původní skript
- ** pickel.ipynb  uložení CDR do pickel
-------------------------------