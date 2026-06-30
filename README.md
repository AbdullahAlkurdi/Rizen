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


Rizen

«Rizen — A Life Operating System for Sustainable Discipline, Balance, and Growth»

---

Vision

Rizen is not a habit tracker.

It is a complete Life Operating System designed to help people consistently execute what they already know they should do.

The platform combines behavioral psychology, adaptive productivity systems, spiritual alignment, AI coaching, habit engineering, and predictive analytics into a unified ecosystem that evolves with the user over time.

Rizen exists to solve one fundamental problem:

«Humans rarely fail because they lack knowledge.
They fail because they lack a system capable of transforming intentions into consistent action.»

---

Mission

To create the world's most intelligent and adaptive discipline platform that helps users:

- Build sustainable routines
- Strengthen self-discipline
- Prevent burnout
- Improve consistency
- Develop positive habits
- Eliminate destructive behaviors
- Align daily actions with long-term identity
- Balance spiritual and worldly responsibilities

---

Core Philosophy

Rizen is built upon three foundational principles.

Balance

Growth should never come at the expense of mental health, physical wellbeing, spirituality, or relationships.

The system continuously seeks equilibrium across all areas of life.

---

Resilience

Failure is expected.

Missing a day should never destroy months of progress.

The platform is designed around recovery, not perfection.

---

Alignment

Every task, habit, routine, and goal must support the person the user wants to become.

Daily actions should reinforce identity.

---

Product Identity

Item| Value
Product Name| Rizen
System Name| Rizen
Product Category| Life Operating System
Primary Platform| Mobile First
Secondary Platforms| Web Dashboard & CLI
Core Engine| Adaptive Daily Operating System
AI Provider| Google Gemini
Backend| Firebase
Frontend| Flutter

---

The Problem

Modern productivity applications suffer from several critical weaknesses:

- Excessive manual setup
- Static routines
- No behavioral understanding
- No burnout prevention
- Weak accountability systems
- Fragmented life management
- Lack of spiritual integration
- High maintenance overhead

Users often abandon these systems because they create additional work rather than reducing it.

Rizen solves this by creating an adaptive system that evolves automatically based on behavior.

---

The Rizen Framework

The platform operates through seven interconnected layers.

---

Layer 1 — Identity & Values

The foundation of the entire system.

This layer defines:

- Core values
- Life priorities
- Long-term goals
- Personal mission
- Spiritual framework
- Future identity vision

Purpose:

To ensure all future decisions align with the user's desired identity.

---

Layer 2 — Daily Operating System

The execution engine.

Responsible for:

- Daily schedules
- Adaptive routines
- Time-block generation
- Focus sessions
- Daily planning
- Dynamic recalculations

Purpose:

Transform long-term goals into executable daily actions.

---

Layer 3 — Domain Trackers

The life-area management framework.

Supported domains:

1. Sports
2. Study
3. Work
4. Coding
5. Cooking & Nutrition
6. Spiritual
7. Custom Domain

Purpose:

Provide specialized tracking and analytics for each life pillar.

---

Layer 4 — Habit Engine

The behavioral reinforcement layer.

Supports:

- Positive habits
- Negative habits
- Streak systems
- Recovery systems
- Behavioral triggers
- Habit analytics

Purpose:

Create lasting behavioral change.

---

Layer 5 — AI Coach

The intelligence layer.

Powered by Google Gemini.

Responsibilities:

- Behavioral analysis
- Pattern recognition
- Coaching
- Planning
- Diagnostics
- Predictive recommendations

Purpose:

Deliver personalized guidance continuously.

---

Layer 6 — Notes & Reflections

The cognitive unloading layer.

Supports:

- Notes
- Voice notes
- Journaling
- Reflections
- AI summaries
- Semantic search

Purpose:

Capture thoughts and improve self-awareness.

---

Layer 7 — Analytics & Growth

The measurement layer.

Tracks:

- Productivity
- Consistency
- Growth
- Burnout risk
- Discipline trends
- Personal evolution

Purpose:

Provide objective feedback and long-term insight.

---

Core Innovations

AI-Powered Onboarding

Instead of filling lengthy forms, users describe their situation naturally.

Example:

«"I want to become consistent in coding, lose weight, improve my prayers, and stop wasting time."»

The AI automatically:

- Identifies goals
- Activates relevant domains
- Creates routines
- Suggests habits
- Generates an initial roadmap

---

Prayer-Relative Scheduling

Tasks can be scheduled relative to prayer times.

Examples:

- 15 minutes after Asr
- 30 minutes before Maghrib
- 20 minutes after Fajr

Schedules automatically adjust daily according to location and prayer calculations.

---

Passive Discipline Tracking

The system measures consistency with minimal user effort.

