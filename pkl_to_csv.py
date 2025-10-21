import pandas as pd

pkl_file = r"c:\Users\adamk\Desktop\Digitální akademie DATA\Projekt\joined_data\cdr_clean_unique_calls_update_num2.pkl"

df = pd.read_pickle(pkl_file)

csv_file = "cdr_clean_unique_calls_update_num2.csv"
df.to_csv(csv_file, index=False)

print(f"Soubor byl uložen jako {csv_file}")