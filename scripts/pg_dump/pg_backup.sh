#!/bin/bash

# 設定変数
CONTAINER_NAME="my-postgres"
DB_USER="postgres"
DB_NAME="mydatabase"
BACKUP_DIR="./backups"
BACKUP_FILE="${BACKUP_DIR}/backup_$(date +%Y%m%d_%H%M%S).sql"

# バックアップディレクトリの作成
mkdir -p $BACKUP_DIR

# バックアップの実行
echo "PostgreSQLデータベースのバックアップを開始します..."
docker exec -i $CONTAINER_NAME pg_dump -U $DB_USER -d $DB_NAME > $BACKUP_FILE

# 結果確認
if [ $? -eq 0 ]; then
    echo "バックアップが正常に完了しました: $BACKUP_FILE"
else
    echo "バックアップ中にエラーが発生しました"
    exit 1
fi