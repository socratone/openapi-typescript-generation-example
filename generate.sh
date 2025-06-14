#!/bin/bash

SWAGGER_URL="https://petstore.swagger.io/v2/swagger.json"

echo "🐳 현재 사용중인 실행 환경은 다음과 같습니다."
echo 
uname -a
echo

echo "🌳 node version: $(node -v)"
echo 

echo "📦 필요한 패키지를 설치합니다."
pnpm install
echo

echo "💾 타입 생성에 필요한 openapi.json 파일을 $SWAGGER_URL 에서 다운로드합니다."
echo
 
# openapi.json 다운로드, 에러 시 종료
# -s : silent 모드
# -S : 에러 발생 시 에러 메시지 출력
# -f : 파일이 없을 때 에러 메시지 출력
curl -sSf "$SWAGGER_URL" -o openapi.json

# curl 명령어 실패 시 스크립트 종료
if [ $? -ne 0 ]; then
  echo "❌ openapi.json 다운로드 실패"
  exit 1
fi

./check_json.sh "openapi.json"
echo

# check_json.sh 명령어 실패 시 스크립트 종료
if [ $? -ne 0 ]; then
  echo "❌ JSON 유효성 검사 실패"
  exit 1
fi

echo "📄 다운 받은 openapi.json 파일 내용 일부는 다음과 같습니다."
echo

head -n 1 "openapi.json" | cut -c 1-300 | sed 's/$/.../'
echo

echo "✏️ openapi-ts를 이용해서 코드를 생성합니다."
pnpm exec openapi-ts \
  -i openapi.json \
  -o src/generated \
  -c @hey-api/client-fetch