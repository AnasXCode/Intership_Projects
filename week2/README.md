Week 2 Task 1:
# Flutter Counter App

This is a simple Flutter application that demonstrates the basic usage of StatefulWidget and state management using `setState()`.

## Features

- Increments and decrements a counter value using two buttons.
- Real-time UI update using Flutter's built-in state management.
- Clean and minimal UI with Material Design components.

-------------------------------------------------------------------------------------------------------------------------------------

Week 2 Task 2:

# Persistent Counter App

This Flutter project is a simple **counter app** that saves the counter value even after closing the app using **SharedPreferences**.

## 🔧 Features

- 🧮 Counter with **Increase** and **Decrease** buttons  
- 💾 Counter value is **saved locally** using `shared_preferences`  
- 🕒 Automatically loads saved value on app restart  
- 📱 Simple and clean user interface using `MaterialApp` and `Scaffold`

## 📂 Project Structure

- `main.dart` — Contains the complete UI and logic of the app
- `SharedPreferences` — Used to persist the counter value

  
-----------------------------------------------------------------------------------------------------------------------------------------
  Week 2 Task 3:

# 📝 Persistent To-Do List App

A simple Flutter To-Do List application that allows users to add and remove tasks — with data stored locally using **SharedPreferences** and **JSON encoding**.

## 🚀 Features

- ✅ Add and remove to-do tasks
- 💾 Persistent storage using `shared_preferences`
- 🔄 Tasks remain saved even after app is closed or restarted
- 📱 Clean and responsive UI using `Material` design

## 📂 App Structure

- `main.dart`: Contains all the logic and UI for the app
- Uses `TextField` for task input and `ListView.builder` to display tasks
- `SharedPreferences` stores tasks in `String` format via `json.encode` and `json.decode`

## 🔧 Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.0.15


