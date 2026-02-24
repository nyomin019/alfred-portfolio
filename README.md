# Alfred — Personal AI Assistant

A self-hosted AI assistant running on Mac Studio M2 Max, built with OpenClaw.

## Overview

Alfred is a personal AI assistant that helps with daily productivity, task management, research, and automation. Built as a portfolio project demonstrating full-stack development skills.

**Live Demo:** https://nyomin019.github.io/todo-app/ (example deployment)

---

## The Problem

Managing multiple responsibilities as a CS student:
- Tracking tasks across Notion, Things, Reminders
- Monitoring crypto markets and trading alerts
- Job hunting across multiple platforms
- Need for automated reminders and research

## The Solution

A self-hosted AI assistant that:
- Integrates with Notion, Gmail, Telegram, Discord
- Runs autonomously on a home server (Mac Studio)
- Handles scheduling, reminders, research
- Can be extended with custom skills

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| **Runtime** | OpenClaw (Node.js) |
| **LLM** | MiniMax M2.5, Gemini Flash, Claude Haiku |
| **Local Speech** | Whisper (mlx-whisper) |
| **APIs** | Notion, Gmail, Telegram, Discord, GitHub |
| **Host** | Mac Studio M2 Max (arm64) |
| **Deployment** | GitHub Pages, Vercel |

---

## Features

### ✅ Implemented
- **Task Management** — Notion database sync, cron reminders
- **Crypto Alerts** — Price monitoring with buy zone alerts
- **Job Hunting** — Auto-search Seek/Indeed/LinkedIn, add to Notion
- **Morning Dashboard** — Daily summary of tasks, events, market
- **Voice Messages** — Transcribe Telegram voice notes
- **LinkedIn Drafts** — AI-generated post ideas for career building
- **Self-Build System** — Alfred builds itself from a task queue

### 🔄 In Progress
- Calendar integration
- Auto-follow-up on job applications

---

## Architecture

```
┌─────────────────────────────────────────────┐
│              OpenClaw Gateway               │
│         (Mac Studio M2 Max)                 │
├─────────────────────────────────────────────┤
│  ┌─────────┐ ┌─────────┐ ┌─────────────┐  │
│  │ Telegram │ │ Discord │ │  Webchat    │  │
│  └────┬────┘ └────┬────┘ └──────┬──────┘  │
│       │           │              │          │
│  ┌────▼───────────▼──────────────▼────┐    │
│  │         Alfred (Agent)              │    │
│  │  • Memory & Context               │    │
│  │  • Skills (Notion, GitHub, etc)   │    │
│  │  • Cron Jobs                       │    │
│  └────────────┬───────────────────────┘    │
│               │                             │
│  ┌────────────▼───────────────────────┐    │
│  │         External APIs              │    │
│  │  • Notion (Tasks, Events, Jobs)   │    │
│  │  • Gmail                          │    │
│  │  • GitHub                         │    │
│  └───────────────────────────────────┘    │
└─────────────────────────────────────────────┘
```

---

## Key Files

| File | Purpose |
|------|---------|
| `AGENTS.md` | Agent instructions and system config |
| `SOUL.md` | Persona and mission statement |
| `memory/` | Persistent context and learnings |
| `skills/` | Custom skill modules |

---

## Skills & Integrations

- **Notion** — Task & event management
- **Gmail** — Email reading and sending
- **GitHub** — Repo management, CI/CD
- **Apple Reminders** — Native reminder sync
- **Things 3** — Task management app
- **Weather** — Forecasting
- **Web Search** — Brave API research

---

## Development

### Prerequisites
- Node.js 18+
- macOS (for Apple integrations)
- API keys: Notion, OpenAI/Gemini, GitHub, Brave

### Setup
```bash
# Install dependencies
npm install

# Run locally
openclaw start

# View logs
openclaw status
```

---

## Results

- ✅ Deployed multiple projects to GitHub Pages
- ✅ Automated job search saves ~1hr/week
- ✅ Morning dashboard improves daily focus
- ✅ Self-building system demonstrates autonomous agents

---

## Future Plans

1. **Phase 2 (May 2026)** — Upgrade Notion with calendar sync
2. **Voice TTS** — Alfred speaks reminders aloud
3. **Claude Code** — Autonomous coding agent
4. **Trading Bot** — Execute trades from chat

---

## Contact

- **Author:** Nyo Min
- **Location:** Melbourne, Australia
- **GitHub:** github.com/nyomin019
- **LinkedIn:** linkedin.com/in/nyomin

---

*Built as a learning project while studying CS at RMIT Melbourne.*
