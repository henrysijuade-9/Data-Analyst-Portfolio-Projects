-- OBJECTIVE 1: EXPLORE THE ITEMS TABLE

USE restaurant_db;

-- 1. VIEW THE MENU_ITEMS TABLE.
SELECT * FROM menu_items;

-- 2. FIND THE NUMBER OF ITEMS ON THE MENU. 
SELECT COUNT(*) FROM menu_items;

-- 3. WHAT ARE THE LEAST AND MOST EXPENSIVE ITEMS ON THE MENU?
SELECT * FROM  menu_items
order by price;

-- 4. HOW MANY ITALIAN DISHES ARE ON THE MENU?
SELECT COUNT(*) FROM  menu_items
WHERE category= 'Italian';

-- 5. WHAT ARE THE LEAST AND MOST EXPENSIVE ITALIAN DISHES ON THE MENU?
SELECT *
FROM menu_items
WHERE category='Italian'
ORDER BY price;

-- 6. HOW MANY DISHES ARE IN EACH CATEGORY?
SELECT category, COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category;

-- 7. WHAT IS THE AVERAGE DISH PRICE WITHIN EACH CATEGORY?
SELECT category, avg(price) AS avg_price
FROM menu_items
GROUP BY category;

-- OBJECTIVE 2: EXPLORE THE ORDERS TABLE

-- 1. VIEW THE ORDER_DETAILS TABLE. 
SELECT * FROM order_details;

-- 2. WHAT IS THE DATE RANGE OF THE TABLE?
SELECT MIN(order_date), MAX(order_date) FROM order_details;

-- 3. HOW MANY ORDERS WERE MADE WITHIN THIS DATE RANGE?
SELECT COUNT(DISTINCT order_id) FROM order_details;

-- 4. HOW MANY ITEMS WERE ORDERED WITHIN THIS DATE RANGE?
SELECT COUNT(*) FROM order_details;

-- 5. WHICH ORDERS HAD THE MOST NUMBER OF ITEMS?
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 6. HOW MANY ORDERS HAD THAN 12 ITEMS?
SELECT COUNT(*) FROM 

(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;

-- OBJECTIVE 3: ANALYZE CUSTOMER BEHAVIOUR 

-- 1. COMBINE THE MENU_ITEMS AND ORDER_DETAILS TABLE INTO A SINGLE TABLE.
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;

-- 2. WHAT WERE THE LEAST AND MOST ORDERED ITEMS? WHAT CATEGORIES WERE THEY IN?
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases;

-- 3. WHAT WERE THE TOP 5 ORDERS THAT SPENT THE MOST MONEY?
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 4. VIEW THE DETAILS OF THE HIGHEST SPEND ORDER. WHAT INSIGHTS CAN YOU GATHER FROM THE RESULTS?
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;


-- 5. VIEW THE DETAILS OF THE TOP 5 HIGHEST SPEND ORDERS. WHAT INSIGHT CAN YOU GATHER FROM THE RESULTS?
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;

	'440',	'192.15'
	'2075', '191.05'
	'1957',	'190.10'
	'330',	'189.70'
	'2675',	'185.10'