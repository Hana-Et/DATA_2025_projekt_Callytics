# Joining CDR and CMR Data

import pandas as pd
import os

DATA_PATH = r"C:\Users\adamk\Desktop\Digitální akademie DATA\Projekt\2024_01_03\2024_01_03"

filenames =os.listdir(DATA_PATH)
cesta_k_soboru = DATA_PATH + "\\" + filenames[0]
filenames[0]
df = pd.read_csv(cesta_k_soboru, header=[0,1])

filenames_cdr = []
filenames_cmr = []
for filename in filenames:
    if filename [:3] == "cdr":
        filenames_cdr.append(filename)
    if filename [:3] == "cmr":
        filenames_cmr.append(filename)

cdr_dataframes = []
for filename in filenames_cdr: 
    file_path = DATA_PATH + "\\" + filename
    df = pd.read_csv(file_path, header=[0,1])
    cdr_dataframes.append(df)

cdr_joined_df = pd.concat(cdr_dataframes)
cdr_joined_df.to_csv("cdr_soubory.csv")

cmr_dataframes = []
for filename in filenames_cmr: 
    file_path = DATA_PATH + "\\" + filename
    df = pd.read_csv(file_path, header=[0,1])
    cmr_dataframes.append(df)

cmr_joined_df = pd.concat(cmr_dataframes)
cmr_joined_df.to_csv("cmr_soubory.csv")