# Alfred — Personal AI Assistant

[![GitHub last commit](https://img.shields.io/github/last-commit/nyomin019/alfred-portfolio)](https://github.com/nyomin019/alfred-portfolio/commits/main)
[![License](https://img.shields.io/github/license/nyomin019/alfred-portfolio)](https://github.com/nyomin019/alfred-portfolio/blob/main/LICENSE)

A self-hosted AI assistant running on Mac Studio M2 Max, built with [OpenClaw](https://github.com/nicknds/OpenClaw). This project demonstrates full-stack development skills, API integrations, and autonomous agent design.

---

## 🚀 Latest Updates (Feb 2026)

- ✅ Multi-model AI routing (MiniMax, Gemini, Claude, local qwen)
- ✅ Options trading research & alerts
- ✅ Voice message transcription (mlx-whisper)
- ✅ Notion integration for tasks, events, job applications
- ✅ Daily crypto price alerts & buy zones
- ✅ RMIT Career Connect event reminders

---

## 🎯 Overview

Alfred is a personal AI assistant that helps with daily productivity, task management, research, and automation. It integrates with Notion, Gmail, Telegram, Discord, and runs autonomously on a home server.

### The Problem

Managing multiple responsibilities as a CS student in Melbourne:
- Tracking tasks across Notion, Things, Reminders
- Monitoring crypto markets and trading alerts
- Job hunting across multiple platforms (Seek, Indeed, LinkedIn)
- Need for automated reminders and research

### The Solution

A self-hosted AI assistant that:
- Integrates with Notion, Gmail, Telegram, Discord, GitHub
- Runs autonomously on a home server (Mac Studio)
- Handles scheduling, reminders, research
- Can be extended with custom skills

---

## 🏗️ Architecture

### High-Level System Design

```
┌────────────────────────────────────────────────────────────────────────┐
│                        ALFRED SYSTEM ARCHITECTURE                       │
│                      (Mac Studio M2 Max, arm64)                        │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│  ┌─────────────────────── CHANNEL LAYER ───────────────────────────┐  │
│  │                                                                  │  │
│  │   ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌─────────┐  │  │
│  │   │ Telegram │    │ Discord  │    │  Webchat │    │  Cron   │  │  │
│  │   │  (Primary)   │  (Secondary)  │          │    │ Jobs    │  │  │
│  │   └────┬─────┘    └────┬─────┘    └────┬─────┘    └────┬────┘  │  │
│  │        │                │                │              │       │  │
│  │        └────────────────┴────────┬───────┴──────────────┘       │  │
│  │                                   │                               │  │
│  └───────────────────────────────────▼───────────────────────────────┘  │
│                                      │                                   │
│  ┌──────────────────────────────────▼───────────────────────────────┐  │
│  │                      OPENCLAW GATEWAY                             │  │
│  │  ┌─────────────────────────────────────────────────────────────┐ │  │
│  │  │                    ALFRED AGENT                             │ │  │
│  │  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐  │ │  │
│  │  │  │   Context    │  │    Skills    │  │    Cron Jobs    │  │ │  │
│  │  │  │   Manager    │  │   Registry   │  │    Scheduler     │  │ │  │
│  │  │  └──────────────┘  └──────────────┘  └──────────────────┘  │ │  │
│  │  └─────────────────────────────────────────────────────────────┘ │  │
│  └──────────────────────────────────┬───────────────────────────────┘  │
│                                     │                                   │
│  ┌──────────────────────────────────▼───────────────────────────────┐  │
│  │                      SKILL LAYER (Tools)                          │  │
│  │                                                                       │  │
│  │   ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────────┐   │  │
│  │   │  Notion  │  │  Gmail   │  │ GitHub   │  │   Web Search   │   │  │
│  │   │   API    │  │   API    │  │   API    │  │   (Brave)      │   │  │
│  │   └──────────┘  └──────────┘  └──────────┘  └────────────────┘   │  │
│  │                                                                       │  │
│  │   ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────────┐   │  │
│  │   │  Memory  │  │  Voice   │  │  Image   │  │    Browser     │   │  │
│  │   │  System  │  │   (TTS)  │  │ Analysis │  │   Control      │   │  │
│  │   └──────────┘  └──────────┘  └──────────┘  └────────────────┘   │  │
│  │                                                                       │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

### Component Flow

```
User Message ──► Channel (Telegram) ──► Gateway
                                            │
                                            ▼
                                    ┌───────────────┐
                                    │ Alfred Agent  │
                                    │  (LLM + Tools)│
                                    └───────┬───────┘
                                            │
                         ┌──────────────────┼──────────────────┐
                         │                  │                  │
                         ▼                  ▼                  ▼
                   ┌──────────┐      ┌──────────┐      ┌──────────┐
                   │ Notion   │      │  Gmail   │      │  Memory  │
                   │ API      │      │  API     │      │  System  │
                   └──────────┘      └──────────┘      └──────────┘
```

### Key Components

| Component | Description | Location |
|-----------|-------------|----------|
| **Gateway** | OpenClaw daemon managing connections | Host machine |
| **Alfred Agent** | Main AI agent with skills | `AGENTS.md` |
| **Skills** | Tool integrations (Notion, Gmail, etc.) | `~/.openclaw/skills/` |
| **Memory** | Persistent context & learnings | `memory/` directory |
| **Cron Jobs** | Scheduled automation | Gateway scheduler |
| **Workspace** | Project files & configs | `~/.openclaw/workspace-online/` |

---

## 🛠️ Tech Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Runtime** | OpenClaw (Node.js) | AI agent framework |
| **LLM (Primary)** | MiniMax M2.5 | Default conversation & tasks |
| **LLM (Research)** | Gemini Flash | Web search & images |
| **LLM (Reasoning)** | Claude Haiku | Complex analysis |
| **Local Speech** | Whisper (mlx-whisper) | Voice transcription |
| **Database** | Notion API | Tasks, events, jobs |
| **Email** | Gmail API | Reading & sending |
| **Host** | Mac Studio M2 Max (arm64) | Home server |
| **Channels** | Telegram, Discord | User communication |

---

## ✨ Features

### ✅ Implemented

| Feature | Description | Automation |
|---------|-------------|------------|
| **Task Management** | Notion database sync, due date tracking | Real-time |
| **Morning Dashboard** | Daily summary of tasks, events, crypto | 6AM daily |
| **Crypto Alerts** | Price monitoring with buy zone notifications | Every 4 hours |
| **Job Hunting** | Auto-search Seek/Indeed/LinkedIn | 7AM daily |
| **Voice Messages** | Transcribe Telegram voice notes | On receipt |
| **LinkedIn Drafts** | AI-generated post ideas | Mon/Wed/Fri 9AM |
| **Self-Build System** | Autonomous task queue execution | 2AM nightly |
| **Cron Reminders** | Custom scheduled notifications | Configurable |

### 🔄 In Progress

- Calendar integration with Notion
- Auto-follow-up on job applications

---

## 📁 Project Structure

```
~/.openclaw/
├── workspace-online/          # Main project directory
│   ├── AGENTS.md               # Agent instructions & config
│   ├── SOUL.md                 # Persona & mission
│   ├── TOOLS.md                # Local tool notes
│   ├── memory/                 # Persistent context
│   ├── linkedin-drafts.md      # Draft posts queue
│   └── ...
├── skills/                     # Custom skill modules
├── scripts/                    # Automation scripts
│   ├── price-alert.sh          # Crypto price monitoring
│   ├── transcribe-voice.sh     # Voice message transcription
│   └── job-search.sh           # Job listing aggregator
└── config/                     # Configuration files
```

---

## 🚀 Setup

### Prerequisites

- **Hardware**: Mac with Apple Silicon (M1/M2/M3) or Linux server
- **Software**: Node.js 18+, macOS (for Apple integrations)
- **API Keys**: See Environment Variables below

### Environment Variables

Create `~/.config/openclaw/env`:

```bash
# Required
NOTION_API_KEY=secret_xxxxx
TELEGRAM_BOT_TOKEN=xxxxx
OPENCLAW_API_KEY=xxxxx

# Optional (for enhanced features)
GEMINI_API_KEY=xxxxx
BRAVE_API_KEY=xxxxx
GITHUB_TOKEN=xxxxx
GMAIL_CREDENTIALS=xxxxx
```

### Installation

```bash
# 1. Install OpenClaw
npm install -g @openclaw/openclaw

# 2. Configure credentials
mkdir -p ~/.config/openclaw
cp env.template ~/.config/openclaw/env

# 3. Copy project files
cp -r ./workspace-online/* ~/.openclaw/workspace-online/

# 4. Start the gateway
openclaw gateway start

# 5. Verify status
openclaw gateway status
```

### First-Time Setup

1. **Create Notion Integration**: https://www.notion.so/my-integrations
2. **Share Databases**: Grant access to Tasks, Events, Job Applications databases
3. **Configure Telegram**: Create bot via @BotFather, get token
4. **Test Skills**: Send a message to verify integrations

---

## ⏰ Cron Jobs

Alfred runs these scheduled tasks:

| Job ID | Schedule | Task |
|--------|----------|------|
| e75bf77f | 7AM daily | Job search (Seek, Indeed, LinkedIn) |
| 44378550 | 2AM nightly | Self-build (execute queued tasks) |
| - | 6AM daily | Morning dashboard |
| - | Mon/Wed/Fid 9AM | LinkedIn draft generation |
| - | Every 4 hours | Crypto price alerts |

---

## 🔐 Security Considerations

- **API Keys**: Stored in `~/.config/openclaw/`, not in version control
- **Notion**: Uses internal integration token with limited database access
- **Telegram**: Bot token only, no admin privileges
- **Local Only**: No cloud hosting, runs on local machine

---

## 🔧 Development

### Adding New Skills

1. Create skill file in `~/.openclaw/skills/`
2. Register in `AGENTS.md` under Skills section
3. Test with `openclaw test skill-name`

### Modifying Agent Behavior

Edit `AGENTS.md` to change:
- System prompts
- Skill availability
- Cron schedules

### Debugging

```bash
# View gateway logs
openclaw gateway status

# Check specific cron job
cron runs <job-id>

# Test a skill manually
openclaw test notion
```

---

## 📊 Results & Metrics

- ✅ Deployed multiple projects to GitHub Pages
- ✅ Automated job search saves ~1 hour/week
- ✅ Morning dashboard improves daily focus
- ✅ Self-building system demonstrates autonomous agents
- ✅ Full Notion integration for task/event management

---

## 🗺️ Roadmap

| Phase | Timeline | Features |
|-------|----------|----------|
| **Phase 1** | Done | Tasks, Events, Job Applications databases |
| **Phase 2** | May 2026 | Calendar sync, advanced Notion features |
| **Future** | TBD | Voice TTS, Claude Code, Trading Bot |

---

## 🤝 Contributing

This is a personal portfolio project. Suggestions welcome!

1. Fork the repo
2. Create a feature branch
3. Submit a pull request

---

## 📄 License

MIT License - See LICENSE file for details.

---

## 📬 Contact

- **Author:** Nyo Min
- **Location:** Melbourne, Australia
- **GitHub:** [github.com/nyomin019](https://github.com/nyomin019)
- **LinkedIn:** [linkedin.com/in/nyomin](https://linkedin.com/in/nyomin)

---

*Built as a learning project while studying Computer Science at RMIT Melbourne.*
