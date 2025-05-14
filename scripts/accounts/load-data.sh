#!/bin/bash

# CSVファイルのパスを確認
echo "CSVファイルの存在を確認します..."
ls -la /data/
ls -la /data/accounts.csv

# テンポラリSQLファイルを作成
cat > /tmp/load_commands.sql << EOL
\copy accounts(name, balance) FROM '/data/accounts.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 確認クエリ
SELECT COUNT(*) AS total_rows FROM accounts;
SELECT * FROM accounts LIMIT 5;
EOL

# SQLファイルを実行
PGPASSWORD=password psql -h localhost -U postgres -d mydatabase -f /tmp/load_commands.sql

echo "データロード完了!"