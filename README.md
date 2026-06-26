# AEM Enersol Mobile App

A Flutter mobile application built as a technical assessment for AEM Enersol. The app authenticates users via a live REST API and presents an energy analytics dashboard with bar chart statistics, donut chart distribution and an employee directory

---

## Features

- **JWT Authentication** — login flow against `http://test-demo.aemenersol.com/api` with token persistence across sessions
- **Dashboard** — bar chart (statistics) and donut chart (distribution) populated from API data
- **Employee Directory** — a searchable list of employees from the same dashboard endpoint
- **Dark Mode** — full system-wide dark theme that occurs after enabling the dark mode toggle
- **Swipeable Navigation** — PageView-based tab switching with natural swipe gestures
- **Error Handling** — explicit error states with retry actions on every data-loading screen
- **Loading States** — spinner feedback while data is in flight
- **UI Animations** — login fade-in, staggered chart card slide-up, smooth tab transitions
- **iOS-Style Toggles** — CupertinoSwitch for notifications and dark mode in Settings
- **Localization** — full i18n setup via Flutter's built-in ARB/intl pipeline

---

## Setup Instructions

### Prerequisites

| Tool | Minimum Version |
|------|----------------|
| Flutter SDK | 3.8.1 |
| Dart SDK | 3.8.1 (bundled with Flutter) |
| Xcode (iOS) | 15+ |
| Android Studio / SDK | API 21+ |

To Verify your environment:

in CLI;

fvm flutter doctor


### Installation


# 1. Clone the repository
git clone <repository-url>
cd aem_mobile

# 2. Install dependencies
fvm flutter pub get

# 3. Generate localisation files (required before first build)
fvm flutter gen-l10n


### Running the App:

# iOS Simulator
fvm flutter run -d ios

# Android Emulator
fvm flutter run -d android


### Test Credentials

To login in the login page you must use the following test credentials below:

| Email | Password |
|------|----------------|
| user@aemenersol.com | Test@123 |


## Architecture

### Pattern: Provider + ChangeNotifier

The app follows a layered architecture using the Provider package for state management. Each layer has a single responsibility:

```
Presentation  (views/)
      ↕
Controllers   (controllers/)       ← changeNotifier, business logic, error state
      ↕
Services      (services/)          ← Dio HTTP client, secure storage
      ↕
Models        (model/)             ← Plain Dart data classes
```

### Folder Structure

```
lib/
├── app.dart                        # MaterialApp root, theme wiring
├── main.dart                       # Entry point, Provider tree setup
│
├── config/
│   ├── color.dart                  # App colour palette constants
│   ├── constants.dart              # Shared constants (storage keys, etc.)
│   ├── theme.dart                  # lightTheme() and darkTheme() definitions
│   ├── route_generator.dart        # Named route configuration
│   └── extensions/
│       └── build_context_ext.dart  # l10n + size helpers on BuildContext
│
├── controllers/
│   ├── auth_controller.dart        # Login, logout, token extraction
│   ├── dashboard_controller.dart   # Dashboard API call, data state
│   └── settings_controller.dart   # Dark mode, notifications, persistence
│
├── services/
│   ├── api_service.dart            # Dio instance, Bearer token interceptor
│   └── storage_service.dart        # wrappedwith flutter_secure_storage 
│
├── model/
│   ├── dashboard_response.dart     # highlevel API response shape
│   ├── chart_bar_model.dart        # Bar chart data point
│   ├── chart_donut_model.dart      # Donut chart segment
│   └── table_user_model.dart       # employee list row
│
├── l10n/
│   ├── app_localizations.dart      # generated; do not edit manually
│   └── app_localizations_en.dart   # English strings
│
└── views/
    ├── auth/
    │   └── login.dart              # login screen with fade-in animation
    ├── home/
    │   └── home.dart               # dashboard — Stack layout, animated cards
    ├── info/
    │   └── info.dart               # employee directory with search
    ├── settings/
    │   └── settings.dart           # profile header , CupertinoSwitches
    ├── main_pages/
    │   └── bottom_navigation.dart  # PageView-based swipeable tabs
    └── widgets/
        ├── screen_headers.dart     # Reusable purple rounded-bottom headers
        ├── chart_card.dart         # card wrapper for chart widgets
        ├── charts/
        │   ├── bar_chart_widget.dart
        │   └── donut_chart_widget.dart
        ├── employee_tile.dart
        ├── settings_tile.dart
        ├── app_button.dart
        ├── app_dialog.dart
        └── app_input_field.dart
```






