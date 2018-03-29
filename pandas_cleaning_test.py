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
##########################################################################
# 加载数据集
# load datasets
df_08 = pd.read_csv('clean_08_my.csv')
df_18 = pd.read_csv('clean_18_my.csv')
df_08 = pd.read_csv('all_alpha_08.csv')
df_18 = pd.read_csv('all_alpha_18.csv')
# 从 2008 数据集中丢弃列
df_08.drop(['Stnd', 'Underhood ID', 'FE Calc Appr', 'Unadj Cmb MPG'], axis=1, inplace=True)
df_18.drop(['Stnd','Stnd Description','Underhood ID','Comb CO2'], axis=1, inplace=True)
# 将销售区域重命名为特定区域
df_08.rename(columns = {'Sales Area':'Cert Region'}, inplace=True)
# 在 2008 数据集中用下划线和小写标签代替空格
df_08.rename(columns=lambda x: x.strip().lower().replace(" ", "_"), inplace=True)
# 在 2018 数据集中用下划线和小写标签代替空格
df_18.rename(columns=lambda x: x.strip().lower().replace(" ", "_"), inplace=True)
