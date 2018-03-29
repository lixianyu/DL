import pandas as pd
% matplotlib inline

df_census = pd.read_csv('census_income_data.csv')
df_a = df_census[df_census['income'] == ' >50K']
df_b = df_census[df_census['income'] == ' <=50K']

ind = df_a['education'].value_counts().index
# bar --- 柱状图
# value_counts 返回的值是按大小排序的
df_a['education'].value_counts().plot(kind='bar')
df_b['education'].value_counts().plot(kind='bar')

#按照相同的标签了
df_a['education'].value_counts()[ind].plot(kind='bar')
df_b['education'].value_counts()[ind].plot(kind='bar')

#直方图看年龄分布
df_a['age'].hist()
df_b['age'].hist()
