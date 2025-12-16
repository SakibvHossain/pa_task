# Pioneer Alpha Task

A Flutter application that searches GitHub for repositories using the keyword **“Flutter”** and displays the **top 50 most starred repositories**, with offline support, sorting, and a polished UI.

---

## Features

### GitHub Repository Search
- Fetches repositories from GitHub Search API
- Query keyword: **Flutter**
- Displays **top 50 repositories sorted by stars**

### Offline Support
- Repository list is cached locally using **Hive**
- Data persists across app restarts
- App works even without an internet connection
- Repository avatars cached using `cached_network_image`

### Home Screen
- Displays repository list with:
  - Repository name
  - Owner name
  - Star count
  - Last updated date
- **Sorting options**:
  - Sort by stars
  - Sort by last updated
- Sorting preference persists across sessions
- Skeleton loading for initial fetch
- Pull-to-refresh with **Lottie animation** shown only on slow refresh

### Repository Details Screen
- Clean, modern UI with:
  - Custom back button
  - Hero animation on avatar
  - Cached owner profile image
  - Repository description
  - Star count
  - Last updated date (formatted)
- Fully responsive and scrollable

### UI / UX
- Custom **Jura font** applied globally
- Light & Dark themes
- Material 3
- Smooth navigation using **GoRouter**

---

## Architecture

The app follows **Clean Architecture** with a **feature-first folder structure**:
```md
lib/
├── app/
│   ├── app.dart
│   ├── bloc_observer.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   ├── app_router_name.dart
│   │   └── app_router_path.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── theme_cubit.dart
│   └── flavors/
│       ├── flavor_config.dart
│       ├── main_dev.dart
│       └── main_prod.dart
│
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── hive_boxes.dart
│   ├── error/
│   │   ├── failure.dart
│   │   └── exception.dart
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── network_info.dart
│   └── utils/
│       ├── date_formatter.dart
│       └── sorting_enum.dart
│
├── features/
│   └── repositories/
│       ├── data/
│       │   ├── models/
│       │   │   ├── repo_model.dart
│       │   │   └── owner_model.dart
│       │   ├── datasources/
│       │   │   ├── repo_remote_ds.dart
│       │   │   └── repo_local_ds.dart
│       │   └── repository/
│       │       └── repo_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── repo_entity.dart
│       │   ├── repository/
│       │   │   └── repo_repository.dart
│       │   └── usecases/
│       │       └── fetch_repositories.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── repo_bloc.dart
│           │   ├── repo_event.dart
│           │   └── repo_state.dart
│           ├── pages/
│           │   ├── home_page.dart
│           │   └── repo_details_page.dart
│           └── widgets/
│               ├── repo_tile.dart
│               └── sort_button.dart
│
└── main.dart
```

---

## 🚀 How to Run the App

### Clone the repository  
```bash
git clone <your-repo-url>
cd <project-folder>
```
  
### Install dependencies
```bash
flutter pub get
```
  
### Run (Development flavor)
```bash
flutter run -t lib/app/flavors/main_dev.dart
```
  
### Run (Production flavor)
```bash
flutter run -t lib/app/flavors/main_prod.dart
```

| Package              | Purpose                    |
| -------------------- | -------------------------- |
| flutter_bloc         | State management           |
| dio                  | HTTP networking            |
| go_router            | Navigation                 |
| hive                 | Local storage              |
| cached_network_image | Offline image caching      |
| skeletonizer         | Skeleton loading           |
| lottie               | Animated loading indicator |
| connectivity_plus    | Network status             |
