#!/bin/bash
# price-alert.sh — Alfred crypto price monitor
# Runs every 4 hours via OpenClaw cron scheduler
# Fetches BTC and ETH prices, checks against buy zones, alerts via Telegram
#
# Usage: Called automatically by Alfred cron. Manual: ./price-alert.sh

set -euo pipefail

TELEGRAM_BOT_TOKEN="${TELEGRAM_BOT_TOKEN:-}"
TELEGRAM_CHAT_ID="${TELEGRAM_CHAT_ID:-}"

# Buy zones (approximate — update periodically)
BTC_BUY_ZONE=80000
ETH_BUY_ZONE=2800

send_telegram() {
  local message="$1"
  if [[ -z "$TELEGRAM_BOT_TOKEN" || -z "$TELEGRAM_CHAT_ID" ]]; then
    echo "[price-alert] Telegram not configured, printing to stdout:"
    echo "$message"
    return
  fi
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d "chat_id=${TELEGRAM_CHAT_ID}" \
    -d "text=${message}" \
    -d "parse_mode=Markdown" > /dev/null
}

fetch_price() {
  local coin="$1"
  curl -s "https://api.coingecko.com/api/v3/simple/price?ids=${coin}&vs_currencies=usd" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['${coin}']['usd'])"
}

main() {
  local btc eth message
  btc=$(fetch_price "bitcoin")
  eth=$(fetch_price "ethereum")

  message="*Crypto Alert*\n\nBTC: \$${btc}\nETH: \$${eth}"

  # Buy zone alerts
  if (( $(echo "$btc < $BTC_BUY_ZONE" | bc -l) )); then
    message="${message}\n\n⚠️ BTC in buy zone (<\$${BTC_BUY_ZONE})"
  fi
  if (( $(echo "$eth < $ETH_BUY_ZONE" | bc -l) )); then
    message="${message}\n⚠️ ETH in buy zone (<\$${ETH_BUY_ZONE})"
  fi

  send_telegram "$message"
  echo "[price-alert] Done. BTC=\$${btc} ETH=\$${eth}"
}

main
