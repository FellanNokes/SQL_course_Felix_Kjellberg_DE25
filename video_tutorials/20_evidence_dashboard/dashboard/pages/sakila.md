# Exploring sakila database

## Films in Sakila

```sql films
SELECT
    title,
    description,
    length,
    release_year
FROM sakila.film;
```

## Top customer
```sql rental
SELECT
    customer,
    SUM(amount) as total_amount,
    COUNT(*) as number_of_rentals,
FROM sakila.rental_customer
GROUP BY customer_id, customer
ORDER BY total_amount desc, number_of_rentals desc
LIMIT 10;
```

<BarChart
    data={rental}
    title="Top customers measured by total amount paid"
    x=customer
    y=total_amount
    swapXY= true
/>

```sql rent

FROM sakila.rental_customer;
```

## Analyzing payments

Choose your store
<Dropdown data={rent} name=store value=store_id
title="select a store" defaultValue="1">
</Dropdown>

You have picked store {inputs.store.value}

```sql customer
SELECT
    date_trunc('day', payment_date) as pay_date,
    SUM(amount) AS total_amount
FROM sakila.rental_customer
WHERE store_id = ${inputs.store.value} and payment_date between '2005-05-01' and '2005-09-01'
GROUP BY pay_date
```

<LineChart
    data={customer}
    x = pay_date
    y = total_amount
    xAxisTitle = "total amount"
    yAxisTitle = "payment date"
    title = "payment over time for store {inputs.store.value}"
/>