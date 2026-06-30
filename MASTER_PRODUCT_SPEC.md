# Role & Objective
You are an expert Silicon Valley Product Manager, Behavioral Psychologist, and Senior Software Architect. Your task is to generate a comprehensive, production-ready, and hyper-detailed Strategic Product Specification Document in Markdown (md) format for a revolutionary Life OS and Discipline app named "Rizen" (System Name: Rizen).

CRITICAL INSTRUCTION FOR GENERATION: Do NOT abbreviate, compress, or use placeholders like "etc." or "rest of the screens are similar." You must explicitly write down and describe every single section, layer, and all 73 screens in full UX/UI detail. Expand each point to its maximum professional and technical depth.

---

# Project Core Identity & Problem Statement
* **Product Name:** Rizen (System Name: Rizen)
* **The Problem:** Humans know what they need to do, but they lack a friction-free, adaptive system that holds them accountable, diagnoses behavior, and dynamically adapts to daily life without heavy configuration fatigue.
* **The Philosophy:** Balance, resilience, and alignment. Rizen is not an ordinary habit tracker; it is a "Life Operating System" that respects human weakness, prevents burnout, and integrates spiritual and worldly productivity seamlessly.

---

# Strategic Architecture: The 7-Layer System
Rizen is engineered upon 7 deeply interconnected architectural layers:
1.  **Layer 1: Identity & Values Setup:** Core identity configuration, spiritual layer integration, and long-term goal anchoring.
2.  **Layer 2: Daily OS (The Core Engine):** Dynamically generated daily routines, micro-time-blocking, and adaptive schedules.
3.  **Layer 3: Domain Tracker (The 7 Pillars):** Deep logging and analytics for 7 distinct life areas: Sports, Study, Work, Coding, Cooking/Nutrition, Spiritual (Optional), and a Custom Domain.
4.  **Layer 4: Habit Engine:** Comprehensive management of both positive habit building and negative habit breaking (Shadow Habits).
5.  **Layer 5: AI Coach (Gemini 2.0 Flash):** Continuous cognitive diagnostics, behavioral pattern recognition, and predictive adjustments.
6.  **Layer 6: Notes & Reflections:** Contextual journaling and cognitive unloading.
7.  **Layer 7: Analytics & Growth:** Cross-layer progress tracking, predictive trend charts, and personal growth indexing.

---

# Core Innovative Kill Features (The "Awe" Factors)

### 1. The "Aha!" Onboarding & Instant Customization
* **UX Flow:** Replaces tedious forms. Onboarding Step 3 consists of a single smart text/voice input where the user describes their current life struggles (e.g., "I feel distracted, gained weight, want to commit to my prayers and coding, but my day slips away").
* **AI Action:** Gemini 2.0 Flash parses this raw input instantly, automatically maps and activates relevant Domain Trackers, builds an initial adaptive routine, and delivers a compassionate, hyper-targeted welcoming brief from the AI Coach.

### 2. Dynamic Prayer-Relative Time-Blocking (The Spiritual Layer)
* **Integration:** Utilizing the Aladhan API to anchor worldly tasks to dynamic solar/prayer times rather than static clock hours.
* **Mechanism:** Tasks can be scheduled as `[15 mins after Asr prayer]` or `[45 mins before Maghrib]`. The Daily OS backend dynamically recalculates time blocks every night based on the user's localized coordinates, ensuring a frictionless blend of faith and daily workflow.

### 3. Passive Sleep & Discipline Tracking (Interaction-Based)
* **Frictionless Tracking:** In the morning, Rizen catches the **First Phone Unlock event** via native OS listeners as the definitive waking timestamp.
* **AI Interpretation:** Gemini compares this timestamp with the target routine. If there is a delay (e.g., waking up 75 mins late), it measures the "Bed Resistance Metric" and proactively downgrades the day's payload to avoid cognitive fatigue rather than sending punishing alerts.

### 4. Contextual Voice Logging (Zero-Friction Data Entry)
* **UX Flow:** To solve data-entry fatigue, a floating mic button on the dashboard allows users to talk naturally at the end of the day (e.g., "Today I coded for 2 hours, went to the gym, but skipped reading and stayed up late").
* **AI Action:** The voice note is transcribed and fed to Gemini 2.0 Flash, which automatically parses the entities, updates the respective Domain Trackers, increments habit streaks, and logs reflections without the user opening multiple screens.

### 5. Burnout Prevention & "Emergency Recovery Mode" (The Resilient Streak)
* **Problem:** Traditional habit trackers cause psychological collapse and abandonment when a 50-day streak breaks.
* **Solution:** A 1-tap "Emergency/Burnout Mode". When activated, the AI immediately shrinks the daily routine to a bare-minimum survival baseline (e.g., "read 1 page, walk 10 mins" instead of "read 30 pages, run 5km"). The streak is preserved, fostering long-term psychological resilience.

### 6. Developer CLI Integration (Built-in Growth Loop)
* **Feature:** A simple, open-source terminal CLI interface for Rizen, specifically targeting the initial core audience of developer early-adopters.
* **Usage:** Developers can log activities directly from their terminal (e.g., `rizen log coding --duration 2h` or `rizen status`), ensuring Rizen is woven into their actual working environment.

### 7. The Antagonist Engine (Shadow Streaks)
* **Feature:** Negative habits are visualized as a growing "Shadow Score." Instead of simple omission tracking, the AI explicitly maps how much time, mental energy, and focus the "Shadow" has stolen from the user's 7 core life pillars, creating a powerful, protective cognitive bias against relapse.

### 8. Real-Life Reward Store (Tangible Gamification)
* **Feature:** Users lock real-life pleasures (e.g., ordering a favorite coffee, buying a video game, watching a movie) behind a personal lock gate inside the app. These rewards can *only* be unlocked using currency earned from their "Daily Score Card" through high discipline and routine completion.

---

# Technical Stack & Architecture Spec
* **Frontend:** Cross-platform Flutter (iOS, Android, and a fully optimized, wide-layout Flutter Web Dashboard for professionals).
* **Design Tokens & System:** Deep dark space theme. Primary: `#1A1A2E`, Secondary Background: `#16213E`, Accent Cards: `#0F3460` (Light Glassmorphism with 16px border-radius), Action Call-to-Action: `#E94560`. Typography: Arabic (Cairo / IBM Plex Arabic), English (Inter). Icons: Phosphor Icons.
* **Native Integration:** Native Lock Screen & Home Screen Widgets (WidgetKit for iOS / Android Widget providers) showing current time-block count-downs (`⏳ 20 mins remaining for Coding`).
* **Backend & State Management:** Firebase ecosystem (Cloud Firestore for optimized reads/writes, Firebase Auth, Cloud Functions for daily resets and API fetches). State managed via Clean Architecture (Data, Domain, Presentation layers) combined with BLoC/Cubit.
* **AI Core:** Google Gemini 2.0 Flash API (for ultra-fast response latency and optimal cost-efficiency) executing behavioral analysis, text/voice parsing, and predictive analytics (e.g., predicting a burnout 3 days in advance based on sleep and habit deceleration trends).

