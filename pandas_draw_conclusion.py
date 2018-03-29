import pandas as pd
% matplotlib inline

df_m = df[df['diagnosis'] == 'M']

mask = df['diagnosis'] == 'M'
print(mask)
df_m = df[mask]

# selecting malignant records in cancer data
df_m = df[df['diagnosis'] == 'M']
df_m = df.query('diagnosis == "M"')

# selecting records of people making over $50K
df_a = df[df['income'] == ' >50K']
df_a = df.query('income == " >50K"')



df_m['area'].describe()

df.groupby('quality').mean()
df.groupby(['quality', 'color']).mean()
df.groupby(['quality', 'color'], as_index=False).mean()
df.groupby(['quality', 'color'], as_index=False)['pH'].mean()

red_df = red_df.rename(columns = {'total_sulfur-dioxide':'total_sulfur_dioxide'})
df_08.rename(columns=lambda x: x.strip().lower().replace(" ", "_"), inplace=True)
