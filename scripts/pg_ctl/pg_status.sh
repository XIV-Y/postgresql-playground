#!/bin/bash

# PostgreSQL コンテナの状態を確認するスクリプト

CONTAINER_NAME=${1:-my-postgres}

echo "PostgreSQL コンテナ '$CONTAINER_NAME' の状態を確認中..."

if ! docker ps -a | grep -q $CONTAINER_NAME; then
  echo "エラー: '$CONTAINER_NAME' という名前のコンテナが見つかりません"
  exit 1
fi

if ! docker ps | grep -q $CONTAINER_NAME; then
  echo "警告: '$CONTAINER_NAME' コンテナは停止しています"
  exit 2
fi

echo "PostgreSQL サーバー状態:"

docker exec -u postgres $CONTAINER_NAME pg_ctl status -D /var/lib/postgresql/data

STATUS_CODE=$?

exit $STATUS_CODE