---

# Full 73-Screen Mapping & Architectural Distribution
*Detail the precise functionality, UI elements, and user actions for every single screen below:*

### 🔐 Auth & Onboarding (8 Screens)
1. Splash Screen: Branding animation and security check.
2. Welcome / Value Proposition: Core philosophy carousel.
3. Sign Up: Email/Social authentication interface.
4. Sign In: Secure login gate.
5. Forgot Password: Account recovery stream.
6. Onboarding Step 1 — Language & Region Selection (i18n configurations).
7. Onboarding Step 2 — Spiritual Layer Activation & Configuration (Aladhan API location permissions).
8. Onboarding Step 3 — The "Aha!" AI Prompt Engine (Single unified screen replacing old forms for selecting domains and goals via raw voice/text parsing).

### 🏠 Dashboard & Home (6 Screens)
9. Home Dashboard: Dynamic Morning/Evening layouts, active Time-Block countdown widget, and Quick Action buttons.
10. Daily Score Card: Visual gamified summary of today's discipline metrics.
11. Weekly Overview: Macro performance timeline.
12. Monthly Calendar View: Habit consistency and streak mapping grid.
13. Notification & Contextual Alert Center: Filtered systemic logs.
14. Sleep & Discipline Analytics: Dashboard showing passive sleep tracking, wake timestamps, and the "Bed Resistance Metric."

### ⏰ Routine Builder (8 Screens)
15. Routine Overview List: Master list of all user-defined routines.
16. Create Routine Window: Interface to name, trigger, and initialize routines.
17. Edit Routine Window: Configuration manager for active structures.
18. Routine Detail View: Step-by-step sequential breakdown of tasks.
19. Micro Time-Block Visual Editor: Drag-and-drop chronological timeline grid.
20. AI Routine Generator Input/Output: Prompting hub for automated routine builds via Gemini.
21. Routine Templates Library: Preset open-source configurations for various archetypes.
22. Historical Routine Log: Archival view of past routine iterations.

### 🎯 Domain Trackers (14 Screens — 2 Screens per Domain)
23-24. Sports Pillar: Dashboard + Log Session
25-26. Study Pillar: Dashboard + Study Session
27-28. Work Pillar: Dashboard + Work Log
29-30. Coding Pillar: Dashboard + Coding Log
31-32. Cooking/Nutrition Pillar: Dashboard + Meal Log
33-34. Spiritual Pillar (Optional): Dashboard + Prayer/Quran Log
35-36. Custom Pillar: Dashboard + Custom Entity Log

### 🔄 Habit Engine (10 Screens)
37. Habits Overview: Dual dashboard showing Positive Patterns and Negative/Shadow metrics.
38. Add New Habit: Toggle window between Good Habits and Shadow Habits.
39. Edit Habit Configuration: Custom frequency, triggers, and notification anchoring.
40. Habit Detail & Streak Matrix: Deep visualization of consistent performance.
41. Bad Habits / Shadow Tracker Dashboard: Main tracking view for behavioral avoidance.
42. The Shadow Score Screen: Visual breakdown of how much energy and focus negative habits have stolen from the 7 Pillars.
43. Habit Check-in Daily Screen: Instant logging dialog sheet.
44. Habit Analytics & Predictive Charts: Trend analysis maps.
45. Habit Recovery & Emergency Plan Switch: 1-tap gateway to trigger Burnout Mode.
46. Real-Life Reward Store: Marketplace to spend earned discipline points on locked personal real-life pleasures.

### 🤖 AI Coach (7 Screens)
47. AI Coach Main Home: Status interface of the user's cognitive guide.
48. Daily AI Briefing: Morning strategic roadmap and Evening diagnostic summary.
49. Contextual Free Chat with AI Coach: Low-latency conversational workspace.
50. AI Weekly Analytical Synthesis: End-of-week master psychological report.
51. AI Automated Suggestions & Course Correction List: Actionable checklist items.
52. AI Micro-Goal Adaptive Adjustment Window: Dynamic goal shifting UI.
53. Deep Personalized Behavioral Insights: Pattern recognition and correlation reports.

### 📝 Notes & Reflections (6 Screens)
54. Notes Home Grid: Clean visual storage for cognitive offloading.
55. Create Note: Text processor and Voice Engine attachment module.
56. Edit Note: Markdown-supported text modification.
57. Note Detail View: Clean viewing interface.
58. Daily Reflection & Journaling Prompt: Nightly guided cognitive unload.
59. Semantic Search Notes: High-performance indexed search engine.

### 📊 Analytics & Progress (5 Screens)
60. Master Analytics Dashboard: Aggregated historical productivity view.
61. Domain-Specific Correlation Analytics: Evaluating intersections between life domains.
62. Habit Trend Line Charts: Temporal tracking of habit velocities.
63. Personal Growth Index & Burnout Risk Report: Predictive indicators showing burnout windows.
64. Secure Data Export / Backup Hub: Privacy-focused data archival tool.

### ⚙️ Settings & Profile (9 Screens)
65. User Master Profile: Overview of achievements, account level, and tier.
66. Edit Profile Specs: Modifying standard credential data.
67. Global App Customization Settings: System themes, fonts, and card opacities.
68. Granular Notification Control: High-importance alerts, muting, and scheduling.
69. Language, Region, & Prayer Calculation Configuration: Aladhan method adjustment parameters.
70. Spiritual Framework Sub-Settings: Toggling religious layer constraints.
71. Privacy, Encryption, & Local-First Data Security: Biometric lock controls.
72. CLI Access Token & Key Management: Generating API credentials for the terminal interface.
73. Support, Open Source Attribution, & Feedback Matrix.

---

