# Contributing to EDX Mobile

Thank you for considering contributing to EDX Mobile! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and collaborative environment.

## Getting Started

1. **Fork the repository** and clone your fork:
   ```bash
   git clone https://github.com/your-username/MobileProj.git
   cd MobileProj
   ```

2. **Create a new branch** for your feature or bugfix:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bugfix-name
   ```

3. **Set up the development environment**:
   
   For the backend:
   ```bash
   cd backend
   npm install
   cp .env.example .env
   # Edit .env with your configuration
   npm run dev
   ```
   
   For the frontend:
   ```bash
   cd frontend
   flutter pub get
   flutter run
   ```

## Development Workflow

### Branch Naming Convention

- `feature/` - New features (e.g., `feature/user-authentication`)
- `fix/` - Bug fixes (e.g., `fix/login-error`)
- `docs/` - Documentation updates (e.g., `docs/api-readme`)
- `refactor/` - Code refactoring (e.g., `refactor/user-service`)
- `test/` - Adding or updating tests (e.g., `test/auth-controller`)

### Before Submitting Changes

1. **Test your changes thoroughly**
   - Backend: Run all tests and verify API endpoints
   - Frontend: Test on multiple devices/emulators

2. **Code formatting**
   - Backend: Follow Node.js/Express best practices
   - Frontend: Use `flutter format .` before committing

3. **Documentation**
   - Update README if adding new features
   - Add inline comments for complex logic
   - Update API documentation if modifying endpoints

## Coding Standards

### Backend (Node.js)

- Use ES6+ features
- Use async/await for asynchronous operations
- Follow RESTful API conventions
- Proper error handling with try-catch blocks
- Use meaningful variable and function names
- Add JSDoc comments for functions

Example:
```javascript
/**
 * Get user by ID
 * @param {string} userId - The user ID
 * @returns {Promise<Object>} User object
 */
async function getUserById(userId) {
  try {
    const user = await User.findById(userId);
    return user;
  } catch (error) {
    throw new Error(`Error fetching user: ${error.message}`);
  }
}
```

### Frontend (Flutter/Dart)

- Follow Dart style guide
- Use proper widget naming conventions
- Implement proper state management
- Use meaningful class and variable names
- Add documentation comments

Example:
```dart
/// Widget for displaying user profile
class UserProfile extends StatelessWidget {
  final User user;
  
  const UserProfile({Key? key, required this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Widget implementation
  }
}
```

## Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semicolons, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples

```bash
git commit -m "feat(auth): add password reset functionality"
git commit -m "fix(api): resolve null pointer in user controller"
git commit -m "docs(readme): update installation instructions"
```

## Pull Request Process

1. **Update your branch** with the latest changes from main:
   ```bash
   git fetch origin
   git rebase origin/main
   ```

2. **Push your changes** to your fork:
   ```bash
   git push origin your-branch-name
   ```

3. **Create a Pull Request** on GitHub:
   - Provide a clear title and description
   - Reference any related issues
   - Include screenshots for UI changes
   - List any breaking changes

4. **PR Review Process**:
   - Address reviewer feedback
   - Keep the PR focused on a single feature/fix
   - Ensure all checks pass

5. **After Approval**:
   - Your PR will be merged by a maintainer
   - Delete your feature branch after merge

## Questions?

If you have questions or need help, feel free to:
- Open an issue on GitHub
- Contact the maintainers
- Check existing documentation

Thank you for contributing! 🎉
