SELECT *
FROM accounts
WHERE primary_poc IS NULL

SELECT COUNT(*)
FROM accounts;

SELECT COUNT(accounts.id)
FROM accounts;

/* 算出 orders 表格中的 poster_qty 纸张总订单量。*/
SELECT SUM(poster_qty)
FROM orders

SELECT SUM(poster_qty) poster_sum, SUM(standard_qty) standard_sum, SUM(total_amt_usd) total
FROM orders

SELECT standard_qty + gloss_qty AS total_standard_gloss
FROM orders;

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

/* 最早的订单下于何时？*/
SELECT MIN(occurred_at)
FROM orders;

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

/* 最近的 web_event 发生在什么时候？*/
SELECT MAX(occurred_at)
FROM web_events

/* 算出每个订单在每种纸张上消费的平均 (AVERAGE) 金额，以及每个订单针对每种纸张购买的平均数量。
最终答案应该有 6 个值，每个纸张类型平均销量对应一个值，以及平均数量对应一个值。*/
SELECT AVG(standard_qty) avg_std_qty,AVG(gloss_qty) avg_gloss_qty,
    AVG(poster_qty) avg_poster_qty,
    AVG(standard_amt_usd) avg_std_usd, AVG(gloss_amt_usd) avg_gloss_usd,
    AVG(poster_amt_usd) avg_poster_usd
FROM orders

/* 我相信你都渴望知道在所有订单上消费的中值 total_usd 是多少？虽然这一概念已经超出我们的范围。
注意，这比我们到目前为止介绍的基本内容要高深一点，但是我们可以按照以下方式对答案进行硬编码。*/
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

/*哪个客户（按照名称）下的订单最早？你的答案应该包含订单的客户名称和日期。*/
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

SELECT a.name, MIN(o.occurred_at) min_time
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY min_time

算出每个客户的总销售额（单位是美元）。答案应该包括两列：每个公司的订单总销售额（单位是美元）以及公司名称。
SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

最近的 web_event 是通过哪个渠道发生的，与此 web_event 相关的客户是哪个？你的查询应该仅返回三个值：
日期、渠道和客户名称。
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

算出 web_events 中每种渠道的次数。最终表格应该有两列：渠道和渠道的使用次数。
SELECT w.channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
GROUP BY w.channel

与最早的 web_event 相关的主要联系人是谁？
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

每个客户所下的最小订单是什么（以总金额（美元）为准）。答案只需两列：客户名称和总金额（美元）。
从最小金额到最大金额排序。
SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

算出每个区域的销售代表人数。最早表格应该包含两列：区域和 sales_reps 数量。从最少到最多的代表人数排序。
SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;
/* ---------------------------------------------------------------------------*/
对于每个客户，确定他们在订单中购买的每种纸张的平均数额。结果应该有四列：客户名称一列，每种纸张类型的平均数额一列。
SELECT a.name, AVG(o.standard_qty) avg_stand, AVG(gloss_qty) avg_gloss, AVG(poster_qty) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

对于每个客户，确定在每个订单中针对每个纸张类型的平均消费数额。结果应该有四列：客户名称一列，
每种纸张类型的平均消费数额一列。
SELECT a.name, AVG(o.standard_amt_usd) avg_stand, AVG(gloss_amt_usd) avg_gloss, AVG(poster_amt_usd) avg_post
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

确定在 web_events 表格中每个销售代表使用特定渠道的次数。最终表格应该有三列：销售代表的名称、
渠道和发生次数。按照最高的发生次数在最上面对表格排序。
SELECT s.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

确定在 web_events 表格中针对每个地区特定渠道的使用次数。最终表格应该有三列：区域名称、渠道和发生次数。
按照最高的发生次数在最上面对表格排序。
SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

使用 DISTINCT 检查是否有任何客户与多个区域相关联？
SELECT DISTINCT a.id, r.id, a.name, r.name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

SELECT DISTINCT id, name
FROM accounts;

