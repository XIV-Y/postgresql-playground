#!/bin/bash

# 設定変数
CONTAINER_NAME="my-postgres"
DB_USER="postgres"
DB_NAME="mydatabase"

# 引数チェック
if [ $# -ne 1 ]; then
    echo "使用方法: $0 <バックアップファイルのパス>"
    exit 1
fi

BACKUP_FILE=$1

# ファイルの存在確認
if [ ! -f "$BACKUP_FILE" ]; then
    echo "エラー: バックアップファイル '$BACKUP_FILE' が見つかりません"
    exit 1
fi

# 復元の実行
echo "PostgreSQLデータベースの復元を開始します..."
cat $BACKUP_FILE | docker exec -i $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME

# 結果確認
if [ $? -eq 0 ]; then
    echo "復元が正常に完了しました"
else
    echo "復元中にエラーが発生しました"
    exit 1
fi