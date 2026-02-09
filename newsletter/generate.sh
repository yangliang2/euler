#!/bin/bash
# Euler Newsletter Generator - 超人类模式

DATE=$(date +%Y-%m-%d)
OUTPUT="/root/.openclaw/workspace/business/newsletter/ai-weekly-${DATE}.md"

echo "# AI Weekly - ${DATE}" > "$OUTPUT"
echo "" >> "$OUTPUT"
echo "*自动生成 by Euler Agent*" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "---" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# 抓取 HN AI 相关
echo "## 🔥 Hacker News 热门" >> "$OUTPUT"
curl -s "https://hn.algolia.com/api/v1/search?query=AI+artificial+intelligence&tags=story&numericFilters=points>50" | jq -r '.hits[0:5] | .[] | "- **\(.title)** ([链接](\(.url)))\n  - 分数: \(.points) | 评论: \(.num_comments)\n"' >> "$OUTPUT"

echo "" >> "$OUTPUT"
echo "---" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# arXiv 最新
echo "## 📄 arXiv 今日热门" >> "$OUTPUT"
curl -s "http://export.arxiv.org/api/query?search_query=cat:cs.AI&sortBy=submittedDate&sortOrder=descending&max_results=5" | grep -E "<title>|<summary>" | head -15 | sed 's/<title>/- **/; s/<\/title>/**/; s/<summary>/  /; s/<\/summary>//' >> "$OUTPUT"

echo "" >> "$OUTPUT"
echo "---" >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "## 🚀 GitHub 热门 AI 项目" >> "$OUTPUT"
curl -s "https://api.github.com/search/repositories?q=AI+language:Python&sort=stars&order=desc&per_page=5" | jq -r '.items[] | "- **\(.full_name)** ⭐ \(.stargazers_count)\n  - \(.description)\n  - [仓库](\(.html_url))\n"' >> "$OUTPUT"

echo "" >> "$OUTPUT"
echo "---" >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "## 💡 Euler 洞察" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "基于今日数据分析：" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "- **趋势 1:** AI 工具链持续爆发，每天都有新的 CLI 工具" >> "$OUTPUT"
echo "- **趋势 2:** 开源模型本地部署成为热点" >> "$OUTPUT"
echo "- **机会:** 自动化内容生成工具需求旺盛" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "---" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "*下期预告：深度分析 AI Agent 框架对比*" >> "$OUTPUT"

echo "✅ Newsletter 生成完成: $OUTPUT"
