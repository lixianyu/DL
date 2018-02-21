import pandas as pd

df = pd.read_csv('calls.csv')

# CSV 代表逗号分隔值，但这些值实际可用不同的字符、制表符、空格等分隔
df = pd.read_csv('student_scores.csv', sep=':')

# 指定文件的哪一行作为标题
df = pd.read_csv('student_scores.csv', header=2)

#如果文件中不包括列标签，可以使用 header=None 防止数据的第一行被误当做列标签。
df = pd.read_csv('student_scores.csv', header=None)

#还可以用以下方法自己指定列标签
labels = ['id', 'name', 'attendance', 'hw', 'test1', 'project1', 'test2', 'project2', 'final']
df = pd.read_csv('student_scores.csv', names=labels)

#如果想告诉 pandas，正在替换的数据包含标题行，可以用以下方法指定这一行。
labels = ['id', 'name', 'attendance', 'hw', 'test1', 'project1', 'test2', 'project2', 'final']
df = pd.read_csv('student_scores.csv', header=0, names=labels)

#除使用默认索引（从 0 递增 1 的整数）之外，还可以将一个或多个列指定为数据框的索引。
df = pd.read_csv('student_scores.csv', index_col='Name')
df = pd.read_csv('student_scores.csv', index_col=['Name', 'ID'])
df.head()

df_powerplant = pd.read_csv('powerplant_data.csv')
df_powerplant.head(10)
#太棒了！现在我们将含有电厂数据的第二个数据框保存为 csv 文件，供下一段使用。
df_powerplant.to_csv('powerplant_data_edited.csv', index=False)

################################################################################################
