#!/bin/bash
# job-search.sh — Alfred automated job search
# Runs at 7AM daily via OpenClaw cron
# Searches Seek, LinkedIn, and GitHub Jobs for matching roles
# Outputs structured results for Alfred to process and send to Telegram
#
# Usage: Called automatically. Manual: ./job-search.sh [role] [location]

set -euo pipefail

ROLE="${1:-junior developer OR data analyst OR AI engineer}"
LOCATION="${2:-Melbourne}"
BRAVE_API_KEY="${BRAVE_API_KEY:-}"
MAX_RESULTS=5

search_brave() {
  local query="$1"
  if [[ -z "$BRAVE_API_KEY" ]]; then
    echo "[]"
    return
  fi
  curl -s "https://api.search.brave.com/res/v1/web/search" \
    -H "X-Subscription-Token: ${BRAVE_API_KEY}" \
    -G \
    --data-urlencode "q=${query}" \
    --data-urlencode "count=${MAX_RESULTS}" \
    | python3 -c "
import sys, json
data = json.load(sys.stdin)
results = data.get('web', {}).get('results', [])
for r in results:
    print(f\"- [{r.get('title','')}]({r.get('url','')})\")
    print(f\"  {r.get('description','')[:100]}\")
"
}

main() {
  echo "=== Job Search: $(date '+%Y-%m-%d %H:%M') ==="
  echo "Role: ${ROLE}"
  echo "Location: ${LOCATION}"
  echo ""

  echo "### Seek"
  search_brave "site:seek.com.au ${ROLE} ${LOCATION}"
  echo ""

  echo "### LinkedIn"
  search_brave "site:linkedin.com/jobs ${ROLE} ${LOCATION}"
  echo ""

  echo "### Indeed"
  search_brave "site:indeed.com ${ROLE} ${LOCATION}"
}

main
