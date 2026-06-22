# RizenOS — Master Product Specification Addendum v1.0

**Status:** Authoritative. Supersedes/extends `MASTER_PRODUCT_SPEC.md` and `PROJECT_KNOWLEDGE.md` wherever scope overlaps. Both base documents remain valid; this addendum closes gaps identified in product review on 2026-06-21.

**Effect on roadmap:** Adds 2 new architectural layers (8, 9), extends 3 existing Domain Pillars, adds 1 new cross-cutting feature system, and refines 2 existing kill features. Total screen count rises from 73 to **94** (see Section 9 for the full delta). Phase plan impact is detailed in Section 10 — read before resuming development.

**Locked stack reminder:** Everything below uses the same non-negotiable stack as the base spec — Flutter (BLoC/Cubit, GoRouter, Freezed, Dio), Firebase (Firestore, Auth, Cloud Functions, Storage), Gemini AI, Aladhan API. No exceptions introduced here.

---

## 0\. Why This Addendum Exists

The original 7-layer / 73-screen spec captured the disciplined-productivity core of RizenOS (habits, prayer-relative scheduling, burnout prevention, AI coaching) but omitted seven features the founder considers core to the product vision:

1. Full personal finance / budget management  
2. AI-driven learning roadmap ingestion (PDF → auto-scheduled curriculum)  
3. AI-generated complete workout sessions (not just logging)  
4. Predictive weight/nutrition trend analysis  
5. Multi-timer kitchen/cooking assistant  
6. Preset challenge plans (e.g. "75 Hard") with permission-linked activation  
7. Non-prayer-based schedule anchoring for non-spiritual users

Two existing features also need mechanism refinement (Section 8).

This document treats each gap with the same rigor as the base spec: goals, user stories, functional/non-functional requirements, edge cases, data models, API contracts, and implementation notes. No placeholders.

---

