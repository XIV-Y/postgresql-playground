#!/bin/bash

# run-sql.sh - SQLファイルを実行するスクリプト
# 使用方法: ./run-sql.sh path/to/file.sql [コンテナ名] [データベース名] [ユーザー名]

SQL_FILE=$1
CONTAINER_NAME=${2:-my-postgres}
DB_NAME=${3:-mydatabase}
DB_USER=${4:-postgres}

if [ -z "$SQL_FILE" ]; then
  echo "エラー: SQLファイルを指定してください"
  echo "使用方法: $0 path/to/file.sql [コンテナ名] [データベース名] [ユーザー名]"
  exit 1
fi

if [ ! -f "$SQL_FILE" ]; then
  echo "エラー: ファイル '$SQL_FILE' が見つかりません"
  exit 1
fi

echo "実行中: $SQL_FILE (コンテナ: $CONTAINER_NAME, DB: $DB_NAME, ユーザー: $DB_USER)"

cat "$SQL_FILE" | docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo "成功: SQLファイルの実行が完了しました"
else
  echo "エラー: SQLファイルの実行中に問題が発生しました (終了コード: $EXIT_CODE)"
fi

exit $EXIT_CODE