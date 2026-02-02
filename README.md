# iOS Boilerplate

A modern iOS app built with **Swift** and **SwiftUI**.  
This project is structured for **scalability**, **testability**, and **modular development**.

It follows a clean architecture approach with:
- dependency injection
- environment-driven configuration
- and a ready-to-use authentication flow.

![IMAGE 2026-02-02 11:22:07](https://github.com/user-attachments/assets/31b9fa31-72ab-4520-8e26-8734b5dda0c9)

---

## ✨ Features

- SwiftUI-first UI with previews  
- Authentication flow (auto-login, routing, session state)  
- Clean architecture (Use Cases, Repositories, Services)  
- Async/await concurrency  
- Dependency injection via Environment  
- Modularized data layer (Remote + Local)  
- Preview-friendly mocks/stubs  
- Swift Testing or XCTest-ready  

---

## 🛠 Tech Stack

- **Swift 6**
- **SwiftUI**
- **Swift Concurrency** (async/await, actors)
- Combine (optional)
- Foundation / URLSession
- StoreKit (optional)
- Firebase or custom backend (optional)
- Swift Testing or XCTest

---

## 📁 Project Structure

```text
App/
  AppRoot.swift                 // Entry point, auth routing, loading state
  WelcomeRootView.swift         // Unauthenticated flow
  DiscoveryRootView.swift       // Authenticated flow (main app)

Domain/
  Entities/                     // Core models
  UseCases/                     // Business logic (e.g., AuthUseCase)
  Protocols/                    // Abstractions for repositories/services

Data/
  Repositories/                 // Repository implementations (e.g., FirebaseAuthRepository)
  Remote/                       // Network services (e.g., AuthRemoteService)
  Local/                        // Local persistence (e.g., UserLocalStore)
  Mappers/                      // DTO <-> Model conversions

Presentation/
  Features/
    Auth/                       // Auth screens, view models
    Discovery/                  // Main feature screens, view models
  Components/                   // Reusable views
  ViewModels/                   // Shared view models (e.g., AuthViewModel)

Resources/
  Assets.xcassets
  Config/                       // Environment configs, plist

Tests/
  Unit/
  UI/
```

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/leroyanders/ios-boilerplate.git
   ```

2. Open the project in Xcode:
   ```bash
   open BoilerplateApp.xcodeproj
   ```

3. Run the app on a simulator or device.

---

## 🧩 Architecture

The project follows a layered architecture:

- **Presentation** — SwiftUI views and ViewModels  
- **Domain** — business logic and entities  
- **Data** — repositories, network, and local storage  

Each layer depends only on the layer below it.

---

## 🧪 Testing

- Unit tests for UseCases and ViewModels  
- UI tests for main flows  
- Supports **Swift Testing** or **XCTest**

---

## 📜 License

This project is licensed under the MIT License — see the LICENSE file for details.
