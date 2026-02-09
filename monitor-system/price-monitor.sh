#!/bin/bash
# 竞品价格监控系统 MVP

TARGET_DIR="/root/.openclaw/workspace/business/monitor-system"
mkdir -p "$TARGET_DIR/data"

# 监控列表
declare -A PRODUCTS
PRODUCTS=(
    ["openai"]="https://openai.com/pricing"
    ["anthropic"]="https://www.anthropic.com/pricing"
    ["google-ai"]="https://ai.google.dev/pricing"
)

# 抓取价格页面
echo "[$(date)] 开始价格监控..." > "$TARGET_DIR/log.txt"

for name in "${!PRODUCTS[@]}"; do
    url="${PRODUCTS[$name]}"
    output="$TARGET_DIR/data/${name}-$(date +%Y%m%d).html"
    
    curl -s "$url" > "$output"
    echo "[$(date)] 抓取 $name 完成" >> "$TARGET_DIR/log.txt"
done

echo "[$(date)] 监控完成" >> "$TARGET_DIR/log.txt"
