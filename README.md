---

# Task Manager: Flutter Local Storage Implementation

This repository contains the source code for a Flutter application developed as part of the **ALA (Application Learning Assignment)**. The project demonstrates the implementation of persistent local data storage using the **SharedPreferences** package, featuring a modern Material 3 Dark Theme interface.

## Project Overview

The primary objective of this application is to showcase the full lifecycle of local data management:

* **Storage:** Saving data to the device disk in a persistent format.
* **Retrieval:** Loading stored data into the application state upon initialization.
* **Updating:** Modifying existing records and synchronizing changes with local storage.
* **Deletion:** Removing records from the local database.

## Technical Architecture

The project is built using an optimized service-oriented architecture to ensure code maintainability and separation of concerns.

### 1. Data Layer (`storage_service.dart`)

Since SharedPreferences only supports primitive types (Strings, Integers, Booleans), this project implements a **JSON Serialization** strategy.

* Data is stored as a JSON-encoded string.
* A dedicated `StorageService` class handles all asynchronous input/output operations.

### 2. Presentation Layer (`main.dart`)

* **State Management:** Utilizes `StatefulWidget` to handle real-time UI updates.
* **Theming:** Implements a professional **Dark Theme** using `ThemeData.dark()` with Material 3 design principles for a modern look and feel.
* **Performance:** Uses `ListView.builder` for memory-efficient rendering of the task list.

## Project Workflow

1. **Launch:** The application triggers `initState()` which calls the `StorageService`.
2. **Fetch:** The system checks for a JSON string under the key `application_task_data`.
3. **Parse:** If data exists, `jsonDecode` converts the string into a Dart List of Maps.
4. **Action:** When a user creates, toggles, or deletes a task, the local List is updated.
5. **Commit:** The updated List is passed through `jsonEncode` and saved back to `SharedPreferences` to ensure no data loss occurs when the app is closed.

## Installation and Setup

To run this project locally, follow these steps:

1. **Clone the repository:**
```bash
git clone [https://github.com/hetsachaniya28/third.git]

```


2. **Navigate to the project directory:**
```bash
cd [third]

```


3. **Install dependencies:**
```bash
flutter pub get

```


4. **Run the application:**
```bash
flutter run

```



## Dependencies

* `flutter`: SDK
* `shared_preferences`: For persistent key-value storage.
* `dart:convert`: For JSON serialization and deserialization.

## Submission Details

* **Assignment Type:** Individual ALA
* **Storage Method:** SharedPreferences (Key-Value)

---
