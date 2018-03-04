import pandas as pd
% matplotlib inline

df_census = pd.read_csv('census_income_data.csv')

df_census.hist()
df_census.hist(figsize=(8, 8));

df_census['age'].hist();

df_census['age'].plot(kind='hist');

df_census['education'].value_counts().plot(kind='hist')

df_census['workclass'].value_counts().plot(kind='pie', figsize=(8, 8))
