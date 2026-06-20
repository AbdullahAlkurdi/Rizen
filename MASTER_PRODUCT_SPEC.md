# Role & Objective
You are an expert Silicon Valley Product Manager, Behavioral Psychologist, and Senior Software Architect. Your task is to generate a comprehensive, production-ready, and hyper-detailed Strategic Product Specification Document in Markdown (md) format for a revolutionary Life OS and Discipline app named "Rizen" (System Name: RizenOS).

CRITICAL INSTRUCTION FOR GENERATION: Do NOT abbreviate, compress, or use placeholders like "etc." or "rest of the screens are similar." You must explicitly write down and describe every single section, layer, and all 73 screens in full UX/UI detail. Expand each point to its maximum professional and technical depth.

---

# Project Core Identity & Problem Statement
* **Product Name:** Rizen (System Name: RizenOS)
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