# Your Store App

A store application developed in **Flutter** with clean architecture principles and reactive updates.

---

## **Architecture and Technologies**

### 🏗️ VIP + Bloc Architecture
This project implements the **VIP (View-Interactor-Presenter)** architecture enhanced with **Bloc** for predictable state management:

- **View**: Handles UI and user interactions.
- **Interactor (Use Cases)**: Encapsulates business logic and communicates with repositories.
- **Presenter (Bloc)**: Acts as the state manager, connecting Views with Interactors.
- **Bloc**: Provides an event/state pattern with reactive updates for a clean separation of concerns.

---

### 🗄️ Drift for Database
We use **Drift** as the ORM for local SQLite database management, providing:

- Type-safe queries and compile-time validation.
- Reactive streams that update the UI automatically when the database changes (e.g., cart badge).

---

### 🔐 Environment Variables (.env)
We use **flutter_dotenv** to securely manage environment variables:

- Store sensitive information (API keys, base URLs) in a `.env` file.
- Access them through a dedicated `Env` class.

---

### 🎯 Bloc for State Management
- Event-driven updates ensure a predictable data flow.
- Each feature has its own Presenter (Bloc) for scalability and testability.
- Integration with Drift streams for real-time updates (e.g., cart count badge).

---

### 🧭 GoRouter for Navigation
- Declarative and type-safe routing using **GoRouter**.
- Nested routes with **StatefulShellRoute** to handle tab-based navigation.
- Easy integration with state restoration.

---

### 🛒 Reactive Cart Badge
- The **cart item count** in the navigation bar updates in **real-time**.
- Powered by Drift's `watch()` streams and a **CartBadgeCubit** that listens to changes.

---

## **Points for Improvement**

### **Security and Data**
- Add **Auth Guard** for protected routes.
- Encrypt and hash passwords before storing them locally.
- Improve **session persistence** (auto-login after app restart).

### **Architecture Enhancements**
- Implement **DAOs** to fully separate queries from repository logic.
- Use **type aliases** with shorter paths for imports.
- Add **Repository interfaces** to enforce contracts between layers.

### **Networking**
- Complete **Dio interceptors** for token refresh and error handling.
- Implement **network logging** for debugging requests/responses.

### **Internationalization**
- Extend **multi-language support** (currently Spanish/English) using i18next or Flutter’s localization system.
