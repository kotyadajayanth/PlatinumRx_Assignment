SELECT user_id, room_no
FROM bookings b
WHERE booking_date = (
    SELECT MAX(booking_date)
    FROM bookings
    WHERE user_id = b.user_id
);

SELECT b.booking_id, SUM(bc.item_quantity * i.item_rate) total_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%m', b.booking_date) = '11'
GROUP BY b.booking_id;


SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%m', bc.bill_date) = '10'
  AND strftime('%Y', bc.bill_date) = '2021'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;


SELECT month, item_name, total_qty
FROM (
    SELECT 
        strftime('%m', bc.bill_date) AS month,
        i.item_name,
        SUM(bc.item_quantity) AS total_qty,
        RANK() OVER (
            PARTITION BY strftime('%m', bc.bill_date)
            ORDER BY SUM(bc.item_quantity) DESC
        ) AS rnk_high,
        RANK() OVER (
            PARTITION BY strftime('%m', bc.bill_date)
            ORDER BY SUM(bc.item_quantity) ASC
        ) AS rnk_low
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY month, i.item_name
)
WHERE rnk_high = 1 OR rnk_low = 1;


SELECT month, user_id, total_amount
FROM (
    SELECT 
        strftime('%m', bc.bill_date) AS month,
        b.user_id,
        SUM(bc.item_quantity * i.item_rate) AS total_amount,
        RANK() OVER (
            PARTITION BY strftime('%m', bc.bill_date)
            ORDER BY SUM(bc.item_quantity * i.item_rate) DESC
        ) AS rnk
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY month, b.user_id
)
WHERE rnk = 2;