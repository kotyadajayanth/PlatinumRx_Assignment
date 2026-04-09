SELECT sales_channel, SUM(amount) AS total_revenue
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY sales_channel;


SELECT cs.uid, SUM(cs.amount) AS total_spent
FROM clinic_sales cs
WHERE strftime('%Y', cs.datetime) = '2021'
GROUP BY cs.uid
ORDER BY total_spent DESC
LIMIT 10;


SELECT r.month,
       r.revenue,
       IFNULL(e.expense, 0) AS expense,
       (r.revenue - IFNULL(e.expense, 0)) AS profit,
       CASE 
           WHEN (r.revenue - IFNULL(e.expense, 0)) > 0 THEN 'profitable'
           ELSE 'not-profitable'
       END AS status
FROM (
    SELECT strftime('%m', datetime) AS month,
           SUM(amount) AS revenue
    FROM clinic_sales
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
) r
LEFT JOIN (
    SELECT strftime('%m', datetime) AS month,
           SUM(amount) AS expense
    FROM expenses
    WHERE strftime('%Y', datetime) = '2021'
    GROUP BY month
) e
ON r.month = e.month;


SELECT city, clinic_name, profit
FROM (
    SELECT cl.city,
           cl.clinic_name,
           (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) AS profit,
           RANK() OVER (
               PARTITION BY cl.city
               ORDER BY (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) DESC
           ) AS rnk
    FROM clinics cl
    JOIN clinic_sales cs ON cl.cid = cs.cid
    LEFT JOIN expenses e ON cl.cid = e.cid
    WHERE strftime('%Y', cs.datetime) = '2021'
    GROUP BY cl.city, cl.clinic_name
)
WHERE rnk = 1;


SELECT state, clinic_name, profit
FROM (
    SELECT cl.state,
           cl.clinic_name,
           (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) AS profit,
           RANK() OVER (
               PARTITION BY cl.state
               ORDER BY (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) ASC
           ) AS rnk
    FROM clinics cl
    JOIN clinic_sales cs ON cl.cid = cs.cid
    LEFT JOIN expenses e ON cl.cid = e.cid
    WHERE strftime('%Y', cs.datetime) = '2021'
    GROUP BY cl.state, cl.clinic_name
)
WHERE rnk = 2;