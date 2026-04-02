#!/bin/bash

# このスクリプトは、ファイルが変更されたら自動的に日付を更新し、
# git commit & push を実行します。

while true; do
  # 変更があるか確認（index.html の日付更新そのものでループしないよう配慮）
  STATUS=$(git status --porcelain)
  
  if [ -n "$STATUS" ]; then
    echo "$(date): 変更を検知しました。更新処理を開始します..."

    # index.html の最終更新日時をJSTで更新
    # macOS の date コマンドと sed の書式に合わせています
    CURRENT_TIME=$(TZ=Asia/Tokyo date +"%Y/%m/%d %H:%M")
    
    # 最終更新日時を置換
    sed -i '' "s/最終更新: [0-9\/ :]* (JST)/最終更新: $CURRENT_TIME (JST)/" index.html
    
    # Git 操作
    git add .
    git commit -m "Auto update: $CURRENT_TIME"
    
    echo "プッシュ中..."
    git push
    
    echo "完了。次の変更を待機します..."
  fi
  
  sleep 5
done