Examples:

- First phone unlock
- Wake time estimation
- Schedule adherence
- Routine execution

This data powers adaptive planning.

---

Contextual Voice Logging

Users can log activities naturally.

Example:

«"Today I studied for three hours, coded for one hour, skipped my workout, and slept late."»

AI automatically updates:

- Domain logs
- Habits
- Reflections
- Analytics

---

Emergency Recovery Mode

Designed to prevent abandonment.

Instead of breaking streaks:

The system temporarily reduces workload.

Example:

Normal target:

- Read 30 pages
- Walk 5 km

Recovery target:

- Read 1 page
- Walk 10 minutes

Progress remains alive.

---

Developer CLI

Command-line integration for developers.

Examples:

rizen status
rizen log coding --duration 2h
rizen log study --duration 1h
rizen dashboard

Purpose:

Integrate discipline directly into daily workflows.

---

Shadow Habit System

Negative habits are actively tracked.

Examples:

- Doom scrolling
- Excessive gaming
- Procrastination
- Social media addiction

The system calculates:

- Time lost
- Energy lost
- Opportunity cost
- Impact on life domains

---

Reward Store

Users create personal rewards.

Examples:

- Coffee
- New game
- Movie night
- Shopping budget

Rewards become unlockable through earned discipline points.

---

Supported Platforms

Mobile

- Android
- iOS

---

Web

Professional dashboard optimized for:

- Large screens
- Analytics
- Planning
- Productivity workflows

---

CLI

Developer-focused productivity interface.

---

Technology Stack

Frontend

- Flutter
- Material 3
- Responsive Design
- RTL Support
- Adaptive Layouts

---

Backend

- Firebase Authentication
- Cloud Firestore
- Cloud Functions
- Firebase Storage
- Firebase Messaging

---

State Management

- BLoC
- Cubit

---

Architecture

- Clean Architecture
- SOLID Principles
- Feature-First Structure

---

AI Layer

- Google Gemini

Capabilities:

- Coaching
- Parsing
- Planning
- Behavioral Analysis
- Predictive Insights

---

External Services

Aladhan API

Used for:

- Prayer times
- Dynamic scheduling
- Spiritual integrations

---

Design System

Typography

Arabic:

- Cairo
- IBM Plex Arabic

English:

- Inter

---

Icons

Phosphor Icons

---

Color Tokens

Token| Value
Primary Background| #1A1A2E
Secondary Background| #16213E
Card Background| #0F3460
Accent| #E94560
Border Radius| 16px

---

User Experience Principles

Every screen must:

- Reduce friction
- Minimize cognitive load
- Support quick actions
- Be accessible
- Feel premium
- Be responsive
- Support Arabic and English

---

Security Principles

Rizen follows a privacy-first philosophy.

Features include:

- Secure Authentication
- Firestore Security Rules
- Encryption in Transit
- Biometric Lock
- Local Data Protection
- User-Controlled Exports
- Backup & Recovery

---

Artificial Intelligence Principles

AI should:

- Guide
- Support
- Encourage
- Adapt

AI should never:

- Shame users
- Punish users
- Manipulate users
- Encourage unhealthy productivity

---

Success Metrics

User Metrics

- Daily Active Users
- Weekly Active Users
- Monthly Active Users

---

Discipline Metrics

- Routine Completion Rate
- Habit Completion Rate
- Streak Stability
- Recovery Rate

---

Retention Metrics

- Day 7 Retention
- Day 30 Retention
- Day 90 Retention

---

Wellbeing Metrics

- Burnout Reduction
- Sleep Consistency
- User Satisfaction

---

Development Roadmap

Phase 0

Foundation

- Authentication
- Theme System
- Navigation
- Firestore Setup

---

Phase 1

Daily OS

- Dashboard
- Routines
- Time Blocking

---

Phase 2

Domain Trackers

- Seven Pillars
- Logging Systems

---

Phase 3

Habit Engine

- Habits
- Shadow System
- Reward Store
- Recovery Mode

---

Phase 4

AI Integration

- Gemini
- Voice Logging
- Behavioral Analysis

---

Phase 5

Notes & Analytics

- Journaling
- Reflections
- Growth Reports

---

Phase 6

Platform Enhancements

- Widgets
- Optimization
- Beta Testing

---

Phase 7

Launch

- Flutter Web
- CLI Release
- Public Deployment

---

Long-Term Goal

Rizen aims to become the operating system for personal growth.

A platform where discipline, productivity, wellbeing, spirituality, and self-improvement coexist within one adaptive ecosystem.

The ultimate objective is not merely helping users complete tasks.

The objective is helping users become the person they aspire to be.

---

Rizen

Discipline without burnout. Growth without imbalance. Consistency without friction.