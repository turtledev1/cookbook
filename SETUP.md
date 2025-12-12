# Cookbook - Setup Guide

This project is configured with:
- **Injectable** for dependency injection
- **Bloc** for state management  
- **JSON Serialization** for model serialization

## Quick Start

### 1. Dependencies
All dependencies are already installed in `pubspec.yaml`:
- `injectable` & `get_it` - Dependency injection
- `flutter_bloc` - State management
- `json_annotation` - JSON serialization annotations
- `build_runner`, `injectable_generator`, `json_serializable` - Code generation (dev dependencies)

### 2. Dependency Injection

Injectable is configured in [lib/injection.dart](lib/injection.dart). The DI container is initialized in [lib/main.dart](lib/main.dart#L5).

To inject a class:
```dart
@injectable
class MyService {
  // Your service code
}
```

To use it:
```dart
final myService = getIt<MyService>();
```

### 3. Bloc Pattern

Example implementation in [lib/blocs/user_bloc.dart](lib/blocs/user_bloc.dart):

```dart
@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;
  
  UserBloc(this._repository) : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }
}
```

Use in widgets:
```dart
BlocProvider(
  create: (context) => getIt<UserBloc>(),
  child: YourWidget(),
)
```

### 4. JSON Serialization

Example model in [lib/models/user.dart](lib/models/user.dart):

```dart
@JsonSerializable()
class User {
  final String id;
  final String name;
  
  User({required this.id, required this.name});
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 5. Code Generation

Run this command after adding new `@injectable`, `@JsonSerializable` annotations:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous watching during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Project Structure

```
lib/
├── injection.dart          # DI configuration
├── injection.config.dart   # Generated DI code
├── main.dart              # App entry point
├── blocs/                 # Bloc state management
├── models/                # Data models with JSON serialization
└── repositories/          # Data repositories
```

## Examples

- **Repository**: [lib/repositories/user_repository.dart](lib/repositories/user_repository.dart)
- **Bloc**: [lib/blocs/user_bloc.dart](lib/blocs/user_bloc.dart)
- **Model**: [lib/models/user.dart](lib/models/user.dart)
