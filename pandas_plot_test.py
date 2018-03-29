import pandas as pd
import matplotlib.pyplot as plt
% matplotlib inline

df = pd.read_csv('winequality-red.csv')
df = pd.read_csv('winequality-white.csv')
df_census = pd.read_csv('census_income_data.csv')

df_census.hist()
df_census.hist(figsize=(8, 8));

df_census['age'].hist();

df_census['age'].plot(kind='hist');

df_census['education'].value_counts().plot(kind='hist')
df_census['education'].value_counts().plot(kind='bar')

df_census['workclass'].value_counts().plot(kind='pie', figsize=(8, 8))

pd.plotting.scatter_matrix(df_census, figsize=(15, 15))

df_census.plot(x='compactness', y='concavity', kind='scatter')

df_census['concave_points'].plot(kind='box');
