# 🔮 TarotClub

**TarotClub** is a personal mobile application built in Flutter using **Clean Architecture**.  
Its purpose is to provide tarot readings with personalized interpretations using AI (GPT).  
Users can either draw a card from the app or select one manually, then receive a contextual analysis based on their personal bio.

---

## 🧠 Project Context

This app is part of my journey to become a proficient **Flutter developer**, mastering both UI and scalable logic using Clean Architecture principles.  
The focus is on **clean code**, **modular structure**, and real-world mobile UX.

---

## ⚙️ Architecture: Clean & Scalable

Project is structured by feature with layered separation:

lib/
├── config/ # Global setup (constants, firebase_options, etc.)
├── features/
│ └── auth/ # Authentication feature
│ ├── data/
│ ├── domain/
│ └── presentation/
├── themes/ # Theme and styling
├── main.dart # Entry point
└── app.dart # Root app widget



---

## 🔐 Auth Feature (status: ✅ Started)

- `AuthCubit` created and handles authentication states
- `AuthRepo` defines the abstract contract
- `FirebaseAuthRepoImpl` implements login/register using FirebaseAuth
- `AppUser` entity created

---

## 🚧 Features To Do

### 🔹 Auth
- [ ] Register page UI
- [ ] Login page UI
- [ ] Password reset
- [ ] Save user bio in Firestore

### 🔹 Draw
- [ ] Load tarot cards from local assets (JSON + images)
- [ ] Random draw via API (random.org)
- [ ] Manual draw (user selects a card)
- [ ] Connect to GPT API for interpretation
- [ ] Save draw + interpretation to Firestore

### 🔹 Journal
- [ ] User can write notes after draw
- [ ] Display past draws with interpretations
- [ ] Filter by date or card

### 🔹 Profile
- [ ] Editable user bio
- [ ] Store bio in Firestore
- [ ] Use bio in GPT prompts

### 🔹 Settings
- [ ] Dark/light theme toggle
- [ ] Delete account

---

## 🛠 Technologies

- Flutter
- Firebase Auth
- Firestore
- Cloud Functions (GPT API)
- BLoC / Cubit (flutter_bloc)
- Clean Architecture

---

## 👤 Developer

**PVTDev**  
_I build business-ready mobile applications._

GitHub: [github.com/PhuvatatDev](https://github.com/PhuvatatDev)

---

