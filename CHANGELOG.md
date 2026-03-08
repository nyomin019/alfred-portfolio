# Changelog

All notable changes to Alfred are documented here.

---

## [Mar 2026] — Co-Manager Integration

### Added
- **Claude Code co-manager**: Claude Code now acts as strategic manager alongside Alfred. Planning, architecture, and multi-step task execution handled by Claude; Alfred handles real-time communication and scheduled jobs.
- **MANAGER.md shared planning layer**: Shared task file (`workspace-online/MANAGER.md`) used by both Claude and Alfred for handoff coordination.
- **Gmail auth restored**: Fixed broken OAuth link between Alfred and `nyomin019@gmail.com` using `gog auth add`.
- **Chrome extension relay auth fix**: Patched `background.js` to pass relay token as query param (`?token=...`) since browser WebSocket API cannot set custom headers. Token derived via `HMAC-SHA256(gateway_token, "openclaw-extension-relay-v1:18792")`.
- **Income pipeline setup**: Fiverr (alfredforge), Gumroad, Reddit r/forhire all staged for launch.
- **LinkedIn automation**: Cron posts drafts Mon/Wed/Fri 9AM. 13 drafts queued in `linkedin-drafts.md`.

### Changed
- Browser automation split into two profiles: `openclaw` (Alfred's) on port 18800, `chrome` (extension relay) on port 18792.
- Relay auth now uses query param instead of header to support browser WebSocket clients.

---

## [Feb 2026] — Multi-Model Routing + Voice + Options Research

### Added
- **Multi-model AI routing**: MiniMax M2.5 (default), Gemini Flash (research/web/images), Claude Haiku (reasoning), local qwen2.5:32b (private/Notion).
- **Voice message transcription**: Telegram voice notes transcribed via `mlx-whisper` (Apple Silicon optimised).
- **Options trading research**: Alerts and signal summaries from market data.
- **Daily crypto price alerts**: Every 4 hours — price + buy zone notifications to Telegram.
- **RMIT Career Connect reminders**: Auto-scrapes and alerts on new events.
- **Notion full integration**: Tasks, Events, Job Applications databases all synced.
- **Morning dashboard**: 6AM daily — tasks, events, crypto, job leads in one message.
- **Self-build system**: 2AM nightly cron executes Alfred's queued build tasks autonomously.

### Changed
- Moved from single-model to intelligent routing based on task type.
- Local qwen2.5:32b reserved for private/Notion operations (no data leaves machine).

---

## [Jan 2026] — Initial Build

### Added
- Alfred agent on OpenClaw (Node.js framework).
- Telegram primary channel, Discord secondary.
- Notion task management with due-date tracking.
- Basic cron scheduler for reminders.
- Brave search integration for web queries.
- Gmail read/send via Google API.
