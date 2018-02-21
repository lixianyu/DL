#评估和建立直觉
#一旦将数据加载到数据框中，Pandas 会非常简单、快速地对数据进行调查。
#我们现在介绍一些有效的数据集直觉评估和建立方法。可以使用之前的癌症数据。
import pandas as pd

df = pd.read_csv('cancer_data.csv')
df.head(6)

# 返回数据框维度的元组 (569, 32)
df.shape

# 返回列的数据类型
df.dtypes

# 显示数据框的简明摘要，
# 包括每列非空值的数量
df.info()

# 返回每列数据的有效描述性统计
df.describe()

# 返回数据框中的前几行
# 默认返回前五行
df.head()

# 但是也可以指定你希望返回的行数
df.head(20)

# `.tail()` 返回最后几行，但是也可以指定你希望返回的行数
df.tail(1)

'''
在 Pandas 中进行数据索引和选择
我们现在把这个数据框分成三个新的数据框，每个度量为一个数据框（均值、标准误差和最大值）。
如需获得每个数据框的数据，需要选择 id 和 diagnosis 列，以及这个度量的十个列。
'''
# 查看每列的索引号和标签
'''
0 id
1 diagnosis
2 radius_mean
3 texture_mean
4 perimeter_mean
5 area_mean
6 smoothness_mean
7 compactness_mean
8 concavity_mean
9 concave_points_mean
10 symmetry_mean
11 fractal_dimension_mean
12 radius_SE
13 texture_SE
14 perimeter_SE
15 area_SE
16 smoothness_SE
17 compactness_SE
18 concavity_SE
19 concave_points_SE
20 symmetry_SE
21 fractal_dimension_SE
22 radius_max
23 texture_max
24 perimeter_max
25 area_max
26 smoothness_max
27 compactness_max
28 concavity_max
29 concave_points_max
30 symmetry_max
31 fractal_dimension_max
'''
for i, v in enumerate(df.columns):
    print(i, v)

# 选择从 'id' 到最后一个均值列的所有列
df_means = df.loc[:,'id':'fractal_dimension_mean']
df_means.head()

# 用索引号重复以上步骤
df_means = df.iloc[:,:12]
df_means.head()

#保存均值数据框，以便以后使用。
df_means.to_csv('cancer_data_edited.csv', index=False)

# 创建标准误差数据框
df_SE = df.iloc[:,12:22]
df_SE.head()

# 创建最大值数据框
df_MAX = df.iloc[:,22:]
df_MAX.head()
