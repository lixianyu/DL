/* 编写查询，返回 orders 表的前 10 个订单。包含 id、occurred_at 和 total_amt_usd。 */
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/* 编写一个查询，基于 total_amt_usd 返回前 5 个最高的 订单 (orders 表)。包括 id、account_id 和 total_amt_usd。 */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total DESC
LIMIT 5;

/* 编写一个查询，基于 total 返回前 20 个最低 订单 (orders 表)。包括 id、account_id 和 total。 */
SELECT id, account_id, total
FROM orders
ORDER BY total
LIMIT 20;

/* 编写一个查询，返回按从最新到最早排序的 订单 中的前 5 行，但需首先列出每个日期的最大 total_amt_usd。 */
SELECT *
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;

/* 编写一个查询，返回按从最早到最新排序的 订单 中的前 10 行，但需首先列出每个日期的最小 total_amt_usd。*/
SELECT *
FROM orders
ORDER BY occurred_at, total_amt_usd
LIMIT 10;

/* 从 订单 表提取出大于或等于 1000 的 gloss_amt_usd 美元数额的前五行数据（包含所有列）。*/
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* 从 订单 表提取出小于 500 的 total_amt_usd美元数额的前十行数据（包含所有列）。*/
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

/* 过滤账户（accounts ）表格，从该表格中筛选出 Exxon Mobil 的 name、website 和 primary point of contact (primary_poc)。*/
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

/* 创建一个用 standard_amt_usd 除以 standard_qty 的列，查找每个订单中标准纸的单价。
 将结果限制到前 10 个订单，并包含 id 和 account_id 字段。 注意 - 对于这个问题，
 即使采用正确的解决方案，也会遇到一个问题。这就是除以零。 在后面的课程学习 CASE 语句时，
 你将学会不会让此查询发生错误的解决方案。*/
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
 FROM orders
LIMIT 10;

 /* 编写一个查询，查找每个订单海报纸的收入百分比。 只需使用以 _usd 结尾的列。
 （在这个查询中试一下不使用总列）。包含 id 和 account_id 字段。*/
SELECT id, account_id,
    poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders;


SELECT *
FROM accounts
WHERE name LIKE 'C%';

SELECT *
FROM accounts
WHERE name LIKE '%one%';

SELECT *
FROM accounts
WHERE name LIKE '%s';

/* 使用 客户 表查找 Walmart、Target 和 Nordstrom 的name (客户名称), primary_poc (主要零售店), and sales_rep_id (销售代表 id)。 */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN('Walmart', 'Target', 'Nordstrom')

/* 使用 web_events 表查找有关通过 organic 或 adwords 联系的所有个人信息。*/
SELECT *
FROM web_events
WHERE channel IN('organic', 'adwords')

/* 编写一个查询，返回所有订单，其中 standard_qty 超过 1000，poster_qty 是 0，gloss_qty 也是 0。*/
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/* 使用客户表查找所有不以 'C' 开始但以 's' 结尾的公司名。 */
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/* 使用 web_events 表查找通过 organic 或 adwords 联系，并在 2016 年的任何时间开通帐户的个人全部信息，并按照从最新到最旧的顺序排列。*/
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at >= '2016-01-01' AND occurred_at <= '2016-12-31'
ORDER BY occurred_at DESC;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/* 查找 订单 (orders) id 的列表，其中 gloss_qty 或 poster_qty 大于 4000。只在结果表中包含 id 字段。*/
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

/* 编写一个查询，返回订单 (orders) 的列表，其中标准数量 (standard_qty)为零，光泽度 (gloss_qty) 或海报数量 (poster_qty)超过 1000。*/
SELECT *
FROM orders
WHERE (gloss_qty > 1000 OR poster_qty > 1000) AND standard_qty = 0;

/* 查找以 'C' 或 'W' 开头的所有公司名 (company names)，主要联系人 (primary contact) 包含 'ana' 或 'Ana'，但不包含 'eana'。*/
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%');
