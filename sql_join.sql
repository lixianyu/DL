/* 通用*/
SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* 尝试获取 accounts 表格中的所有数据，以及 orders 表格中的所有数据。
 * 注意，下述结果与切换 FROM 和 JOIN 中的表格得到的结果一样。此外，= 两边的列顺序并不重要。
*/
SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

/* 尝试从 orders 表格中获取 standard_qty、gloss_qty 和 poster_qty，并从 accounts 表格中获取 website 和 primary_poc。*/
SELECT orders.standard_qty, orders.gloss_qty,
orders.poster_qty,  accounts.website,
accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/* 为与客户名称 Walmart 相关的所有 web_events 创建一个表格。表格应该包含三列：primary_poc、事件时间和每个事件的渠道。此外，你可以选择添加第四列，确保仅选中了 Walmart 事件。*/
SELECT a.primary_poc, w.occurred_at, w.channel,a.name
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
WHERE a.name = 'Walmart'
ORDER BY w.occurred_at DESC;

/* 为每个销售代表对应的区域以及相关的客户创建一个表格，最终表格应该包含三列：
区域名称、销售代表名称，以及客户名称。根据客户名称按字母顺序 (A-Z) 排序。*/
SELECT r.name AS rep_name, s.name AS sales_name, a.name AS cus_name
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name DESC

/* 提供每个订单的每个区域名称，以及客户名称和订单的单价 (total_amt_usd/total)。
最终表格应该包含三列：区域名称、客户名称和单价。少数几个客户的总订单数为 0，
因此我除以的是 (total + 0.01) 以确保没有除以 0。*/
SELECT r.name AS region, a.name AS cus_name, o.total_amt_usd/(total+0.001) AS unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id

/*------------------------------------------------------------------------------------------*/
/* 为每个销售代表对应的区域以及相关的客户创建一个表格，这次仅针对 Midwest 区域。
最终表格应该包含三列：区域名称、销售代表姓名，以及客户名称。根据客户名称按字母顺序 (A-Z) 排序。*/
SELECT a.name cus_name, r.name region, s.name sales_name
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
 AND r.name = 'Midwest'
ORDER BY a.name

/* 为每个销售代表对应的区域以及相关的客户创建一个表格，这次仅针对 Midwest 区域，
并且销售代表的名字以 S 开头。最终表格应该包含三列：区域名称、销售代表姓名，以及客户名称。
根据客户名称按字母顺序 (A-Z) 排序。*/
SELECT a.name cus_name, r.name region, s.name sales_name
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
 AND s.name LIKE 'S%'
JOIN region r
ON s.region_id = r.id
 AND r.name = 'Midwest'
ORDER BY a.name

/* 为每个销售代表对应的区域以及相关的客户创建一个表格，这次仅针对 Midwest 区域，
并且销售代表的姓以 K 开头。最终表格应该包含三列：区域名称、销售代表姓名，以及客户名称。
根据客户名称按字母顺序 (A-Z) 排序。*/
SELECT a.name cus_name, r.name region, s.name sales_name
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
 AND s.name LIKE '% K%'
JOIN region r
ON s.region_id = r.id
 AND r.name = 'Midwest'
ORDER BY a.name

/* 提供每个订单的每个区域的名称，以及客户名称和所支付的单价 (total_amt_usd/total)。
但是，只针对标准订单数量超过 100 的情况提供结果。最终表格应该包含三列：区域名称、
客户名称和单价。为了避免除以 0 个订单，这里可以在分子上加上 0.01(total_amt_usd/(total+0.01)。*/
SELECT r.name region, a.name cus_name, o.total_amt_usd/(o.total+0.001) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
  AND o.standard_qty > 100
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id

/* 提供每个订单的每个区域的名称，以及客户名称和所支付的单价 (total_amt_usd/total)。
但是，只针对标准订单数量超过 100 且广告纸数量超过 50 的情况提供结果。最终表格应该包含三列：
区域名称、客户名称和单价。按照最低的单价在最之前排序。为了避免除以 0 个订单，
这里可以在分子上加上 0.01(total_amt_usd/(total+0.01)。*/
SELECT r.name region, a.name cus_name, o.total_amt_usd/(o.total+0.001) unit_price, o.standard_qty, o.poster_qty
FROM orders o
JOIN accounts a
ON o.account_id = a.id
  AND o.standard_qty > 100
  AND o.poster_qty > 50
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY unit_price

/* account id 为 1001 的客户使用了哪些不同的渠道。最终表格应该包含 2 列：客户名称和不同的渠道。
你可以尝试使用 SELECT DISTINCT 使结果仅显示唯一的值。*/
SELECT a.name cus_name, w.channel
FROM accounts a
RIGHT JOIN web_events w
ON w.account_id = a.id
WHERE a.id = '1001'

/* 找出发生在 2015 年的所有订单。最终表格应该包含 4 列：occurred_at、account name、order total
和 order total_amt_usd。*/
SELECT o.occurred_at, a.name cus_name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
 AND (o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01')
