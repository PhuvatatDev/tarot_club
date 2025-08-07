# Claude Code – Project Rules for TarotClub

This file defines the key rules, architecture boundaries, and coding expectations Claude Code must follow when contributing to the TarotClub project.

---

## 🧱 Architecture Rules

1. The project follows **Clean Architecture**:
   - `domain/`: entities, usecases, abstract repositories/interfaces
   - `data/`: models, remote/local sources, concrete implementations
   - `presentation/`: Cubits, UI widgets, pages
2. Each feature lives in `lib/features/<feature_name>/`.
3. Cross-feature reusable logic or design goes in `lib/core/`.
4. Global app config lives in `lib/config/` (themes, routing, firebase, etc).
5. Only the `main.dart` and `app.dart` files are allowed at root level.

---

## 💡 Logic & State

1. All business logic must be encapsulated in usecases.
2. Presentation layer must never call Firebase, OpenAI, or external services directly.
3. Cubits must communicate only via usecases.
4. Avoid `StatefulWidget` unless strictly necessary (e.g., animation or focus control).
5. Maintain separation of concerns between UI, state, and data sources.

---

## 🔗 API & Cloud Functions

1. All external calls (OpenAI, Random.org, etc.) must go through Cloud Functions.
2. Cloud Functions are written in TypeScript and stored in `/firebase_backend/functions/`.
3. Use HTTPS callable functions or secured REST endpoints.
4. Claude must **never embed any API keys** in frontend code.
5. Firebase Auth token must be verified in every sensitive function call.

---

## 🔐 Firestore Rules & Data

1. All user data is namespaced by `users/{uid}/...`
2. Draws are saved in:  
   `users/{uid}/journal/{draw_id}`  
   with the following fields:
   - `timestamp` (DateTime)
   - `cards` (List, with reversed flag)
   - `intention` (String)
   - `aiResponse` (String)
   - `drawType` (String)
   - `note` (optional String)
3. Users cannot access each other’s data under any circumstances.
4. Write operations are permitted only to authenticated users, for their own namespace.

---

## 🎨 UI / UX Rules

1. UI must remain clean, minimal, and emotionally supportive.
2. Reuse `core/widgets/` where possible for consistency.
3. Use Cubit to control state updates, not `setState()`.
4. All text must be localizable (`S.of(context).label`).
5. Use safe areas, padding, and themes from `config/theme/`.

---

## 🧪 Testing Rules

1. Unit tests are required for:
   - Usecases
   - Repository logic
   - Cloud Function utilities (in TypeScript)
2. Widget tests are required for:
   - Forms
   - Draw interaction flow
   - Journal calendar
3. No direct Firestore access in tests. Use mocks or stubs.
4. Claude may generate tests during feature builds or after via `/sc: test`.

---

## 🔁 Claude Integration Rules

1. Claude must **never skip usecases** or bypass layers.
2. All code must respect the folder structure.
3. Claude may suggest new prompts or refactorings via `/sc: review`.
4. Claude must **not invent** features that are not listed in `claude.md`.
5. Prompt files go in `.claude/prompts/<feature>.md`, one per feature or concern.
6. Claude may suggest updates to `claude.md` or `rules.md` if the project evolves.

---

## 🪙 Subscription Feature (Future)

1. All premium access logic must be separated into `features/subscriptions`.
2. Payment API (e.g., Stripe) must be integrated server-side only.
3. Premium features must be feature-flagged in presentation logic (not hard-coded).
4. User subscription status should be stored securely in Firestore and checked via usecases.

---
