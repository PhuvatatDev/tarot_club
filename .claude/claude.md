# TarotClub – Claude Project Context

## 🧠 Project Description

TarotClub is a symbolic and introspective mobile app designed to help users self-reflect and navigate difficult or meaningful life moments through personalized tarot card readings.

Each session includes:
- A **user-submitted intention**
- A **random draw using Random.org**
- A **personalized interpretation from an AI model** (currently OpenAI GPT)
- A choice of **visual and auditory ambiance** to enhance focus and immersion
- A **saved journal entry** that stores the session in Firestore at a precise timestamp

Users can revisit previous draws, add personal notes, or continue reflection by asking new questions based on the same draw.

The goal is to create an emotional tracking tool that supports spiritual autonomy — not prediction.

## 🧱 Architecture Overview

- The project follows **Clean Architecture**:
  - `data/`: data models, remote sources, repositories
  - `domain/`: usecases, entities, interfaces
  - `presentation/`: UI, state (via Cubit), widgets
- All features live inside `lib/features/<feature_name>/`
- Global reusable elements are in `lib/core/`
- Configuration files are in `lib/config/` (themes, Firebase, routing)

## 📂 Features (defined)

- `auth`: Firebase login/register/logout
- `draw`: draw flow, intention form, card generation, prompt building
- `journal`: saved draw history (by date), calendar-style UI, user notes
- `tarot_docs`: card documentation (upright & reversed)
- `profile`: user bio (used in prompts), preferences
- `ambiance`: music + background selection before drawing
- `settings`: account deletion, language, dark mode, etc.
- `home`: global navigation and entry point
- `subscriptions`: manage premium access and payment flow (TBD)

## ⚙️ Tech Stack

- Flutter + Dart (frontend)
- Firebase Auth + Firestore (backend)
- Cloud Functions written in **TypeScript**
- API integration:
  - `random.org` for unbiased card draw (true randomness via JSON-RPC API)
  - `OpenAI` (currently) for IA interpretation
  - Future AI providers may be integrated as alternatives

## 📁 Claude Prompt Workflow

Prompt files are stored in `.claude/prompts/`. Each one targets a single feature or concern.  
Claude Code uses these prompts to build code when calling `/sc: build <prompt>`.

Prompts should contain:
- The feature name and its user-facing goal
- Required inputs (form, models, events)
- Expected outputs (state, UI, repository changes)
- Any relevant backend flow or Cloud Function logic

Claude may suggest updates to this file if project structure, logic, or architecture evolves.  
Prompt updates or feature expansions are welcome, as long as they comply with core architecture principles.

## ✅ Claude Behavior Guidelines

When Claude Code generates, edits, or reviews code, it must follow:

1. Clean Architecture rules strictly. Each feature has `data/`, `domain/`, `presentation/`.
2. All logic must pass through usecases and repositories. No business logic in UI.
3. State is handled via Cubit (from `flutter_bloc`). No StatefulWidgets unless explicitly required.
4. No direct calls to Firebase or OpenAI in presentation. All side-effects go through usecases.
5. Cloud Function interactions must be abstracted via `usecase -> repository -> datasource`.
6. Draws are saved in Firestore under `users/{uid}/journal/{draw_id}` with:
   - type, timestamp, cards, reversed flag, intention, GPT response, optional user note
7. AI prompt construction includes:
   - user bio (from profile)
   - intention
   - cards drawn (names + reversed)
   - draw type

## 🔐 Security + Infra Rules

- Cloud Functions must verify Firebase ID tokens before accepting requests.
- Firestore rules prevent any cross-user data access.
- API keys must never appear in the Flutter frontend.
- All sensitive calls (OpenAI, Random.org) are executed server-side via HTTPS functions.

## 🧪 Testing Workflow

Claude Code is expected to test all business logic through unit tests (for usecases and repositories) and widget tests for critical UI behavior.

Tests are triggered manually via `/sc: test` or included automatically in feature prompts (if specified).  
The folder structure for tests mirrors the `lib/` layout: `test/features/<feature>/domain/usecases/`, etc.

Testing is encouraged during each build/refactor step to catch bugs early and validate architecture consistency.

Claude may be instructed to include tests in each feature build, or review missing test coverage using `/sc: review`.

## 🧠 Claude Code Scope

You (Claude) may:
- Generate code via `/sc: build`
- Refactor existing files via `/sc: refactor`
- Audit structure via `/sc: review`
- Explain logic via `/sc: explain`
- Help create backend handlers in TypeScript for Cloud Functions
- Use `/sc: test` if unit tests are requested for usecases or logic

You may not:
- Invent folders or features not defined in `features/`
- Skip usecases when business logic is required
- Inject code that bypasses the architectural layers
- Output anything that breaks Clean Architecture
