# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal Cookbook is a Flutter recipe management app with Cloud Firestore sync. Users can create, edit, and import recipes (from HelloFresh), with real-time synchronization across devices. The app has dev/prod environment separation using Firestore collection prefixes.

## Essential Commands

### Code Generation
After modifying models or adding new injectable classes:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running the App
Development (uses `dev_shared_recipes` collection):
```bash
flutter run --dart-define-from-file=config/config.dev.json
# Or simply: flutter run (defaults to dev)
```

Production (uses `shared_recipes` collection):
```bash
flutter run --dart-define-from-file=config/config.prod.json --release
```

### Code Analysis
```bash
flutter analyze
```

### Clean Build
When encountering build issues:
```bash
flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

## Architecture

### Layer Structure
The app follows **Clean Architecture** with three main layers:

```
lib/
├── domain/          # Business logic layer
│   ├── models/      # Domain entities (Recipe, NutritionalInfo, etc.)
│   └── repositories/# Repository interfaces
├── data/            # Data layer
│   ├── data_sources/# Firestore and parsers
│   └── services/    # Data services
└── presentation/    # UI layer
    ├── blocs/       # State management (BLoC pattern)
    ├── screens/     # Full screen widgets
    ├── widgets/     # Reusable components (organized by feature)
    └── themes/      # App theming
```

### Key Architectural Patterns

#### State Management: BLoC Pattern
- **Cubits** in `presentation/blocs/` manage screen state
- **RecipeCubit**: Main cubit for recipe CRUD operations, search, and filtering
- **ImportRecipeCubit**: Handles HelloFresh recipe parsing and import flow
- Cubits emit states (`RecipeLoaded`, `RecipeLoading`, `RecipeError`) consumed by screens

#### Dependency Injection: Injectable + GetIt
- **`injection.dart`**: Service locator setup with `@injectable` annotation
- Run build_runner after adding new `@injectable` classes
- Services are registered in `injection.config.dart` (auto-generated)
- Access dependencies via `getIt<Type>()`

#### Repository Pattern
- **`RecipeRepository`**: Abstracts data access from business logic
- **`RecipeDataSource`**: Abstract interface for data operations
- **`RecipeFirestoreDataSource`**: Firestore implementation
- All Firestore operations go through this layer

#### Navigation: go_router
- Routes defined in `router.dart` with named routes in `router_names.dart`
- Uses `context.pushNamed()` and `context.pop()` for navigation
- Recipe data passed via `extra` parameter in route state

### Widget Organization

Widgets are organized by feature/screen in `lib/presentation/widgets/`:

- **`recipe_list/`**: List screen components (cards, search bar, filters, empty state)
- **`recipe_detail/`**: Detail screen sections (ingredients, steps, nutrition, allergens)
- **`import/`**: Import flow components (recipe preview card)

When adding new widgets, place them in the appropriate feature folder.

### Recipe Import Architecture

HelloFresh recipe parsing uses a **composition of specialized parsers**:

- **`HelloFreshParser`**: Orchestrator that fetches HTML and delegates to field parsers
- **Field parsers** (`hellofresh_*_parser.dart`): Each extracts specific data (name, ingredients, steps, etc.)
- Located in `lib/data/data_sources/parsers/hellofresh/`
- To add a new recipe source, create a similar parser structure and register in `ImportRecipeCubit`

## Environment Configuration

### Config Files
- **`config/config.dev.json`**: Dev environment (uses `dev_shared_recipes` collection)
- **`config/config.prod.json`**: Prod environment (uses `shared_recipes` collection)
- Files are gitignored; each developer maintains their own copies

### AppConfig
`lib/app_config.dart` reads environment variables from `--dart-define-from-file`:
- `ENVIRONMENT`: "dev" or "prod"
- `FIREBASE_COLLECTION_PREFIX`: "dev_" or ""
- Default: dev environment if no config provided

## Firebase/Firestore

### Collection Structure
- Collection name: `${prefix}shared_recipes` (e.g., "dev_shared_recipes")
- **Shared mode**: All users see the same recipes (no authentication required)
- Documents use recipe ID as document ID
- Real-time listeners in `RecipeFirestoreDataSource` sync changes

### Setup Requirements
- `google-services.json` in `android/app/` (not committed)
- `GoogleService-Info.plist` in `ios/Runner/` (not committed)
- Download from Firebase Console for the cookbook project

## Data Models

### Recipe Model
Key fields:
- `id`, `name`, `ingredients` (List<String>), `steps` (List<String>)
- `prepTimeMinutes`, `cookTimeMinutes`, `difficulty` (enum)
- `tags`, `allergens` (optional List<String>)
- `nutritionalInfo` (nested model), `imageUrl`
- `createdAt`, `updatedAt` (DateTime)

Models use:
- `json_serializable` for Firestore serialization
- `copyWith()` for immutability
- Enums for difficulty levels

## Theming

Theme colors defined in `lib/presentation/themes/app_theme.dart`:
- **green1**: Light green (`Color.fromRGBO(179, 232, 180, 1)`)
- **green2**: Medium green (`Color.fromRGBO(108, 185, 110, 1)`)
- **green3**: Dark green (`Color.fromRGBO(31, 137, 39, 1)`)

Both light and dark themes defined. App uses `ThemeMode.light` by default.

## Form Implementation

`RecipeFormScreen` is the unified form for create/edit operations:
- Differentiates mode via `initialRecipe` parameter (null = create, non-null = edit)
- Uses `ExpansionTile` for collapsible sections (Basic Info, Ingredients, Steps, Tags, Allergens, Nutrition)
- Local state management with `TextEditingController` and `GlobalKey<FormState>`
- Dynamic lists for ingredients/steps with add/remove functionality
- Chip-based input for tags/allergens via dialogs

## Common Development Tasks

### Adding a New Recipe Source
1. Create parser in `lib/data/data_sources/parsers/<source>/`
2. Implement field extraction methods similar to HelloFresh parsers
3. Register parser in `ImportRecipeCubit`
4. Update import screen UI if needed

### Adding a New Screen
1. Create screen in `lib/presentation/screens/`
2. Create cubit in `lib/presentation/blocs/` if state management needed
3. Create widgets in `lib/presentation/widgets/<feature>/`
4. Add route in `router.dart` and route name in `router_names.dart`
5. Register cubit with `@injectable` annotation and run build_runner

### Modifying Recipe Model
1. Update `lib/domain/models/recipe.dart`
2. Run build_runner to regenerate JSON serialization
3. Update Firestore data source if field mapping changes
4. Update form screen if new fields need UI inputs
5. Consider migration strategy for existing Firestore data

### Working with Recipe Detail Sections
Recipe detail screen uses extracted widgets for each section (ingredients, steps, nutrition, etc.). These are stateful widgets with local checkbox tracking for cooking mode. When modifying:
- Section widgets are in `lib/presentation/widgets/recipe_detail/`
- Each section auto-hides if data is empty
- Ingredients and steps use checkboxes with strikethrough for completed items
