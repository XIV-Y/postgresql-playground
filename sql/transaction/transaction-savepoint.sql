-- セーブポイントのサンプル

-- 現在の残高確認
SELECT * FROM accounts;

-- トランザクション開始
BEGIN;

-- 山田太郎の残高を1000円増やす
UPDATE accounts SET balance = balance + 1000 WHERE name = '山田太郎';

-- セーブポイントを設定
SAVEPOINT point_a;

-- 佐藤花子の残高を2000円増やす
UPDATE accounts SET balance = balance + 2000 WHERE name = '佐藤花子';

-- 現在の状態を確認
SELECT * FROM accounts;

-- セーブポイントまでロールバック（佐藤花子への2000円追加だけが取り消される）
ROLLBACK TO SAVEPOINT point_a;

-- ロールバック後の状態確認
SELECT * FROM accounts;

-- 新しい変更を加える
UPDATE accounts SET balance = balance + 500 WHERE name = '佐藤花子';

-- トランザクションをコミット（山田太郎+1000円、佐藤花子+500円が適用される）
COMMIT;

-- 最終的な状態確認
SELECT * FROM accounts;