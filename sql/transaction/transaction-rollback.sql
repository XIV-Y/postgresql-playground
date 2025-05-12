-- ロールバックのサンプル

-- 現在の残高確認
SELECT * FROM accounts;

-- トランザクション開始
BEGIN;

UPDATE accounts SET balance = balance - 15000 WHERE name = '山田太郎';
UPDATE accounts SET balance = balance + 15000 WHERE name = '佐藤花子';

-- エラーが発生しても明示的にロールバック
ROLLBACK;

-- ロールバック後のデータ確認（変更が取り消されている）
SELECT * FROM accounts;

-- 別の正常なトランザクション
BEGIN;
UPDATE accounts SET balance = balance - 1000 WHERE name = '山田太郎';
UPDATE accounts SET balance = balance + 1000 WHERE name = '佐藤花子';
COMMIT;

-- コミット後のデータ確認
SELECT * FROM accounts;