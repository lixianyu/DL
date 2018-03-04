import pandas as pd
'''
For missing data
'''
mean = df['view_duration'].mean()
df['view_duration'] = df['view_duration'].fillna(mean)
# or
df['view_duration'].fillna(mean, inplace=True)

'''
For duplicate data
'''
df.duplicated() # To see which rows are duplicates.

sum(df.duplicated())

df.drop_duplicates(inplace=True)


'''
For datetime
'''
df['timestamp'] = pd.to_datetime(df['timestamp'])
