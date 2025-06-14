#!/bin/bash
# check_json.sh - JSON 유효성 검사 스크립트
# 사용법: ./check_json.sh <json 파일 경로>

if [ "$#" -ne 1 ]; then
  echo "❌ 사용법: $0 <json 파일 경로>"
  exit 1
fi

FILE=$1

if [ ! -f "$FILE" ]; then
  echo "❌ 파일이 존재하지 않습니다: $FILE"
  exit 1
fi

if jq empty "$FILE" 2>/dev/null; then
  echo "✅ 유효한 JSON 파일입니다."
  exit 0
else
  echo "❌ 유효하지 않은 JSON 파일입니다."
  exit 1
fi
