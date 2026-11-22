#!/usr/bin/env bash
# 常用组合：把一批报表统一成「2026-11-22_销售_001.xlsx」这种格式
# 先跑一遍看计划，确认后再加 --apply
set -euo pipefail
DIR="${1:-./报表}"

python3 batchrename.py "$DIR" \
  --replace "副本=" \
  --replace "(1)=" \
  --strip-space \
  --date \
  --prefix 销售_ \
  --seq 1 --seq-width 3

echo
echo "确认无误后执行："
echo "  python3 batchrename.py \"$DIR\" --replace \"副本=\" --replace \"(1)=\" --strip-space --date --prefix 销售_ --seq 1 --seq-width 3 --apply"
