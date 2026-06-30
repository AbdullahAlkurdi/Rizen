# Rizen CLI

Terminal interface for Rizen — an AI-powered Life Operating System for discipline, productivity, burnout prevention, and spiritual consistency.

## Installation

```bash
cd cli
dart pub get
```

## Quick Start

```bash
# Authenticate
dart run rizen login

# View today's status
dart run rizen status

# Log a domain session
dart run rizen log coding --duration 2h --notes "Completed API layer"

# Work with habits
dart run rizen habit list
dart run rizen habit check "Morning Gym"

# Manage todos
dart run rizen todo list --habit "Morning Gym"
dart run rizen todo check "Morning Gym" "Drink water"

# View routines
dart run rizen routine today

# View analytics
dart run rizen analytics growth
dart run rizen analytics week

# Logout
dart run rizen logout
```

## Command Reference

### Authentication

| Command | Description |
|---------|-------------|
| `rizen login` | Authenticate with Firebase (email/password) |
| `rizen logout` | Clear local credentials and sign out |

### Status

| Command | Description |
|---------|-------------|
| `rizen status` | Show today's habits, routine, sleep, and growth index |

### Logging

| Command | Description |
|---------|-------------|
| `rizen log <domain> --duration <time> --notes <text>` | Log a session |

**Valid domains:** `sports`, `study`, `work`, `coding`, `nutrition`, `spiritual`, `custom`

**Duration formats:** `30m`, `1h`, `1h 30m`

### Habits

| Command | Description |
|---------|-------------|
| `rizen habit list` | List all habits with completion status |
| `rizen habit check <name>` | Mark habit as complete for today |
| `rizen habit streak <name>` | Show current and longest streak |

### Todos

| Command | Description |
|---------|-------------|
| `rizen todo list --habit <name>` | List todo items for a habit |
| `rizen todo check <habit> <item>` | Mark todo item complete |
| `rizen todo uncheck <habit> <item>` | Unmark todo item |

### Routines

| Command | Description |
|---------|-------------|
| `rizen routine today` | Show today's routine blocks |
| `rizen routine next` | Show the next upcoming block |

### Analytics

| Command | Description |
|---------|-------------|
| `rizen analytics growth` | Show growth index with burnout risk |
| `rizen analytics week` | Show weekly summary per domain |

## Domains

| Domain | Description |
|--------|-------------|
| `sports` | Physical activity, gym, cardio |
| `study` | Academic learning, reading |
| `work` | Professional tasks |
| `coding` | Development, side projects |
| `nutrition` | Meals, hydration |
| `spiritual` | Prayer, Quran, reflection |
| `custom` | User-defined activities |

## Authentication Guide

1. First run `rizen login`
2. Enter your Firebase email and password
3. Credentials stored locally in `.rizen/credentials.json`
4. Use `rizen logout` to clear credentials

## Examples

```bash
# Log a coding session
rizen log coding --duration 2h --notes "Refactored auth flow"

# Check off a habit
rizen habit check "Morning Gym"

# See today's status
rizen status

# Log 30 minutes of spiritual practice
rizen log spiritual --duration 30m

# List todos for a specific habit
rizen todo list --habit "Morning Gym"
```

## Configuration

Create a `.env` file in the project root with Firebase credentials:

```
FIREBASE_API_KEY=your_api_key
FIREBASE_APP_ID=your_app_id
FIREBASE_SENDER_ID=your_sender_id
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_AUTH_DOMAIN=your_auth_domain
FIREBASE_STORAGE_BUCKET=your_storage_bucket
```

## License

Proprietary — All Rights Reserved.