## 1\. NEW LAYER 8 — Personal Finance & Budget Management

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
| :---- | :---- |
| FIN-1 | User sets `monthlyIncome` (SAR or any ISO 4217 currency) during onboarding or in Settings. |
| FIN-2 | User can add a `FinancialCommitment` with name, amount, and frequency (`daily`/`weekly`/`monthly`). |
| FIN-3 | User can quick-add a `Transaction` via free-text natural language input, parsed by Gemini into `{description, amount, category, type}`. |
| FIN-4 | User can manually add a `Transaction` via structured form (description, amount, category, type, frequency tag) as fallback if AI parsing fails or is rejected. |
| FIN-5 | A Cloud Function triggers once daily (user's local end-of-day, derived from their schedule anchor — see Section 8.2) prompting: "You logged N items today — anything else to add?" |
| FIN-6 | Monthly report aggregates: total income, total committed (recurring), total spent (ad-hoc \+ recurring), remaining balance. |
| FIN-7 | Emergency/ad-hoc expense entry requires only `amount` \+ free-text `description`; category is optional and can be backfilled by AI suggestion. |
| FIN-8 | Budget resets on a rolling monthly cycle anchored to the day the user first set `monthlyIncome` (not necessarily calendar-month-1). |

### 1.4 Non-Functional Requirements

- Quick-entry parsing (FIN-3) must return a result in under 2 seconds (Gemini Flash latency budget) or fall back to the manual form (FIN-4) automatically.  
- All financial data is stored Firestore-side scoped strictly to `uid`; no financial data is ever sent to Gemini without being stripped of any other PII beyond the transaction text itself.  
- Currency is configurable but defaults to SAR given primary user base.

### 1.5 Edge Cases

- User logs an expense that exceeds remaining monthly budget → app shows the overage visually (no blocking, no shaming language per AI Rules — e.g. "You've used 105% of this month's budget" not "You're overspending\!").  
- User has zero recurring commitments → monthly report still renders, recurring section shows empty state, not an error.  
- AI quick-entry parses ambiguous input (e.g. "كذا 50" with no clear description) → falls back to asking one clarifying follow-up via the same input bar, not a full-screen interruption.  
- User changes `monthlyIncome` mid-cycle → current cycle's report uses a weighted/prorated calculation, flagged in the UI as "adjusted mid-month."

### 1.6 Data Models

Collection: transactions

{

  id: string,

  uid: string,

  amount: number,

  currency: string,            // ISO 4217, default "SAR"

  description: string,

  category: string,            // e.g. "food", "transport", "emergency", nullable until categorized

  type: "income" | "expense",

  source: "quick\_entry" | "manual" | "recurring\_auto",

  loggedAt: timestamp,

  createdAt: timestamp

}

Collection: financial\_commitments

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

Collection: budget\_cycles

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

Firestore security rule pattern (matches `notes` collection precedent): all three collections readable/writable only where `request.auth.uid == resource.data.uid`.

### 1.7 API Contracts (Repository Layer)

class FinanceRepository {

  Future\<Transaction\> addTransaction({required double amount, required String description, String? category, required TransactionType type, TransactionSource source});

  Future\<List\<Transaction\>\> getTransactionsForCycle(String cycleId);

  Future\<void\> addCommitment({required String name, required double amount, required CommitmentFrequency frequency});

  Future\<BudgetCycle\> getCurrentCycle();

  Future\<BudgetCycle\> closeCycleAndStartNew();

  Stream\<BudgetCycle\> watchCurrentCycle();

}

### 1.8 Screens (8 new screens — appended to the 73-screen base as 74–81)

74. **Finance Setup** — onboarding/settings screen to set monthly income and currency.  
75. **Quick Expense Entry** — single text field, AI-parsed, confirms parsed result before saving.  
76. **Manual Transaction Form** — structured fallback entry.  
77. **Financial Commitments List** — add/edit/deactivate recurring commitments.  
78. **Daily Expense Review** — end-of-day AI-prompted reconciliation sheet.  
79. **Monthly Budget Report** — income vs. spent vs. remaining, category breakdown chart.  
80. **Emergency Expense Entry** — minimal-friction amount \+ description form.  
81. **Finance Settings** — currency, cycle start day, notification preferences for daily review prompt.

### 1.9 Implementation Notes

- Follow the exact vertical-slice pattern already proven in `lib/features/notes/`: `data/models/`, `data/repositories/`, `presentation/cubit/`.  
- Gemini quick-entry parsing should use a constrained JSON-output prompt (see `structured_outputs` pattern) — never free-form text parsing in the client.  
- The end-of-day Cloud Function trigger should reuse whatever daily-reset Cloud Function infrastructure already exists for the Daily OS layer (Layer 2\) rather than creating a parallel scheduler.

---

## 2\. NEW LAYER 9 — AI-Powered Learning Roadmap Engine

### 2.1 Goals

Let the user upload any structured learning plan (a PDF roadmap — e.g. "Full-Stack Developer Roadmap") and have RizenOS automatically convert it into a sequence of scheduled, time-estimated, trackable tasks — then silently adapt pacing to the user's actual completion speed without ever telling the user "you are slow" or "you are fast."

### 2.2 User Stories

- As a user, I upload a PDF roadmap and the app extracts an ordered list of topics/tasks.  
- As a user, I get a notification suggesting today's topic: "You're still motivated — review how the web works. Should take about 5 minutes."  
- As a user, I mark a task ✔ when done or − when deferred, and deferred tasks resurface later.  
- As a user, the app silently tracks how long each task actually took me vs. its estimate, and adjusts future estimates and pacing for me specifically — without exposing a "skill level" label.

### 2.3 Functional Requirements

| ID | Requirement |
| :---- | :---- |
| LRN-1 | User uploads a PDF via file picker; requires storage/file-read permission requested contextually at this screen only. |
| LRN-2 | PDF text is extracted (Cloud Function, server-side) and sent to Gemini with a structured-output prompt to produce an ordered topic list: `{title, description, estimatedMinutes, order}`. |
| LRN-3 | Topics are surfaced one (or a small batch) at a time as suggested daily tasks, integrated into the Daily OS (Layer 2\) time-blocking system. |
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
- Two roadmaps schedule conflicting topics on the same day → Daily OS time-blocking (Layer 2\) treats roadmap topics as flexible-priority tasks, not fixed-time blocks, so they reflow rather than collide.

### 2.6 Data Models

Collection: learning\_roadmaps

{

  id: string,

  uid: string,

  title: string,

  sourceFileName: string,

  sourceFileUrl: string,        // Firebase Storage reference

  status: "processing" | "active" | "completed" | "archived",

  createdAt: timestamp

}

Collection: roadmap\_topics

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

Collection: user\_comprehension\_profiles

{

  uid: string,                  // doc ID \= uid

  avgCompletionRatio: number,   // rolling average of actual/estimated

  sampleCount: number,

  lastUpdated: timestamp

}

### 2.7 API Contracts (Repository Layer)

class RoadmapRepository {

  Future\<LearningRoadmap\> uploadRoadmap(File pdfFile, {required String title});

  Future\<List\<RoadmapTopic\>\> getTopicsForRoadmap(String roadmapId);

  Future\<void\> markTopicStatus(String topicId, TopicStatus status);

  Stream\<RoadmapTopic?\> watchSuggestedTopicForToday();

  Future\<void\> recalculateComprehensionProfile(); // invoked server-side via Cloud Function on topic completion

}

### 2.8 Screens (6 new screens — appended as 82–87)

82. **Roadmap Upload** — file picker, title input, processing-status indicator.  
83. **Roadmap List** — all active/completed/archived roadmaps.  
84. **Roadmap Topic Tracker** — full ordered list with ✔/− status per topic.  
85. **Topic Detail / Active Session** — shown when user starts a suggested topic; includes a timer (reuses the countdown-timer pattern from Habit check-ins).  
86. **Roadmap Confirmation Screen** — shown post-extraction when AI confidence is low, lets user edit/confirm the extracted topic list before activation.  
87. **Roadmap Settings** — pause/archive a roadmap, adjust daily topic-suggestion frequency.

### 2.9 Implementation Notes

- This is the most architecturally complex addition — it touches Layer 2 (Daily OS, for surfacing suggested topics), Layer 5 (AI Coach, for the notification copy), and Cloud Functions (PDF extraction \+ comprehension recalculation). Build the data layer and basic CRUD first (matches the project's "scaffold first, integrate second" principle), then wire the Daily OS integration as a second pass.  
- Recommend a single dedicated agent owns this Layer end-to-end given its cross-layer touchpoints — do not split model/repository/cubit work across multiple parallel agents here, the collision risk is too high.

---

## 3\. EXTENSION — Sports Pillar: AI Workout Session Builder

### 3.1 Goals

Move the Sports domain pillar from passive logging to active session generation: a full warmup → main-set → cooldown workout, generated by Gemini based on the user's stated goal and available time.

### 3.2 Functional Requirements

| ID | Requirement |
| :---- | :---- |
| WKT-1 | User specifies a goal (e.g. "upper body strength," "20-minute cardio") and available time. |
| WKT-2 | Gemini generates a structured `WorkoutSession` with ordered `WorkoutExercise` entries tagged by phase (`warmup`/`main`/`cooldown`), each with sets/reps or duration. |
| WKT-3 | User can edit any generated exercise (swap, remove, adjust reps) before starting. |
| WKT-4 | An Active Session Player runs the session with per-exercise timers and rest-period countdowns, auto-advancing through the sequence. |
| WKT-5 | On completion, the session logs to the existing `domain_logs` collection (Section established in current build) with `duration` and a reference to the generated `WorkoutSession`. |

### 3.3 Data Models

Collection: workout\_sessions

{

  id: string,

  uid: string,

  title: string,

  goal: string,

  totalEstimatedMinutes: number,

  exercises: \[

    { name: string, phase: "warmup"|"main"|"cooldown", sets: number?, reps: number?, durationSeconds: number?, restSeconds: number }

  \],

  generatedBy: "ai" | "manual",

  completedAt: timestamp        // nullable until finished

}

### 3.4 Screens (3 new — appended as 88–90)

88. **Generate Workout** — goal \+ time input, triggers Gemini generation.  
89. **Workout Preview/Edit** — review and adjust generated exercises before starting.  
90. **Active Session Player** — full-screen guided run-through with timers.

### 3.5 Edge Cases

- User has a documented injury/limitation noted elsewhere in their profile → Gemini prompt for WKT-2 must incorporate any user-disclosed physical limitations to avoid generating contraindicated exercises. If no limitation is on file, generate standard sessions without assuming any.  
- Generated session exceeds the user's stated available time → regenerate with a tighter constraint rather than silently truncating mid-exercise.

---

## 4\. EXTENSION — Nutrition Pillar: Predictive Trend Analytics

### 4.1 Goals

Surface a general, non-prescriptive trend insight (e.g. "at this pace, current eating pattern trends toward \+0.5kg over 2 weeks") inside the AI Coach's weekly synthesis — not a real-time calorie-counting feature.

### 4.2 Functional Requirements

| ID | Requirement |
| :---- | :---- |
| NUT-1 | User can log `WeightEntry` (weight \+ timestamp) independently of meal logs. |
| NUT-2 | AI Weekly Synthesis (existing screen, Layer 5\) correlates recent `WeightEntry` trend with meal-log frequency/category patterns and surfaces one plain-language observation. |
| NUT-3 | No specific calorie/macro targets, diet plans, or numeric prescriptive guidance are generated — this stays observational, not directive, consistent with the app's wellbeing-safe tone. |

### 4.3 Data Models

Collection: weight\_entries

{ id: string, uid: string, weightKg: number, loggedAt: timestamp }

### 4.4 Implementation Notes

This extension deliberately stays light — it plugs into the existing AI Weekly Synthesis screen (already specced) rather than creating new screens. Only one new collection (`weight_entries`) and one new log-entry point on the existing Nutrition log screen are needed.

---

## 5\. EXTENSION — Cooking/Nutrition Pillar: Multi-Timer Kitchen Assistant

### 5.1 Goals

Let a user run several concurrent named cooking timers from one screen (e.g. "rice — 18 min", "chicken — 25 min") without leaving the recipe/meal-log flow.

### 5.2 Functional Requirements

| ID | Requirement |
| :---- | :---- |
| KIT-1 | User can start multiple independent named countdown timers from a single screen. |
| KIT-2 | Each timer shows independently and fires its own notification/alert on completion. |
| KIT-3 | Timers persist across app backgrounding (standard local notification scheduling, not a Firestore-backed feature — this is purely local state). |

### 5.3 Implementation Notes

This is a **local-only, client-side feature** — no new Firestore collection needed. Implement as a `MultiTimerCubit` holding a list of in-memory timer states, each backed by a scheduled local notification (`flutter_local_notifications` or platform-native scheduling) so timers fire even if the app is backgrounded. No new screen needed if integrated as a widget within the existing Meal Log screen (screen 32 in the base spec); add one new screen only if a standalone "Kitchen Timers" entry point is desired.

### 5.4 Screens (1 new, optional — appended as 91\)

91. **Kitchen Multi-Timer** — standalone screen showing all active named timers, accessible from the Cooking/Nutrition dashboard.

---

## 6\. NEW FEATURE — Preset Challenge Plans

### 6.1 Goals

Let users opt into a pre-built challenge template (e.g. "75 Hard"–style) with its own daily requirement checklist, where the plan itself declares which device permissions it needs (e.g. camera for daily progress photos), requested only at enrollment, not at app install.

### 6.2 Functional Requirements

| ID | Requirement |
| :---- | :---- |
| CHL-1 | A `ChallengePlan` catalog (seeded, not user-created) defines `durationDays` and a list of `dailyRequirements`. |
| CHL-2 | Each `ChallengePlan` declares `requiredPermissions` (e.g. `["camera"]`); these are requested via the OS permission dialog only when the user enrolls in a plan that needs them. |
| CHL-3 | User enrolls in a plan, creating a `UserChallengeEnrollment` tracking `currentDay` and daily checklist completion. |
| CHL-4 | If a plan requires a daily photo, the check-in screen opens the camera directly; the photo is stored in Firebase Storage, referenced from that day's enrollment record. |
| CHL-5 | Missing a day's requirement does not silently fail the challenge — per the base spec's Resilience principle, missed days are logged but the user decides whether to restart, consistent with "missing a day is not failure." |

### 6.3 Data Models

Collection: challenge\_plans   // seeded/static catalog, not user-writable

{ id: string, name: string, durationDays: number, dailyRequirements: \[{ id: string, label: string }\], requiredPermissions: \[string\] }

Collection: user\_challenge\_enrollments

{

  id: string, uid: string, planId: string,

  startDate: timestamp, currentDay: number,

  status: "active" | "completed" | "abandoned",

  dailyLogs: \[{ day: number, completedRequirementIds: \[string\], photoUrl: string? }\]

}

### 6.4 Screens (3 new — appended as 92–94)

92. **Challenge Library** — browse seeded plans.  
93. **Challenge Detail / Enroll** — plan details, permission disclosure before enrollment.  
94. **Daily Challenge Check-in** — per-day checklist \+ camera capture if required.

---

## 7\. Updated 73 → 94 Screen Count Summary

| Range | Section |
| :---- | :---- |
| 1–73 | Base spec (unchanged) |
| 74–81 | Personal Finance (Layer 8\) |
| 82–87 | Learning Roadmap Engine (Layer 9\) |
| 88–90 | Workout Session Builder (Sports extension) |
| 91 | Kitchen Multi-Timer (Cooking extension, optional standalone) |
| 92–94 | Preset Challenge Plans |

Predictive Nutrition Analytics (Section 4\) adds no new screens — integrates into existing screen 50 (AI Weekly Analytical Synthesis).

---

## 8\. Refinements to Existing Kill Features

### 8.1 Passive Sleep Tracking → Interactive Confirmation Model

**Base spec behavior:** First phone unlock is treated directly as the wake timestamp, no confirmation. **Refined behavior:** When the app detects an inactivity gap ≥ a configurable threshold (default 3 hours) overlapping the user's known rest window, the **next** app open shows a confirmation prompt: "You were inactive from \[start\] to \[end\] — were you asleep?" Only on **Yes** does this get logged to the sleep/habit tracker. This avoids false-positives (e.g. phone left in a bag, not actually sleeping) corrupting the Bed Resistance Metric.

**Data model addition:**

Collection: sleep\_logs

{ id: string, uid: string, inactiveStart: timestamp, inactiveEnd: timestamp, confirmed: boolean, confirmedAt: timestamp }

### 8.2 Non-Prayer Schedule Anchor for Non-Spiritual Users

**Base spec behavior:** Spiritual Layer is "optional" but the alternate scheduling mechanism for users who disable it is unspecified. **Refined behavior:** During Onboarding Step 2 (Spiritual Layer Activation, base spec screen 7), if the user disables the spiritual layer, the app asks one follow-up question instead: "What time does your day usually start?" That `wakeTime` becomes the anchor for all relative time-blocks for that user (e.g. "30 mins after wake" replaces "15 mins after Asr"), using the exact same relative-time-blocking engine already specced for prayer anchoring — only the anchor source changes.

**Data model addition:**

Field added to existing users collection:

scheduleAnchor: { type: "prayer" | "wakeTime", wakeTime: string? }  // wakeTime as "HH:mm" if type is wakeTime

No new screens required — this is a one-question branch within the existing Onboarding Step 2 screen.

---

## 9\. Roadmap & Phase Plan Impact

The base spec's 22-week roadmap did not budget for this scope. Recommended approach: **treat this addendum as Phase 2.5 / a parallel track**, not a full roadmap renumbering, to avoid destabilizing work already completed (Notes, Domain Trackers).

| New work | Suggested phase placement |
| :---- | :---- |
| Layer 8 (Finance) | New Phase, after current Phase 2 (Domain Trackers) completes — independent of habit/coach work, can run in parallel with Phase 3 |
| Layer 9 (Learning Roadmap) | Placed alongside Phase 4 (AI Coach) — shares Gemini integration patterns and Cloud Function infrastructure |
| Workout Builder, Nutrition Predictive, Kitchen Multi-Timer | Folded into Phase 2 (Domain Trackers) as extensions of Sports/Cooking pillars — build alongside, not after |
| Preset Challenge Plans | New short phase after Phase 3 (Habit Engine) — conceptually adjacent to habit tracking |
| Sleep confirmation \+ schedule-anchor refinements | Apply during Phase 4 (AI Coach / sleep tracking) — these are refinements to work not yet started, no rework needed |

**Net effect:** roadmap extends from 22 weeks to an estimated **30–34 weeks**, given two entirely new layers and three pillar extensions. This is an estimate for planning purposes, not a commitment — re-baseline once Phase 2 fully closes.

---

## 10\. Immediate Next Step

This addendum is now the authoritative scope document alongside the two base files. Before resuming any agent-driven build work:

1. Commit this file to the repo root alongside `MASTER_PRODUCT_SPEC.md`.  
2. Update `AGENTS.md` to reference both documents as required reading for any agent touching Finance, Learning Roadmap, Sports, Cooking, or Onboarding folders.  
3. Resume build only after both are committed — this keeps the documentation-first discipline already established for `AGENTS.md`.