# Implementation Plan (22-Week Roadmap)
* **Phase 0 (Weeks 1-2):** Onboarding Architecture, Unified Theme, Auth, Shell Navigation, and Database Handshakes.
* **Phase 1 (Weeks 3-5):** Home Dashboard & Core Routine Builder (Dynamic Prayer-Relative Time-Blocking).
* **Phase 2 (Weeks 6-9):** Comprehensive Domain Trackers (7 Pillars & Log interfaces).
* **Phase 3 (Weeks 10-12):** Habit Engine (Good/Shadow tracking, Reward Store, and Emergency Mode architecture).
* **Phase 4 (Weeks 13-15):** Deep AI Coach Integration (Gemini 2.0 Flash prompts, Voice Engine parser, First Phone Unlock sleep tracking backend).
* **Phase 5 (Weeks 16-17):** Journaling Notes Engine & Growth Analytics Graphing.
* **Phase 6 (Weeks 18-19):** Native Widgets, System Tweaks, Cross-Platform Polish, and Local Beta Testing.
* **Phase 7 (Weeks 20-22):** Flutter Web responsive deployment, CLI package release, and Live Target Launch.

---

# Layout and Formatting Rules for Output
* Use beautifully aligned Markdown Tables for comparisons, screen lists, and color design tokens.
* Provide a robust Firestore JSON Database schema example for `users`, `routines`, `habits`, and `shadow_logs`.
* Maintain an authoritative, innovative, and motivating tone throughout the document. Ensure it is completely fleshed out from page 1 to the end. Ready? Go!

# Rizen — Master Product Specification Addendum v1.0
**Status:** Authoritative. Supersedes/extends `MASTER_PRODUCT_SPEC.md` and `PROJECT_KNOWLEDGE.md` wherever scope overlaps. Both base documents remain valid; this addendum closes gaps identified in product review on 2026-06-21.

**Effect on roadmap:** Adds 2 new architectural layers (8, 9), extends 3 existing Domain Pillars, adds 1 new cross-cutting feature system, adds 1 new Islamic Feature Suite (Layer 10), and refines 2 existing kill features. Total screen count rises from 73 to **103** (see Section 9 for the full delta). Phase plan impact is detailed in Section 10 — read before resuming development.

**Locked stack reminder:** Everything below uses the same non-negotiable stack as the base spec — Flutter (BLoC/Cubit, GoRouter, Freezed, Dio), Firebase (Firestore, Auth, Cloud Functions, Storage), Gemini AI, Aladhan API. No exceptions introduced here.

---

## 0. Why This Addendum Exists

The original 7-layer / 73-screen spec captured the disciplined-productivity core of Rizen (habits, prayer-relative scheduling, burnout prevention, AI coaching) but omitted eight features the founder considers core to the product vision:

1. Full personal finance / budget management
2. AI-driven learning roadmap ingestion (PDF → auto-scheduled curriculum)
3. AI-generated complete workout sessions (not just logging)
4. Predictive weight/nutrition trend analysis
5. Multi-timer kitchen/cooking assistant
6. Preset challenge plans (e.g. "75 Hard") with permission-linked activation
7. Non-prayer-based schedule anchoring for non-spiritual users
8. **Islamic Feature Suite** — prayer times display, Hijri calendar, Qibla compass, countdown to next prayer, Quran reading tracker, Adhkar/Du'a library

Two existing features also need mechanism refinement (Section 8).

This document treats each gap with the same rigor as the base spec: goals, user stories, functional/non-functional requirements, edge cases, data models, API contracts, and implementation notes. No placeholders.

---

## 1. NEW LAYER 8 — Personal Finance & Budget Management

### 1.1 Goals
Give the user a frictionless way to see "how much money do I have left this month" without spreadsheet discipline. Mirrors the app's broader philosophy: low-friction logging, AI-assisted categorization, end-of-day reconciliation rather than rigid real-time bookkeeping.

### 1.2 User Stories
- As a user, I set my monthly income once and the app tracks remaining budget automatically.
- As a user, I log an expense in under 5 seconds via free-text quick-entry ("افطار 3" / "breakfast 3").
- As a user, at day's end the app asks if I missed logging anything, rather than relying on me to remember to open the app.
- As a user, I register recurring financial commitments (rent, subscriptions) once and they auto-deduct from each period's budget.
- As a user, I log irregular/emergency expenses (e.g. a taxi ride) with just an amount and description, no category required upfront.
- As a user, at month's end I get a clear report: spent X of Y, Z remaining.

