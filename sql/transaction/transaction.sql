-- 基本的なトランザクションのサンプル

-- テスト用テーブル作成
DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    balance DECIMAL(15,2) NOT NULL CHECK (balance >= 0)
);

-- 初期データ挿入
INSERT INTO accounts (name, balance) VALUES
    ('山田太郎', 10000),
    ('佐藤花子', 20000);

-- トランザクション開始前のデータ確認
SELECT * FROM accounts;

-- トランザクション開始
BEGIN;

-- 山田太郎から佐藤花子へ5000円振込
UPDATE accounts SET balance = balance - 5000 WHERE name = '山田太郎';
UPDATE accounts SET balance = balance + 5000 WHERE name = '佐藤花子';

-- トランザクション中のデータ確認（別セッションからは見えない）
SELECT * FROM accounts;

-- トランザクションをコミット
COMMIT;

-- コミット後のデータ確認
SELECT * FROM accounts;