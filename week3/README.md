# ✅ Flutter To-Do List App with Persistent Storage

A simple and elegant **To-Do List app** built with **Flutter**, which saves all tasks locally using `SharedPreferences` and `JSON`. Tasks remain stored even after closing the app.

---

## 📱 Features

- ➕ Add tasks
- 🗑️ Delete tasks
- 💾 Tasks are saved persistently using local storage
- 📤 Data is saved in `SharedPreferences` as JSON-encoded string
- ✨ Clean and responsive UI

---

## 🔧 Technologies Used

- **Flutter** — For app development  
- **Dart** — Programming language  
- **shared_preferences** — For local persistent storage  
- **json.encode / json.decode** — For converting task lists to and from strings  

---

## 📦 Dependencies

Make sure to include the following in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.0.15