### 1.3 Functional Requirements
| ID | Requirement |
|---|---|
| FIN-1 | User sets `monthlyIncome` (SAR or any ISO 4217 currency) during onboarding or in Settings. |
| FIN-2 | User can add a `FinancialCommitment` with name, amount, and frequency (`daily`/`weekly`/`monthly`). |
| FIN-3 | User can quick-add a `Transaction` via free-text natural language input, parsed by Gemini into `{description, amount, category, type}`. |
| FIN-4 | User can manually add a `Transaction` via structured form (description, amount, category, type, frequency tag) as fallback if AI parsing fails or is rejected. |
| FIN-5 | A Cloud Function triggers once daily (user's local end-of-day, derived from their schedule anchor — see Section 8.2) prompting: "You logged N items today — anything else to add?" |
| FIN-6 | Monthly report aggregates: total income, total committed (recurring), total spent (ad-hoc + recurring), remaining balance. |
| FIN-7 | Emergency/ad-hoc expense entry requires only `amount` + free-text `description`; category is optional and can be backfilled by AI suggestion. |
| FIN-8 | Budget resets on a rolling monthly cycle anchored to the day the user first set `monthlyIncome` (not necessarily calendar-month-1). |

### 1.4 Non-Functional Requirements
- Quick-entry parsing (FIN-3) must return a result in under 2 seconds (Gemini Flash latency budget) or fall back to the manual form (FIN-4) automatically.
- All financial data is stored Firestore-side scoped strictly to `uid`; no financial data is ever sent to Gemini without being stripped of any other PII beyond the transaction text itself.
- Currency is configurable but defaults to SAR given primary user base.

### 1.5 Edge Cases
- User logs an expense that exceeds remaining monthly budget → app shows the overage visually (no blocking, no shaming language per AI Rules — e.g. "You've used 105% of this month's budget" not "You're overspending!").
- User has zero recurring commitments → monthly report still renders, recurring section shows empty state, not an error.
- AI quick-entry parses ambiguous input (e.g. "كذا 50" with no clear description) → falls back to asking one clarifying follow-up via the same input bar, not a full-screen interruption.
- User changes `monthlyIncome` mid-cycle → current cycle's report uses a weighted/prorated calculation, flagged in the UI as "adjusted mid-month."

### 1.6 Data Models

```
Collection: transactions
{
  id: string,
  uid: string,
  amount: number,
  currency: string,            // ISO 4217, default "SAR"
  description: string,
  category: string,            // e.g. "food", "transport", "emergency", nullable until categorized
  type: "income" | "expense",
  source: "quick_entry" | "manual" | "recurring_auto",
  loggedAt: timestamp,
  createdAt: timestamp
}

Collection: financial_commitments
{
  id: string,
  uid: string,
  name: string,
  amount: number,
  frequency: "daily" | "weekly" | "monthly",
  nextDueDate: timestamp,
  active: boolean,
  createdAt: timestamp
}

Collection: budget_cycles
{
  id: string,
  uid: string,
  monthlyIncome: number,
  cycleStart: timestamp,
  cycleEnd: timestamp,
  totalSpent: number,          // denormalized, updated via Cloud Function on transaction write
  totalCommitted: number,      // denormalized sum of active commitments
  status: "active" | "closed"
}
```

Firestore security rule pattern (matches `notes` collection precedent): all three collections readable/writable only where `request.auth.uid == resource.data.uid`.

### 1.7 API Contracts (Repository Layer)

```dart
class FinanceRepository {
  Future<Transaction> addTransaction({required double amount, required String description, String? category, required TransactionType type, TransactionSource source});
  Future<List<Transaction>> getTransactionsForCycle(String cycleId);
  Future<void> addCommitment({required String name, required double amount, required CommitmentFrequency frequency});
  Future<BudgetCycle> getCurrentCycle();
  Future<BudgetCycle> closeCycleAndStartNew();
  Stream<BudgetCycle> watchCurrentCycle();
}
```

### 1.8 Screens (8 new screens — appended to the 73-screen base as 74–81)

74. **Finance Setup** — onboarding/settings screen to set monthly income and currency.
75. **Quick Expense Entry** — single text field, AI-parsed, confirms parsed result before saving.
76. **Manual Transaction Form** — structured fallback entry.
77. **Financial Commitments List** — add/edit/deactivate recurring commitments.
78. **Daily Expense Review** — end-of-day AI-prompted reconciliation sheet.
79. **Monthly Budget Report** — income vs. spent vs. remaining, category breakdown chart.
80. **Emergency Expense Entry** — minimal-friction amount + description form.
81. **Finance Settings** — currency, cycle start day, notification preferences for daily review prompt.

### 1.9 Implementation Notes
- Follow the exact vertical-slice pattern already proven in `lib/features/notes/`: `data/models/`, `data/repositories/`, `presentation/cubit/`.
- Gemini quick-entry parsing should use a constrained JSON-output prompt (see `structured_outputs` pattern) — never free-form text parsing in the client.
- The end-of-day Cloud Function trigger should reuse whatever daily-reset Cloud Function infrastructure already exists for the Daily OS layer (Layer 2) rather than creating a parallel scheduler.

---

## 2. NEW LAYER 9 — AI-Powered Learning Roadmap Engine

### 2.1 Goals
Let the user upload any structured learning plan (a PDF roadmap — e.g. "Full-Stack Developer Roadmap") and have Rizen automatically convert it into a sequence of scheduled, time-estimated, trackable tasks — then silently adapt pacing to the user's actual completion speed without ever telling the user "you are slow" or "you are fast."

### 2.2 User Stories
- As a user, I upload a PDF roadmap and the app extracts an ordered list of topics/tasks.
- As a user, I get a notification suggesting today's topic: "You're still motivated — review how the web works. Should take about 5 minutes."
- As a user, I mark a task ✔ when done or − when deferred, and deferred tasks resurface later.
- As a user, the app silently tracks how long each task actually took me vs. its estimate, and adjusts future estimates and pacing for me specifically — without exposing a "skill level" label.

### 2.3 Functional Requirements
| ID | Requirement |
|---|---|
| LRN-1 | User uploads a PDF via file picker; requires storage/file-read permission requested contextually at this screen only. |
| LRN-2 | PDF text is extracted (Cloud Function, server-side) and sent to Gemini with a structured-output prompt to produce an ordered topic list: `{title, description, estimatedMinutes, order}`. |
| LRN-3 | Topics are surfaced one (or a small batch) at a time as suggested daily tasks, integrated into the Daily OS (Layer 2) time-blocking system. |
| LRN-4 | Each topic has a status: `pending`, `done` (✔), `deferred` (−). Deferred topics are resurfaced in a later suggested slot, not dropped. |
| LRN-5 | System records `requestedAt` (when first surfaced) and `completedAt` (when marked ✔) for every topic. |
| LRN-6 | A per-user `comprehensionProfile` is maintained: a rolling ratio of `actualMinutes / estimatedMinutes` across completed topics, used only to silently scale future `estimatedMinutes` for that user — never displayed as a score or label. |
| LRN-7 | Multiple roadmaps can be active concurrently; each is tracked independently. |

### 2.4 Non-Functional Requirements
- PDF text extraction must run server-side (Cloud Function), never on-device, to keep the Flutter client thin and to allow reuse of server-side OCR fallback for scanned PDFs.
- The Gemini topic-extraction prompt must cap output to a reasonable topic count (e.g. max 200 topics per roadmap) to bound cost and avoid pathological PDFs producing unusable lists.
- Comprehension-profile adaptation must never be exposed in any user-facing copy as a fixed label ("beginner/intermediate/advanced") — this directly violates the AI Rules in the base spec ("Gemini should never shame users"). The adaptation is purely a backend pacing multiplier.

### 2.5 Edge Cases
- PDF has no extractable text (pure scanned images, no OCR layer) → Cloud Function falls back to OCR; if OCR also fails, user is shown a clear, blame-free message and offered manual topic entry instead.
- User uploads a non-roadmap PDF (e.g. a novel) → Gemini extraction prompt includes a confidence check; if confidence is low, the app asks the user to confirm the extracted structure before activating it, rather than silently creating a nonsensical task list.
- User never opens a surfaced topic for several days → topic remains `pending`, does not auto-expire; gentle resurfacing only, no guilt-based copy.
- Two roadmaps schedule conflicting topics on the same day → Daily OS time-blocking (Layer 2) treats roadmap topics as flexible-priority tasks, not fixed-time blocks, so they reflow rather than collide.

### 2.6 Data Models

```
Collection: learning_roadmaps
{
  id: string,
  uid: string,
  title: string,
  sourceFileName: string,
  sourceFileUrl: string,        // Firebase Storage reference
  status: "processing" | "active" | "completed" | "archived",
  createdAt: timestamp
}

Collection: roadmap_topics
{
  id: string,
  roadmapId: string,
  uid: string,
  title: string,
  description: string,
  order: number,
  estimatedMinutes: number,     // adjusted per-user over time
  baseEstimatedMinutes: number, // original AI estimate, never overwritten (for audit/debug)
  status: "pending" | "done" | "deferred",
  requestedAt: timestamp,       // nullable until first surfaced
  startedAt: timestamp,         // nullable
  completedAt: timestamp        // nullable
}

Collection: user_comprehension_profiles
{
  uid: string,                  // doc ID = uid
  avgCompletionRatio: number,   // rolling average of actual/estimated
  sampleCount: number,
  lastUpdated: timestamp
}
```

### 2.7 API Contracts (Repository Layer)

```dart
class RoadmapRepository {
  Future<LearningRoadmap> uploadRoadmap(File pdfFile, {required String title});
  Future<List<RoadmapTopic>> getTopicsForRoadmap(String roadmapId);
  Future<void> markTopicStatus(String topicId, TopicStatus status);
  Stream<RoadmapTopic?> watchSuggestedTopicForToday();
  Future<void> recalculateComprehensionProfile(); // invoked server-side via Cloud Function on topic completion
}
```

### 2.8 Screens (6 new screens — appended as 82–87)

82. **Roadmap Upload** — file picker, title input, processing-status indicator.
83. **Roadmap List** — all active/completed/archived roadmaps.
84. **Roadmap Topic Tracker** — full ordered list with ✔/− status per topic.
85. **Topic Detail / Active Session** — shown when user starts a suggested topic; includes a timer (reuses the countdown-timer pattern from Habit check-ins).
86. **Roadmap Confirmation Screen** — shown post-extraction when AI confidence is low, lets user edit/confirm the extracted topic list before activation.
87. **Roadmap Settings** — pause/archive a roadmap, adjust daily topic-suggestion frequency.

### 2.9 Implementation Notes
- This is the most architecturally complex addition — it touches Layer 2 (Daily OS, for surfacing suggested topics), Layer 5 (AI Coach, for the notification copy), and Cloud Functions (PDF extraction + comprehension recalculation). Build the data layer and basic CRUD first (matches the project's "scaffold first, integrate second" principle), then wire the Daily OS integration as a second pass.
- Recommend a single dedicated agent owns this Layer end-to-end given its cross-layer touchpoints — do not split model/repository/cubit work across multiple parallel agents here, the collision risk is too high.

---

## 3. EXTENSION — Sports Pillar: AI Workout Session Builder

### 3.1 Goals
Move the Sports domain pillar from passive logging to active session generation: a full warmup → main-set → cooldown workout, generated by Gemini based on the user's stated goal and available time.

### 3.2 Functional Requirements
| ID | Requirement |
|---|---|
| WKT-1 | User specifies a goal (e.g. "upper body strength," "20-minute cardio") and available time. |
| WKT-2 | Gemini generates a structured `WorkoutSession` with ordered `WorkoutExercise` entries tagged by phase (`warmup`/`main`/`cooldown`), each with sets/reps or duration. |
| WKT-3 | User can edit any generated exercise (swap, remove, adjust reps) before starting. |
| WKT-4 | An Active Session Player runs the session with per-exercise timers and rest-period countdowns, auto-advancing through the sequence. |
| WKT-5 | On completion, the session logs to the existing `domain_logs` collection (Section established in current build) with `duration` and a reference to the generated `WorkoutSession`. |

### 3.3 Data Models

```
Collection: workout_sessions
{
  id: string,
  uid: string,
  title: string,
  goal: string,
  totalEstimatedMinutes: number,
  exercises: [
    { name: string, phase: "warmup"|"main"|"cooldown", sets: number?, reps: number?, durationSeconds: number?, restSeconds: number }
  ],
  generatedBy: "ai" | "manual",
  completedAt: timestamp        // nullable until finished
}
```

### 3.4 Screens (3 new — appended as 88–90)
88. **Generate Workout** — goal + time input, triggers Gemini generation.
89. **Workout Preview/Edit** — review and adjust generated exercises before starting.
90. **Active Session Player** — full-screen guided run-through with timers.

### 3.5 Edge Cases
- User has a documented injury/limitation noted elsewhere in their profile → Gemini prompt for WKT-2 must incorporate any user-disclosed physical limitations to avoid generating contraindicated exercises. If no limitation is on file, generate standard sessions without assuming any.
- Generated session exceeds the user's stated available time → regenerate with a tighter constraint rather than silently truncating mid-exercise.

---

## 4. EXTENSION — Nutrition Pillar: Predictive Trend Analytics

### 4.1 Goals
Surface a general, non-prescriptive trend insight (e.g. "at this pace, current eating pattern trends toward +0.5kg over 2 weeks") inside the AI Coach's weekly synthesis — not a real-time calorie-counting feature.

### 4.2 Functional Requirements
| ID | Requirement |
|---|---|
| NUT-1 | User can log `WeightEntry` (weight + timestamp) independently of meal logs. |
| NUT-2 | AI Weekly Synthesis (existing screen, Layer 5) correlates recent `WeightEntry` trend with meal-log frequency/category patterns and surfaces one plain-language observation. |
| NUT-3 | No specific calorie/macro targets, diet plans, or numeric prescriptive guidance are generated — this stays observational, not directive, consistent with the app's wellbeing-safe tone. |

### 4.3 Data Models
```
Collection: weight_entries
{ id: string, uid: string, weightKg: number, loggedAt: timestamp }
```

### 4.4 Implementation Notes
This extension deliberately stays light — it plugs into the existing AI Weekly Synthesis screen (already specced) rather than creating new screens. Only one new collection (`weight_entries`) and one new log-entry point on the existing Nutrition log screen are needed.

---

## 5. EXTENSION — Cooking/Nutrition Pillar: Multi-Timer Kitchen Assistant

### 5.1 Goals
Let a user run several concurrent named cooking timers from one screen (e.g. "rice — 18 min", "chicken — 25 min") without leaving the recipe/meal-log flow.

### 5.2 Functional Requirements
| ID | Requirement |
|---|---|
| KIT-1 | User can start multiple independent named countdown timers from a single screen. |
| KIT-2 | Each timer shows independently and fires its own notification/alert on completion. |
| KIT-3 | Timers persist across app backgrounding (standard local notification scheduling, not a Firestore-backed feature — this is purely local state). |

### 5.3 Implementation Notes
This is a **local-only, client-side feature** — no new Firestore collection needed. Implement as a `MultiTimerCubit` holding a list of in-memory timer states, each backed by a scheduled local notification (`flutter_local_notifications` or platform-native scheduling) so timers fire even if the app is backgrounded. No new screen needed if integrated as a widget within the existing Meal Log screen (screen 32 in the base spec); add one new screen only if a standalone "Kitchen Timers" entry point is desired.

### 5.4 Screens (1 new, optional — appended as 91)
91. **Kitchen Multi-Timer** — standalone screen showing all active named timers, accessible from the Cooking/Nutrition dashboard.

---

## 6. NEW FEATURE — Preset Challenge Plans

### 6.1 Goals
Let users opt into a pre-built challenge template (e.g. "75 Hard"–style) with its own daily requirement checklist, where the plan itself declares which device permissions it needs (e.g. camera for daily progress photos), requested only at enrollment, not at app install.

### 6.2 Functional Requirements
| ID | Requirement |
|---|---|
| CHL-1 | A `ChallengePlan` catalog (seeded, not user-created) defines `durationDays` and a list of `dailyRequirements`. |
| CHL-2 | Each `ChallengePlan` declares `requiredPermissions` (e.g. `["camera"]`); these are requested via the OS permission dialog only when the user enrolls in a plan that needs them. |
| CHL-3 | User enrolls in a plan, creating a `UserChallengeEnrollment` tracking `currentDay` and daily checklist completion. |
| CHL-4 | If a plan requires a daily photo, the check-in screen opens the camera directly; the photo is stored in Firebase Storage, referenced from that day's enrollment record. |
| CHL-5 | Missing a day's requirement does not silently fail the challenge — per the base spec's Resilience principle, missed days are logged but the user decides whether to restart, consistent with "missing a day is not failure."|

### 6.3 Data Models
```
Collection: challenge_plans   // seeded/static catalog, not user-writable
{ id: string, name: string, durationDays: number, dailyRequirements: [{ id: string, label: string }], requiredPermissions: [string] }

Collection: user_challenge_enrollments
{
  id: string, uid: string, planId: string,
  startDate: timestamp, currentDay: number,
  status: "active" | "completed" | "abandoned",
  dailyLogs: [{ day: number, completedRequirementIds: [string], photoUrl: string? }]
}
```

### 6.4 Screens (3 new — appended as 92–94)
92. **Challenge Library** — browse seeded plans.
93. **Challenge Detail / Enroll** — plan details, permission disclosure before enrollment.
94. **Daily Challenge Check-in** — per-day checklist + camera capture if required.

---

---

## 6.5 NEW LAYER 10 — Islamic Feature Suite

### 6.5.1 Goals
Make Rizen the most spiritually-aware productivity app available in the Arab world — not by treating Islamic features as an optional add-on, but by building a dedicated, first-class Islamic hub that serves Muslim users from the moment they open the app. The suite has two tiers:

**Tier 1 — Immediate (Phase 2.5):** Prayer times, Hijri calendar, Qibla compass, countdown to next prayer.
**Tier 2 — Extended (Phase 4+):** Quran reading tracker, Adhkar (morning/evening/occasion-based), Du'a library.

Both tiers draw from the Aladhan API already locked in the stack, requiring zero new external dependencies for Tier 1.

---

### 6.5.2 Tier 1: Prayer Times, Hijri Date, Qibla, Countdown

#### Goals
Surface the four most-needed daily Islamic references (prayer schedule, date, direction, time-to-next-prayer) from one hub screen — and surface the countdown prominently on the Home Dashboard without requiring the user to navigate away.

#### User Stories
- As a Muslim user, I open the app and immediately see today's full prayer schedule in my local timezone.
- As a user, I see today's Hijri date on the Islamic Hub and optionally on the Home Dashboard.
- As a user, I always know how much time remains until the next prayer — from a persistent indicator on the Home Dashboard or a widget.
- As a user, I open a Qibla screen and my device compass points toward Mecca.
- As a user, I choose my preferred prayer calculation method (Umm Al-Qura, ISNA, Egyptian, etc.) in Settings.

#### Functional Requirements
| ID | Requirement |
|---|---|
| ISL-1 | Fetch today's prayer times via Aladhan API using the user's device GPS coordinates (requested once, cached with daily refresh). |
| ISL-2 | Display all five prayer times (Fajr, Dhuhr, Asr, Maghrib, Isha) plus Sunrise on the Islamic Hub screen. |
| ISL-3 | Display today's Hijri date (from Aladhan API response) on the Islamic Hub screen; optionally surfaced on Home Dashboard. |
| ISL-4 | Countdown timer to the next prayer, updated in real-time (every second), visible on the Islamic Hub screen and as a persistent element on the Home Dashboard. |
| ISL-5 | Qibla compass screen reads device magnetometer, calculates bearing to Mecca (Kaaba coordinates: 21.4225° N, 39.8262° E), and displays a rotating compass needle. |
| ISL-6 | Prayer calculation method is user-configurable (Umm Al-Qura for Saudi Arabia as default, with all methods supported by Aladhan API available). |
| ISL-7 | Prayer times are cached locally (Firestore or SharedPreferences) and refresh automatically at midnight or when location changes by more than a configurable threshold (default: 50km). |
| ISL-8 | Each prayer can have an optional notification (Adhan alert) — user opts in per-prayer independently. |

#### Non-Functional Requirements
- Aladhan API call must not block the app startup — fetch asynchronously, show cached times immediately while fresh data loads.
- Qibla compass must degrade gracefully on devices without a magnetometer: show a message "Compass not available on this device" rather than crashing.
- Prayer time data must be available offline after first fetch — local cache is the source of truth when network is unavailable.
- Hijri date display must support both Arabic and English locale formatting.

#### Edge Cases
- User denies location permission → fall back to manual city/country selection with a searchable city list (Aladhan API supports city-name queries).
- User crosses a timezone boundary mid-day → detect location delta exceeding threshold, refetch times, update countdown.
- Aladhan API is unreachable → serve cached times with a subtle "last updated: [timestamp]" indicator — never show empty state or an error as the primary content.
- Device magnetometer returns highly variable readings (magnetic interference) → apply a rolling average over 10 readings to stabilize the Qibla compass needle.
- Prayer time falls within a minute → countdown shows "Now" rather than a negative number.

#### Data Models
```
Collection: prayer_times_cache
{
  uid: string,                    // doc ID = uid (one doc per user)
  latitude: number,
  longitude: number,
  calculationMethod: string,      // e.g. "Umm_al_Qura", "ISNA"
  timings: {
    Fajr: string,                 // "HH:mm" local time
    Sunrise: string,
    Dhuhr: string,
    Asr: string,
    Maghrib: string,
    Isha: string
  },
  hijriDate: {
    day: number,
    month: number,
    year: number,
    monthNameAr: string,
    monthNameEn: string
  },
  fetchedAt: timestamp,
  validForDate: string            // "YYYY-MM-DD" — invalidate if current date differs
}

Field added to existing users collection:
islamicSettings: {
  calculationMethod: string,
  prayerNotifications: { Fajr: bool, Dhuhr: bool, Asr: bool, Maghrib: bool, Isha: bool },
  showHijriOnDashboard: bool
}
```

#### API Contract (Repository Layer)
```dart
class PrayerTimesRepository {
  Future<PrayerTimesCache> getTodayPrayerTimes({required double lat, required double lng});
  Future<PrayerTimesCache> getPrayerTimesByCity({required String city, required String country});
  Stream<Duration> watchCountdownToNextPrayer();
  Future<double> getQiblaBearing({required double lat, required double lng});
  Future<void> updateCalculationMethod(String method);
  Future<void> updatePrayerNotificationSettings(Map<String, bool> settings);
}
```

#### Screens — Tier 1 (5 screens: 95–99)
95. **Islamic Hub Home** — full prayer schedule for today, Hijri date, countdown to next prayer, navigation to Qibla and Tier 2 features.
96. **Qibla Compass** — full-screen compass with bearing to Mecca, device magnetometer-powered, degrades gracefully.
97. **Prayer Time Detail** — tap any prayer for Adhan notification toggle, time adjustment notes, and that prayer's relative time-block assignments in the Daily OS.
98. **Prayer Calculation Settings** — method selector, location override (manual city), notification preferences per prayer.
99. **Hijri Calendar** — monthly Hijri calendar view with Islamic events/occasions marked (e.g. Ramadan, Eid al-Adha), cross-referenced with the user's habit/routine schedule.

---

### 6.5.3 Tier 2: Quran Reading Tracker, Adhkar, Du'a Library

#### Goals
Build a spiritual habit tracking layer on top of Tier 1 — not a full Quran app (there are excellent standalone apps for that), but a lightweight tracker and companion that integrates with the Habit Engine (Layer 4) and AI Coach (Layer 5) already in the base spec.

#### User Stories
- As a user, I log how many pages of Quran I read today and see a cumulative streak and progress toward my weekly/monthly goal.
- As a user, I access morning (Sabah) and evening (Masa') Adhkar as a structured checklist — each Dhikr shows its count and I tap to mark it done.
- As a user, I browse a Du'a library organized by occasion (sleep, travel, eating, distress, etc.) and mark favorites for quick access.
- As a user, the AI Coach references my Quran and Adhkar consistency in its weekly synthesis, treating them as first-class spiritual habits alongside physical and cognitive habits.

#### Functional Requirements
| ID | Requirement |
|---|---|
| ISL-9 | Quran reading log: user inputs pages read today; system tracks cumulative pages, daily streak, and weekly/monthly progress toward a user-set goal. |
| ISL-10 | Morning and evening Adhkar are presented as ordered checklists; each item shows Arabic text, transliteration, translation (Arabic/English), and repetition count. User taps to mark each item done. |
| ISL-11 | Adhkar completion is logged as a `spiritual_log` entry, identical in structure to other domain logs — feeds into the Habit Engine streak tracking. |
| ISL-12 | Du'a library is a seeded, read-only collection organized by occasion tags. User can mark any Du'a as a favorite; favorites surface first. |
| ISL-13 | AI Coach weekly synthesis (existing screen 50) includes a spiritual consistency metric combining prayer punctuality (from prayer notifications accepted/dismissed, if tracked), Quran pages read, and Adhkar completion rate for the week. |
| ISL-14 | Quran reading goal is user-set (e.g. "10 pages/day") and can be tied to the existing Non-Negotiable Daily Goals system from the base spec. |

#### Non-Functional Requirements
- Adhkar and Du'a content is seeded locally (bundled with the app) — no network call required after install. Content is stored in a local JSON asset, not Firestore, since it is read-only and identical for all users.
- Arabic text must render correctly with proper Tashkeel (diacritics) using the Cairo/IBM Plex Arabic font already in the locked design system.
- Adhkar checklist state (which items are ticked today) resets at Fajr time (not midnight), consistent with Islamic tradition.

#### Edge Cases
- User tries to log more Quran pages today than are in the Quran (604 pages total) → cap at 604 with no error, just a silent maximum boundary.
- User completes Adhkar after Dhuhr (i.e., morning Adhkar after its optimal window) → log it as completed anyway, no penalty or warning. The app does not gatekeep when spiritual acts are performed.
- AI Coach references spiritual data for a non-Muslim user (spiritual layer disabled) → spiritual consistency metric is completely absent from that user's weekly synthesis. Zero bleed between user types.

#### Data Models
```
Collection: quran_logs
{
  id: string,
  uid: string,
  pagesRead: number,
  cumulativePages: number,        // running total, denormalized for fast dashboard reads
  loggedAt: timestamp
}

Collection: adhkar_logs
{
  id: string,
  uid: string,
  session: "morning" | "evening",
  completedItemIds: [string],     // IDs from the local adhkar asset
  completedAt: timestamp
}

Local asset (bundled, not Firestore):
assets/data/adhkar.json          // ordered list: { id, arabicText, transliteration, translationAr, translationEn, count, occasion }
assets/data/dua_library.json     // { id, arabicText, transliteration, translationAr, translationEn, occasions: [string] }

Field added to existing users collection:
quranGoal: { dailyPagesTarget: number }

Collection: dua_favorites
{
  uid: string,                    // doc ID = uid
  favoriteIds: [string]           // array of du'a IDs from local asset
}
```

#### API Contract (Repository Layer)
```dart
class SpiritualRepository {
  // Quran
  Future<void> logQuranPages({required int pages});
  Stream<QuranProgress> watchTodayQuranProgress();
  Future<QuranProgress> getWeeklyQuranSummary();

  // Adhkar
  Future<List<DhikrItem>> getAdhkarForSession(AdhkarSession session); // reads local asset
  Future<void> logAdhkarCompletion({required AdhkarSession session, required List<String> completedIds});
  Stream<AdhkarLog?> watchTodayAdhkarLog(AdhkarSession session);

  // Du'a
  Future<List<DuaItem>> getDuaLibrary({String? occasionFilter});       // reads local asset
  Future<void> toggleDuaFavorite(String duaId);
  Future<List<String>> getFavoriteIds();
}
```

#### Screens — Tier 2 (4 screens: 100–103)
100. **Quran Tracker** — today's page log, streak, weekly progress bar, cumulative total.
101. **Adhkar Checklist** — morning/evening tab toggle, ordered checklist with Arabic text and repetition counter per item, resets at Fajr.
102. **Du'a Library** — searchable, filterable by occasion, favorites section at top.
103. **Spiritual Weekly Summary** — standalone view of the AI-generated spiritual consistency metric (accessible from AI Coach weekly screen and Islamic Hub).

---

### 6.5.4 Integration Points with Existing Layers

| This feature | Integrates with | How |
|---|---|---|
| Prayer countdown (Tier 1) | Layer 2 (Daily OS) | Next-prayer countdown appears on Home Dashboard as a persistent time-block anchor |
| Prayer times (Tier 1) | Layer 2 (Daily OS) | Prayer-relative time-blocking already uses Aladhan API — Tier 1 reuses the same data fetch, no duplication |
| Quran tracker (Tier 2) | Layer 4 (Habit Engine) | `quran_logs` feeds into habit streak calculation for the "10 pages Quran" non-negotiable goal |
| Adhkar logs (Tier 2) | Layer 4 (Habit Engine) | `adhkar_logs` feeds habit streaks identically to domain logs |
| Spiritual consistency (Tier 2) | Layer 5 (AI Coach) | Weekly synthesis (screen 50) receives spiritual metrics via `SpiritualRepository.getWeeklyQuranSummary()` |
| Hijri calendar (Tier 1) | Layer 2 (Daily OS) | Islamic occasions (Ramadan, etc.) surface in the routine planner as contextual schedule modifiers |

---

### 6.5.5 Implementation Priority Within the Roadmap
- **Tier 1 (screens 95–99):** Implement immediately in Phase 2.5 alongside Finance Layer. Aladhan API is already locked and partially integrated — Tier 1 is low-risk, high-visibility, and directly differentiates Rizen in the Arab market.
- **Tier 2 (screens 100–103):** Implement in Phase 4 (AI Coach integration) since Tier 2 requires the AI Coach weekly synthesis pipeline to be active to deliver the spiritual consistency metric.



| Range | Section |
|---|---|
| 1–73 | Base spec (unchanged) |
| 74–81 | Personal Finance (Layer 8) |
| 82–87 | Learning Roadmap Engine (Layer 9) |
| 88–90 | Workout Session Builder (Sports extension) |
| 91 | Kitchen Multi-Timer (Cooking extension, optional standalone) |
| 92–94 | Preset Challenge Plans |
| 95–103 | Islamic Feature Suite (Layer 10) |

Predictive Nutrition Analytics (Section 4) adds no new screens — integrates into existing screen 50 (AI Weekly Analytical Synthesis).

---

## 8. Refinements to Existing Kill Features

### 8.1 Passive Sleep Tracking → Interactive Confirmation Model
**Base spec behavior:** First phone unlock is treated directly as the wake timestamp, no confirmation.
**Refined behavior:** When the app detects an inactivity gap ≥ a configurable threshold (default 3 hours) overlapping the user's known rest window, the **next** app open shows a confirmation prompt: "You were inactive from [start] to [end] — were you asleep?" Only on **Yes** does this get logged to the sleep/habit tracker. This avoids false-positives (e.g. phone left in a bag, not actually sleeping) corrupting the Bed Resistance Metric.

**Data model addition:**
```
Collection: sleep_logs
{ id: string, uid: string, inactiveStart: timestamp, inactiveEnd: timestamp, confirmed: boolean, confirmedAt: timestamp }
```

### 8.2 Non-Prayer Schedule Anchor for Non-Spiritual Users
**Base spec behavior:** Spiritual Layer is "optional" but the alternate scheduling mechanism for users who disable it is unspecified.
**Refined behavior:** During Onboarding Step 2 (Spiritual Layer Activation, base spec screen 7), if the user disables the spiritual layer, the app asks one follow-up question instead: "What time does your day usually start?" That `wakeTime` becomes the anchor for all relative time-blocks for that user (e.g. "30 mins after wake" replaces "15 mins after Asr"), using the exact same relative-time-blocking engine already specced for prayer anchoring — only the anchor source changes.

**Data model addition:**
```
Field added to existing users collection:
scheduleAnchor: { type: "prayer" | "wakeTime", wakeTime: string? }  // wakeTime as "HH:mm" if type is wakeTime
```

No new screens required — this is a one-question branch within the existing Onboarding Step 2 screen.

---

## 9. Roadmap & Phase Plan Impact

The base spec's 22-week roadmap did not budget for this scope. Recommended approach: **treat this addendum as Phase 2.5 / a parallel track**, not a full roadmap renumbering, to avoid destabilizing work already completed (Notes, Domain Trackers).

| New work | Suggested phase placement |
|---|---|
| Layer 8 (Finance) | Phase 2.5 — after Domain Trackers, runs in parallel with Phase 3 |
| **Layer 10 Tier 1 (Islamic Hub, Prayer Times, Qibla, Hijri)** | **Phase 2.5 — alongside Finance; Aladhan API already partially integrated, low-risk high-visibility** |
| Layer 9 (Learning Roadmap) | Phase 4 — shares Gemini + Cloud Function infrastructure with AI Coach |
| **Layer 10 Tier 2 (Quran, Adhkar, Du'a)** | **Phase 4 — requires AI Coach weekly synthesis pipeline to be active** |
| Workout Builder, Nutrition Predictive, Kitchen Multi-Timer | Phase 2 extensions — build alongside Domain Trackers Sports/Cooking pillars |
| Preset Challenge Plans | Short phase after Phase 3 (Habit Engine) |
| Sleep confirmation + schedule-anchor refinements | Phase 4 — refinements to work not yet started |

**Net effect:** roadmap extends from 22 weeks to an estimated **32–36 weeks**. Re-baseline once Phase 2.5 closes.

---

## 10. Immediate Next Step

This addendum is now the authoritative scope document alongside the two base files. Before resuming any agent-driven build work:

1. Commit this file to the repo root alongside `MASTER_PRODUCT_SPEC.md`.
2. Update `AGENTS.md` to reference both documents as required reading for any agent touching Finance, Learning Roadmap, Sports, Cooking, or Onboarding folders.
3. Resume build only after both are committed — this keeps the documentation-first discipline already established for `AGENTS.md`.