有没有销售代表要处理多个客户？
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

SELECT DISTINCT id, name
FROM sales_reps;

/* .................................................................................. */
有多少位销售代表需要管理超过 5 个客户？
SELECT a.sales_rep_id, COUNT(a.id) client_nums
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY a.sales_rep_id
HAVING COUNT(a.id) > 5
ORDER BY client_nums

有多少个客户具有超过 20 个订单？
SELECT o.account_id, COUNT(o.id) order_nums
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY o.account_id
HAVING COUNT(o.id) > 20
ORDER BY order_nums

哪个客户的订单最多？
SELECT o.account_id, COUNT(o.id) order_nums
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY o.account_id
HAVING COUNT(o.id) > 20
ORDER BY order_nums DESC
LIMIT 1

有多少个客户在所有订单上消费的总额超过了 30,000 美元？
SELECT o.account_id, a.name, SUM(o.total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY o.account_id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_usd DESC

有多少个客户在所有订单上消费的总额不到 1,000 美元？
SELECT o.account_id, a.name, SUM(o.total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY o.account_id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_usd DESC

哪个客户消费的最多？
SELECT o.account_id, a.name, SUM(o.total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY o.account_id, a.name
ORDER BY total_usd DESC
LIMIT 1

哪个客户消费的最少？
SELECT o.account_id, a.name, SUM(o.total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY o.account_id, a.name
ORDER BY total_usd
LIMIT 1

哪个客户使用 facebook 作为与消费者沟通的渠道超过 6 次？
SELECT w.account_id, a.name, w.channel, COUNT(*) event_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY w.account_id, a.name, w.channel
HAVING COUNT(*) > 6
ORDER BY event_times

哪个客户使用 facebook 作为沟通渠道的次数最多？
SELECT w.account_id, a.name, w.channel, COUNT(*) event_times
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY w.account_id, a.name, w.channel
ORDER BY event_times DESC
LIMIT 1

哪个渠道是客户最常用的渠道？
SELECT w.channel, COUNT(a.id) account_nums
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY w.channel
ORDER BY account_nums DESC

/* CASE 语句*/
/*我们想要根据相关的消费量了解三组不同的客户。最高的一组是终身价值（所有订单的总销售额）大于
200,000 美元的客户。第二组是在 200,000 到 100,000 美元之间的客户。最低的一组是低于
under 100,000 美元的客户。请提供一个表格，其中包含与每个客户相关的级别。你应该提供客户
的名称、所有订单的总销售额和级别。消费最高的客户列在最上面。*/
SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY 2 DESC;

/*现在我们想要执行和第一个问题相似的计算过程，但是我们想要获取在 2016 年和 2017 年客户的
总消费数额。级别和上一个问题保持一样。消费最高的客户列在最上面。*/
SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at > '2015-12-31'
GROUP BY 1
ORDER BY 2 DESC;

/*我们想要找出绩效最高的销售代表，也就是有超过 200 个订单的销售代表。创建一个包含以下列的
表格：销售代表名称、订单总量和标为 top 或 not 的列（取决于是否拥有超过 200 个订单）。
销售量最高的销售代表列在最上面。*/
SELECT s.name, COUNT(*) num_ords,
     CASE WHEN COUNT(*) > 200 THEN 'top'
     ELSE 'not' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 2 DESC;

/*之前的问题没有考虑中间水平的销售代表或销售额。管理层决定也要看看这些数据。我们想要找出绩效
很高的销售代表，也就是有超过 200 个订单或总销售额超过 750000 美元的销售代表。中间级别是指
有超过 150 个订单或销售额超过 500000 美元的销售代表。创建一个包含以下列的表格：销售代表名称、
总订单量、所有订单的总销售额，以及标为 top、middle 或 low 的列（取决于上述条件）。在最终
表格中将销售额最高的销售代表列在最上面。根据上述标准，你可能会见到几个表现很差的销售代表！*/
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent,
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;
