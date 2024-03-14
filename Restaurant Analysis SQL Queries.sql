/*EXPLORATORY SQL QUERIES*/
-- OBJECTIVE 1: Explore the menu items table
SELECT 
    *
FROM
    menu_items;

/*What are the least and most expensive items on the menu?*/
SELECT 
    *
FROM
    menu_items
ORDER BY price;

-- most expensive
SELECT 
    *
FROM
    menu_items
ORDER BY price DESC;


/*How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?*/
SELECT 
    COUNT(menu_item_id)
FROM
    menu_items
WHERE
    category = 'Italian';
    
-- least expensive Italian item
SELECT 
    *
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY price;

-- most expensive Italian item
SELECT 
    *
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY price DESC;

/*How many dishes are in each category? What is the average dish price within each category?*/
    
SELECT 
    category,
    COUNT(menu_item_id) AS num_dishes,
    AVG(price) AS avg_price
FROM
    menu_items
GROUP BY category;

-- OBJECTIVE 2: Explore the orders table

SELECT 
    *
FROM
    order_details;

-- date range
SELECT 
    MIN(order_date), MAX(order_date)
FROM
    order_details;

/*How many orders were made within this date range? */
SELECT 
    COUNT(DISTINCT order_id) AS num_orders
FROM
    order_details;

/*How many items were ordered within this date range?*/
SELECT 
    COUNT(order_id) AS num_items
FROM
    order_details;

/*Which orders had the most number of items?*/
SELECT 
    order_id, COUNT(item_id) AS num_items
FROM
    order_details
GROUP BY order_id
ORDER BY num_items DESC;

/*How many orders had more than 12 items?*/
SELECT 
    COUNT(*)
FROM
    (SELECT 
        order_id, COUNT(item_id) AS num_items
    FROM
        order_details
    GROUP BY order_id
    HAVING num_items > 12) AS num_orders;
;

-- OBJECTIVE 3: Analyze customer behavior

SELECT 
    *
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id;

/*What were the least and most ordered items?*/
-- least expensive
SELECT 
    item_name, COUNT(order_details_id) AS num_purchases
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name
ORDER BY num_purchases;

-- most expensive
SELECT 
    item_name, COUNT(order_details_id) AS num_purchases
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name
ORDER BY num_purchases DESC;

/*What categories were they in?*/
SELECT 
    item_name,
    category,
    COUNT(order_details_id) AS num_purchases
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY item_name , category
ORDER BY num_purchases DESC;

/*What were the top 5 orders that spent the most money?*/
SELECT 
    order_id, SUM(price) AS total_spent
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
GROUP BY order_id
ORDER BY total_spent DESC
LIMIT 5;

/*View the details of the highest spend order. Which specific items were purchased?*/
SELECT 
    *
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE
    order_id = 440;

 /*What was their categories and how many items per category*/
SELECT 
    category, COUNT(order_details_id) AS num_items
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE
    order_id = 440
GROUP BY category;

/*View the details of the top 5 highest spend orders*/
SELECT 
    *
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE
    order_id IN (440 , 2075, 1957, 330, 2675)
ORDER BY order_id;

-- Catgories and number of items bought by top 5 spenders 

SELECT 
    order_id, category, COUNT(order_details_id) AS num_items
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE
    order_id IN (440 , 2075, 1957, 330, 2675)
GROUP BY order_id , category;

-- Insights gained. Asian, Mexican and Italian dishes seem to be favoured by customers especially those who spend a lot and are recommended to be kept on the menu. Also, Italian dishes were ordered the most by top spenders.
-- Aggregated by Item name
SELECT 
    category, COUNT(order_details_id) AS num_items
FROM
    order_details
        LEFT JOIN
    menu_items ON order_details.item_id = menu_items.menu_item_id
WHERE
    order_id IN (440 , 2075, 1957, 330, 2675)
GROUP BY category;