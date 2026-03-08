#!/bin/bash
# transcribe-voice.sh — Alfred voice message transcriber
# Called by OpenClaw when a Telegram voice message is received
# Uses mlx-whisper (Apple Silicon optimised Whisper implementation)
#
# Usage: transcribe-voice.sh <ogg_file_path>
# Output: Prints transcription text to stdout

set -euo pipefail

INPUT_FILE="${1:-}"

if [[ -z "$INPUT_FILE" ]]; then
  echo "Usage: $0 <voice_file.ogg>" >&2
  exit 1
fi

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: file not found: $INPUT_FILE" >&2
  exit 1
fi

# Convert OGG to WAV (Whisper expects WAV/MP3/M4A)
TEMP_WAV=$(mktemp /tmp/alfred-voice-XXXXXX.wav)
trap 'rm -f "$TEMP_WAV"' EXIT

ffmpeg -i "$INPUT_FILE" -ar 16000 -ac 1 "$TEMP_WAV" -y -loglevel quiet

# Transcribe using mlx-whisper (runs on Apple Neural Engine on M-series Macs)
mlx_whisper "$TEMP_WAV" \
  --model mlx-community/whisper-large-v3-turbo \
  --output-format txt \
  --output-dir /tmp/ \
  --language auto 2>/dev/null

# Read and print the transcription
TRANSCRIPT_FILE="${TEMP_WAV%.wav}.txt"
if [[ -f "$TRANSCRIPT_FILE" ]]; then
  cat "$TRANSCRIPT_FILE"
  rm -f "$TRANSCRIPT_FILE"
else
  echo "[transcribe-voice] Transcription file not found" >&2
  exit 1
fi
