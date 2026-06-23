# RizenOS Agent Coordination and Technical Standards

Welcome to the RizenOS workspace! This document serves as the absolute authority on team collaboration guidelines, technological choices, and structural conventions for all AI developers, sub-agents, and automated systems participating in the development of RizenOS.

---

## 1. Locked Technical Stack

To maintain strict architectural consistency, avoid fragmentation, and ensure maximum performance and maintainability, the technical stack is **strictly locked**. No alternative packages, state management systems, or database libraries may be introduced without explicit human-in-the-loop authorization.

### Core Stack Component Grid

| Layer | Technology / Library | Description | Status |
|---|---|---|---|
| **Platform / UI** | **Flutter** | Cross-platform UI toolkit. Target SDK environment: `^3.11.5`. | **LOCKED** |
| **State Management** | **BLoC / Cubit** (`flutter_bloc`) | Architectural state management pattern. Always separate business logic from UI. | **LOCKED** |
| **Routing** | **GoRouter** (`go_router`) | Declarative routing system for Flutter. Used for deep-linking and state-driven navigation. | **LOCKED** |
| **Code Generation** | **Freezed** & **Json Serializable** | Type-safe union/sealed classes, data classes, and serialization. | **LOCKED** |
| **Networking** | **Dio** (`dio`) | Feature-rich HTTP client for Dart with support for interceptors, global configuration, and caching. | **LOCKED** |
| **Backend & Database**| **Firebase Core, Auth, Cloud Firestore, Storage, Cloud Functions** | Fully integrated backend. Firestore is the primary operational database. | **LOCKED** |
| **AI Capabilities** | **Google Gemini AI** | Primary AI LLM provider for the AI Coach and cognitive analytics features. | **LOCKED** |
| **External API** | **Aladhan API** | Primary source for prayer timings, enabling prayer-relative scheduling calculations. | **LOCKED** |

*Note: Dev dependencies, such as standard code generation tools (`build_runner`, `freezed`, `json_serializable`), are standardized across features.*

---

## 2. Directory and Feature-First Architecture

We employ a **feature-first** organization pattern under the `lib/` directory. This encapsulates cohesive domains rather than scattering related files (like UI, controllers, and data sources) across separate global directories.

### Root and General Structure
- `lib/core/` â€” Shares global, reusable items (constants, widgets, theme, router, networks).
- `lib/features/` â€” Contains self-contained, domain-specific modules.

### Feature Subfolder Structure
Each feature within `lib/features/<feature_name>/` must conform to a strict three-layer architectural separation:

```
lib/features/<feature_name>/
â”œâ”€â”€ data/
â”‚   â”œâ”€â”€ datasources/        # Remote and local data sources (e.g., Firestore calls, local caches)
â”‚   â”œâ”€â”€ models/             # Data transfer objects, JSON serializers (Freezed/JsonSerializable)
â”‚   â””â”€â”€ repositories/       # Repository implementations (concretizes the domain repository interface)
â”‚
â”œâ”€â”€ domain/
â”‚   â”œâ”€â”€ entities/           # Pure business logic models (free from dependency-specific code)
â”‚   â”œâ”€â”€ repositories/       # Abstract repository interfaces (defining data access contracts)
â”‚   â””â”€â”€ usecases/           # Individual application-specific business logic executors
â”‚
â””â”€â”€ presentation/
    â”œâ”€â”€ bloc/               # BLoC/Cubit files for managing the UI state of this feature
    â”œâ”€â”€ pages/              # Primary fullscreen views / routing targets
    â””â”€â”€ widgets/            # Reusable sub-widgets private to this feature
```

---

## 3. Agent Coordination & Ownership Rules

To prevent conflicts, race conditions, compilation errors, and logical regressions in a multi-agent environment, the following strict collaboration rules are enforced:

### Rule 1: Single-Agent Feature Ownership (LOCKED)
- **Concept:** A feature folder (`lib/features/<name>/`) is defined as a unified boundary.
- **Rule:** **Exactly one agent may own and modify a feature folder at any given time.**
- **No Concurrent Edits:** Two agents must never execute modifications on the same feature folder concurrently. Under no circumstances should edits be performed inside a feature directory if another agent has an active lock or is actively working on it.

### Rule 2: Coordination Protocol
Before any agent starts work on a feature, they must check:
1. Active background processes.
2. The `PROGRESS_LOG.md` (or other coordination mechanism) to verify no active tasks are ongoing for that feature.
3. If an active lease or lock exists on the desired feature folder, the incoming agent must wait until the lease is cleared or coordinate its release.

### Rule 3: Shared Core Modifications
- For shared layers (such as `lib/core/`), modification requires extreme care.
- Breaking changes inside `lib/core/` are prohibited without immediate, complete refactoring of all affected features.
- If multiple features need an update in `lib/core/`, the modifying agent must notify, coordinate, or sequentially process updates.

---

## 4. Verification & Validation Standards

Every implementation cycle must end in full verification:
1. **Compilation Check:** The project must compile successfully after each feature addition.
2. **Analysis/Linter Checks:** No compilation warnings or Dart analyzer violations.
3. **Automated Testing:** Every modification must be validated by running related tests, and new features must be accompanied by relevant unit or widget tests.

## 5. Required Specification Documents
All agents must read before starting any task:
- `MASTER_PRODUCT_SPEC.md`  
- `MASTER_PRODUCT_SPEC_ADDENDUM_v1.md` (Required reading for any agent touching `lib/features/finance`, `lib/features/learning`, or `lib/features/domains/`, `lib/features/onboarding`)

