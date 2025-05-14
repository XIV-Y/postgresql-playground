BEGIN;

SELECT * FROM accounts WHERE name = '山田太郎' FOR UPDATE;
-- この時点で、他のトランザクションが同じ行をロックしようとすると待機状態になる

SELECT pg_sleep(20);

-- 別の箇所で別途この SQL を流すとこのトランザクションが完了するまで待機状態になる
-- UPDATE accounts SET balance = balance - 100 WHERE name = '山田太郎';

-- 残高を更新
UPDATE accounts SET balance = balance - 5000 WHERE name = '山田太郎';
UPDATE accounts SET balance = balance + 5000 WHERE name = '佐藤花子';

-- コミットするまで他のトランザクションは待機
COMMIT;