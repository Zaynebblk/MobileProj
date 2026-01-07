# Mobile Project - EDX Mobile

A Flutter mobile application with a Node.js backend, organized with clear separation of concerns.

## Architecture

```
edx_mobile/
├── frontend/          # Flutter mobile application
│   ├── lib/
│   ├── android/
│   ├── ios/
│   ├── web/
│   ├── windows/
│   ├── linux/
│   ├── macos/
│   ├── pubspec.yaml
│   └── README.md
│
└── backend/           # Node.js Express backend server
    ├── src/
    ├── package.json
    └── README.md
```

## Getting Started

### Frontend (Flutter)

```bash
cd frontend
flutter pub get
flutter run
```

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

See [frontend/README.md](frontend/README.md) for more details.

### Backend (Node.js)

```bash
cd backend
npm install
npm run dev
```

See [backend/README.md](backend/README.md) for more details.

## Project Structure Details

- **frontend/** - Flutter mobile application
  - Contains all Flutter-specific code, configurations, and platform-specific files
  - Includes iOS, Android, Web, Windows, Linux, and macOS implementations

- **backend/** - Node.js Express backend server
  - REST API server
  - Business logic and data management
  - Database integration (when implemented)

## Development

For detailed instructions on setting up and running the frontend or backend, refer to their respective README files.
