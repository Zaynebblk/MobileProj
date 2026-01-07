# Mobile Project - EDX Mobile

A comprehensive Flutter mobile application with a Node.js backend for educational management, featuring student, professor, and admin portals with real-time communication, attendance tracking, and document management.

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

## Features

### For Students
- 📚 View course materials and documents
- 📅 Check class schedules and timetables
- ✅ Track attendance and absences
- 📊 View exam results and grades
- 💬 Message professors and classmates
- 🎫 Submit support tickets
- 📄 Request academic documents

### For Professors
- 📝 Mark student attendance
- 📢 Post announcements
- 📤 Upload course materials
- 📋 Enter and manage grades
- 💬 Communicate with students
- 📅 Manage class schedules
- 👥 View enrolled students

### For Administrators
- 👥 Manage users (students, professors)
- 🏫 Manage classes and courses
- 📆 Create and edit schedules
- 🏢 Manage rooms and facilities
- 📋 Process document requests
- 🎫 Handle support tickets
- 📊 View system analytics

## Technology Stack

### Frontend
- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider pattern
- **UI Components**: Material Design

### Backend
- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB with Mongoose
- **Authentication**: JWT (JSON Web Tokens)
- **File Upload**: Multer
- **Email**: Nodemailer

## Development

### Prerequisites
- Flutter SDK (3.0 or higher)
- Node.js (16.x or higher)
- MongoDB (4.x or higher)
- Git

### Initial Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Zaynebblk/MobileProj.git
   cd MobileProj
   ```

2. Set up the backend:
   ```bash
   cd backend
   npm install
   cp .env.example .env
   # Edit .env with your configuration
   npm run seed  # Seed database with initial data
   npm run dev   # Start development server
   ```

3. Set up the frontend:
   ```bash
   cd frontend
   flutter pub get
   flutter run
   ```

For detailed instructions on setting up and running the frontend or backend, refer to their respective README files.

## Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

## License

This project is licensed under the MIT License.

## Support

For issues and questions:
- Create an issue on GitHub
- Contact the development team
- Check the documentation in respective README files
