import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
% matplotlib inline
import seaborn as sns
sns.set_style('darkgrid')

# 加载红葡萄酒和白葡萄酒数据集
red_df = pd.read_csv('winequality-red.csv', sep=';')
white_df = pd.read_csv('winequality-white.csv', sep=';')
red_df = red_df.rename(columns = {'total_sulfur-dioxide':'total_sulfur_dioxide'})
# 为红葡萄酒数据框创建颜色数组
color_red = np.repeat('red', 1599)
# 为白葡萄酒数据框创建颜色数组
color_white = np.repeat('white', 4898)
red_df['color'] = color_red
white_df['color'] = color_white
# 附加数据框
wine_df = red_df.append(white_df, ignore_index=True)
wine_df.head()

# 获取每个等级和颜色的数量
color_counts = wine_df.groupby(['color', 'quality']).count()['pH']
# 获取每个颜色的总数
color_totals = wine_df.groupby('color').count()['pH']
# 将红葡萄酒等级数量除以红葡萄酒样本总数，获取比例
red_proportions = color_counts['red'] / color_totals['red']
# 将白葡萄酒等级数量除以白葡萄酒样本总数，获取比例
white_proportions = color_counts['white'] / color_totals['white']

red_proportions['9'] = 0

ind = np.arange(len(red_proportions))  # 组的 x 坐标位置
print(ind)
width = 0.35       # 条柱的宽度
# 绘制条柱
red_bars = plt.bar(ind, red_proportions, width, color='r', alpha=.7, label='Red Wine')
white_bars = plt.bar(ind + width, white_proportions, width, color='w', alpha=.7, label='White Wine')

# 标题和标签
plt.ylabel('Proportion')
plt.xlabel('Quality')
plt.title('Proportion by Wine Color and Quality')
locations = ind + width / 2  # x 坐标刻度位置
labels = ['3', '4', '5', '6', '7', '8', '9']  # x 坐标刻度标签
plt.xticks(locations, labels)

# 图例
plt.legend()
