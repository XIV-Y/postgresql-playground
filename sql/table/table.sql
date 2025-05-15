CREATE TABLE IF NOT EXISTS test_table (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  balance DECIMAL(15,2) NOT NULL CHECK (balance >= 0)
);

ALTER TABLE test_table
  ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- DROP TABLE IF EXISTS test_table;

-- INSERT INTO test_table (name, balance) 
-- VALUES 
--   ('Jane Smith', 2500.50),
--   ('Robert Johnson', 750.25),
--   ('Lisa Brown', 3200.00);

-- UPDATE test_table
-- SET balance = 1200.00
-- WHERE id = 1;

EXPLAIN ANALYZE SELECT id, name, balance
  FROM test_table
  WHERE balance > 100.00;

select * from accounts;

WITH high_balance_customers AS (
  SELECT id, name, balance
  FROM test_table
  WHERE balance > 100.00
)
SELECT * FROM high_balance_customers ORDER BY balance DESC;