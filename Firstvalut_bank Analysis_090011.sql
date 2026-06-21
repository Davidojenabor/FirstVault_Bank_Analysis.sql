-- Data Familiarization

-- Customer Directory

SELECT full_name,
email,
phone, 
joined_date
FROM customers
ORDER BY full_name
;

-- Active Accounts Only

SELECT account_id,
		Customer_id,
	account_type,
	balance
FROM accounts
WHERE status = 'Active'
;

-- High Balance Accounts

SELECT account_id,
	account_type,
	balance
FROM accounts
WHERE balance > 2000000.00
ORDER BY balance DESC
;

SELECT c.full_name,
		c.email,
		c.phone,
		c.occupation,
	a.account_id,
	a.account_type,
	a.balance
FROM customers c
JOIN accounts a
		ON c.customer_id = a.customer_id
WHERE a.balance > 2000000.00
GROUP BY c.customer_id,
a.account_id
ORDER BY a.balance DESC
;


-- Loan Default Flag

SELECT loan_id,
customer_id,
loan_type,
principal,
due_date
FROM loans
WHERE status = 'Defaulted'
;

-- Customer Account Analysis

-- Accounts per Customers

SELECT customer_id,
COUNT(*) account_count
FROM accounts
GROUP BY customer_id
ORDER BY account_count DESC
;

SELECT c.full_name,
c.email,
a.customer_id,
COUNT(*) account_count
FROM customers c 
JOIN accounts a
	ON c.customer_id = a.customer_id
GROUP BY a.customer_id
ORDER BY account_count DESC
;


-- Customer Summary

SELECT c.full_name,
	a.account_type,
	a.balance,
	a.status
FROM customers c
JOIN accounts a
	ON c.customer_id = a.customer_id
WHERE a.status = 'Active'
ORDER BY a.balance DESC
;


-- Total Deposits vs Withdrawals

SELECT txn_type,
SUM(amount) Total_amount,
COUNT(*) txn_count
FROM transactions
GROUP BY txn_type
ORDER BY Total_amount
;


-- Branch Customer Count

SELECT b.branch_name,
COUNT(c.customer_id) Customer_count
FROM branches b
JOIN customers c
	ON b.branch_id = c.branch_id
GROUP BY branch_name
ORDER BY Customer_count DESC
;


-- Top 5 Customers by Transaction Volume

SELECT a.account_id,
c.full_name,
SUM(t.amount) Total_txn_value
FROM accounts a
JOIN transactions t
	ON t.account_id = a.account_id
JOIN customers c
	ON a.customer_id = c.customer_id
GROUP BY  a.account_id,
c.full_name
ORDER BY Total_txn_value DESC
LIMIT 5
; 


-- Customers with No Loans

SELECT c.full_name,
c.occupation 
FROM customers c
JOIN loans l
	ON c.customer_id = l.customer_id
WHERE l.loan_id IS NULL
;


-- Total Loan Exposure Per Loan Type

SELECT loan_type,
SUM(principal) Total_exposure
FROM loans
WHERE status = 'Active'
GROUP BY loan_type
ORDER BY Total_exposure DESC
;


-- Monthly Transaction Trend

SELECT DATE_FORMAT(txn_date,'%Y-%m') Month,
SUM(amount) Total_amount,
COUNT(*) txn_count
FROM transactions
WHERE YEAR(txn_date) = 2024
GROUP BY Month
ORDER BY Month
;

SELECT MONTHNAME(txn_date) Month,
SUM(amount) Total_amount,
COUNT(*) txn_count
FROM transactions
GROUP BY Month
ORDER BY Month
;


-- High-Risk Loan Customers

SELECT C.full_name,
l.loan_type,
l.principal,
l.interest_rate
FROM loans l
JOIN customers c
	ON l.customer_id = c.customer_id
WHERE l.interest_rate > 20.00
AND l.principal > 2000000.00
AND l.status = 'Active'
ORDER BY l.interest_rate DESC
;


-- Dormant Account Report

SELECT c.full_name,
b.branch_name,
a.account_type,
a.balance,
a.opened_date
FROM accounts a
JOIN customers c
	ON a.customer_id = c.customer_id
JOIN branches b
	ON c.branch_id = b.branch_id
WHERE a.status = 'Dormant'
GROUP BY a.account_id
Order BY a.balance DESC
;


-- Most USed Transaction Channels

SELECT channel,
COUNT(*) txn_count,
SUM(amount) Total_amount
FROM transactions
GROUP BY channel
ORDER BY txn_count DESC 
;