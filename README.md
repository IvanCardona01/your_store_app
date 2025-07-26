# Your Store App

A store application developed in Flutter.

## Architecture and Technologies

### 🏗️ VIP Architecture

This project implements the **VIP (View-Interactor-Presenter) architecture** that separates logic into three components:

- **View**: Handles the user interface and visual presentation
- **Interactor**: Contains business logic and data handling
- **Presenter**: Acts as intermediary between View and Interactor

### 🗄️ Drift for Database

We use **Drift** as ORM for local SQLite database management, providing:

- Type-safe queries
- Automatic migrations  
- Reactive streams for real-time updates

### 🎯 Bloc for State Management

We implement the **Bloc** pattern for application state management, offering:

- Clear separation between events and states
- Predictable state management
- Seamless integration with VIP architecture

### 🧭 GoRouter for Routing

We use **GoRouter** for declarative navigation handling:

- Declarative and typed routes
- Hierarchical navigation and nested routes