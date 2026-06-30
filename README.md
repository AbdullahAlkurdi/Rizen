# Rizen

> An AI-powered Life Operating System for discipline, productivity, burnout prevention, and spiritual consistency.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Backend-Firebase-FFCA28?logo=firebase&logoColor=black)
![AI](https://img.shields.io/badge/AI%20Engine-Gemini-4285F4?logo=google&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Development-E94560)
![License](https://img.shields.io/badge/License-Proprietary-lightgrey)

---

## Table of Contents

1. [Overview](#overview)
2. [Core Philosophy](#core-philosophy)
3. [Architecture — The 7 Layers](#architecture--the-7-layers)
4. [Key Differentiators](#key-differentiators)
5. [Tech Stack](#tech-stack)
6. [Design System](#design-system)
7. [Screen Map](#screen-map)
8. [Roadmap](#roadmap)
9. [Repository Structure](#repository-structure)
10. [Multi-Agent Governance](#multi-agent-governance)
11. [Getting Started](#getting-started)
12. [Documentation](#documentation)
13. [License](#license)
14. [Known Open Items](#known-open-items)

---

## Overview

**Rizen** is not a habit tracker. It is an adaptive operating system for human life — built to help users execute what they already know they should do, without decision fatigue, without guilt, and without burnout.

The system integrates worldly productivity (study, work, coding, fitness) with spiritual consistency (prayer-relative scheduling, Quran tracking) into a single AI-coached daily loop.

**Core mission:** Reduce decision fatigue → Increase accountability → Adapt to changing life conditions → Prevent burnout → Sustain growth.

**Primary audience:** Developers, students, knowledge workers, self-improvement enthusiasts.
**Secondary audience:** Professionals, entrepreneurs, faith-driven users.

---

## Core Philosophy

| Principle | Definition |
|---|---|
| **Balance** | Growth must never come at the expense of mental health. |
| **Resilience** | Missing a day is not failure. |
| **Alignment** | Daily actions must support long-term identity. |

---

## Architecture — The 7 Layers

| Layer | Name | Function |
|---|---|---|
| 1 | Identity & Values | Core identity configuration, spiritual layer activation, long-term goal anchoring |
| 2 | Daily OS | Dynamically generated daily routines, micro time-blocking, adaptive schedules |
| 3 | Domain Trackers | Deep logging for 7 pillars: Sports, Study, Work, Coding, Cooking/Nutrition, Spiritual, Custom |
| 4 | Habit Engine | Positive habit building + negative habit breaking (Shadow Habits) |
| 5 | AI Coach | Behavioral diagnostics, pattern recognition, predictive adjustments (Gemini) |
| 6 | Notes & Reflections | Contextual journaling, cognitive unloading |
| 7 | Analytics & Growth | Cross-layer progress tracking, predictive trend charts, growth indexing |

---

## Key Differentiators

| Feature | Mechanism |
|---|---|
| **Prayer-Relative Time-Blocking** | Tasks anchored to solar/prayer times via Aladhan API (e.g., `15 min after Asr`), recalculated nightly per user coordinates |
| **Burnout / Emergency Recovery Mode** | 1-tap collapse of daily routine to survival baseline; streak preserved, not reset |
| **Shadow Habits + Shadow Score** | Quantifies time/energy/focus stolen from the 7 pillars by negative habits |
| **Contextual Voice Logging** | Gemini parses natural-language voice notes into structured tracker updates |
| **AI "Aha!" Onboarding** | Single text/voice input replaces onboarding forms; Gemini auto-configures domains and initial routine |
| **Real-Life Reward Store** | Discipline points unlock real-world rewards (coffee, games, movies) |
| **Passive Sleep Tracking** | First phone unlock event used as waking timestamp; computes "Bed Resistance Metric" |
| **Developer CLI Integration** | `rizen log coding --duration 2h`, `rizen status` — open-source terminal interface |

---

## Tech Stack

| Layer | Technology | Notes |
|---|---|---|
| Frontend | Flutter | iOS, Android, Flutter Web |
| State Management | BLoC / Cubit | Strict presentation/domain/data separation |
| Routing | GoRouter | Declarative navigation |
| Models | Freezed | Immutable data classes |
| Networking | Dio | REST client |
| Backend | Firebase | Firestore, Auth, Cloud Functions |
| AI Engine | Google Gemini | Coaching, parsing, predictive analytics |
| External API | Aladhan API | Prayer time calculation |
| Architecture | Clean Architecture | Feature-first, SOLID principles |

> **Stack is locked.** Do not propose alternatives without explicit sign-off.

---

## Design System

| Token | Value | Usage |
|---|---|---|
| Primary Background | `#1A1A2E` | App base |
| Secondary Background | `#16213E` | Section backgrounds |
| Accent / Card | `#0F3460` | Glassmorphism cards, 16px radius |
| CTA / Action | `#E94560` | Primary buttons, key actions *(pending — see [Known Open Items](#known-open-items))* |

**Typography:** Cairo / IBM Plex Arabic (Arabic), Inter (English)
**Icons:** Phosphor Icons
**Layout rules:** Arabic-first, full RTL support, dark mode only, accessibility-first, large touch targets

---

## Screen Map

Full 73-screen specification lives in [`MASTER_PRODUCT_SPEC.md`](./MASTER_PRODUCT_SPEC.md). Summary:

| Category | Screens |
|---|---|
| Auth & Onboarding | 8 |
| Dashboard & Home | 6 |
| Routine Builder | 8 |
| Domain Trackers (7 pillars × 2) | 14 |
| Habit Engine | 10 |
| AI Coach | 7 |
| Notes & Reflections | 6 |
| Analytics & Progress | 5 |
| Settings & Profile | 9 |
| **Total** | **73** |

---

## Roadmap

22-week implementation plan, locked:

| Phase | Weeks | Scope |
|---|---|---|
| 0 | 1–2 | Onboarding, auth, shell navigation, DB handshakes |
| 1 | 3–5 | Home dashboard, routine builder, prayer-relative time-blocking |
| 2 | 6–9 | 7 domain trackers + log interfaces |
| 3 | 10–12 | Habit engine, shadow habits, reward store, burnout mode |
| 4 | 13–15 | AI Coach, voice parser, passive sleep tracking |
| 5 | 16–17 | Notes engine, growth analytics |
| 6 | 18–19 | Native widgets, cross-platform polish, beta |
| 7 | 20–22 | Web deployment, CLI release, launch |

---

## Project Status

All phases complete. Rizen is prepared for beta release across all platforms.

| Phase | Status |
|-------|--------|
| Phase 0 — Foundation | ✅ Complete |
| Phase 1 — Daily OS | ✅ Complete |
| Phase 2 — Domain Trackers | ✅ Complete |
| Phase 3 — Habit Engine | ✅ Complete |
| Phase 4 — AI Coach | ✅ Complete |
| Phase 5 — Analytics | ✅ Complete |
| Phase 6 — Native Polish | ✅ Complete |
| Phase 7 — Web & CLI | ✅ Complete |

---

## Repository Structure

```
Rizen/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── network/
│   │   ├── errors/
│   │   ├── utils/
│   │   └── di/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── dashboard/
│   │   ├── routine_builder/
│   │   ├── domain_trackers/
│   │   ├── habit_engine/
│   │   ├── ai_coach/
│   │   ├── notes/
│   │   ├── analytics/
│   │   └── settings/
│   ├── l10n/
│   └── main.dart
├── assets/
├── test/
├── docs/
│   ├── PROJECT_KNOWLEDGE.md
│   └── MASTER_PRODUCT_SPEC.md
├── AGENTS.md
├── CLAUDE.md
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

Each `features/<name>/` folder enforces strict `data / domain / presentation` separation. No cross-feature imports outside `core/`.

---

## Multi-Agent Governance

This repo is developed in parallel by multiple AI coding agents (Claude Code, Antigravity CLI, Codex, Kilo).

| Rule | Enforcement |
|---|---|
| Cross-tool standard | `AGENTS.md` |
| Claude Code pointer | `CLAUDE.md` |
| Branch naming | `agent/<tool>/<feature>` (e.g. `agent/claude-code/habit-engine`) |
| Dependency installs | `flutter pub get --enforce-lockfile` — **never** plain `pub get` or `pub upgrade` |
| Core package versions | Exact-pinned in `pubspec.yaml` |
| Lockfile | `pubspec.lock` is committed and treated as law |

---

## Getting Started

### Prerequisites
- Flutter SDK (version pinned in `pubspec.lock` — do not install a newer channel without team sign-off)
- Firebase CLI + FlutterFire CLI
- A Gemini API key
- Git

### Setup

```bash
# 1. Clone
git clone https://github.com/<your-org>/Rizen.git
cd Rizen

# 2. Install dependencies (lockfile-enforced — mandatory)
flutter pub get --enforce-lockfile

# 3. Configure Firebase
flutterfire configure

# 4. Add secrets (never commit these)
cp .env.example .env
# populate GEMINI_API_KEY in .env

# 5. Run
flutter run
```

### Required `.gitignore` entries

```
.env
google-services.json
GoogleService-Info.plist
**/firebase_options.dart
*.lock.bak
```

---

## Documentation

| Document | Purpose |
|---|---|
| [`PROJECT_KNOWLEDGE.md`](./docs/PROJECT_KNOWLEDGE.md) | Product overview, philosophy, layers, success metrics |
| [`MASTER_PRODUCT_SPEC.md`](./docs/MASTER_PRODUCT_SPEC.md) | Full 73-screen UX spec, tech stack, design tokens, roadmap |
| `AGENTS.md` | Cross-agent development governance |
| `CLAUDE.md` | Claude Code-specific instructions |

---

## Web Deployment

Live preview: [https://rizen.app](https://rizen.app)

Hosted on Firebase Hosting with automatic preview deployments on pull requests.

## CLI

Installation:
```bash
cd cli
dart pub get
```

Quick start:
```bash
dart run rizen login
dart run rizen status
dart run rizen log coding --duration 2h --notes "Completed API layer"
```

Full CLI documentation: [`cli/README.md`](./cli/README.md).

---

## Security

Please report security vulnerabilities to:
**security@rizen.app**

See [SECURITY.md](SECURITY.md) for full security policy.

## Privacy

We take your data seriously.
See [PRIVACY.md](PRIVACY.md) for privacy policy.

## License

This project is proprietary software.
See [LICENSE](LICENSE) for full license agreement.

Enterprise licenses available upon request.

## Known Open Items

| Item | Status |
|---|---|
| CTA color conflict — finalized app icon uses solid blue; design system specifies `#E94560` | **Pending decision** — must resolve before UI scales across 73 screens |

---

*Rizen — a Life Operating System for sustainable discipline, balance, resilience, and long-term growth.*
