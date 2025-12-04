# Lofit Flutter Frontend

Flutter frontend for the Lofit fitness challenge platform. This is a migration from the React frontend to Flutter.

## Features

- 🏠 **Landing Page** - Beautiful hero section with animated background
- 🔐 **Authentication** - Wallet connection and user profile setup
- 📊 **Dashboard** - Main dashboard with sidebar navigation
- 🏆 **Contests** - View and join fitness contests with API integration
- 🎨 **Cyber Theme** - Neon green cyberpunk aesthetic matching the original design

## Setup

1. Make sure Flutter is installed on your system
   ```bash
   flutter --version
   ```

2. Install dependencies
   ```bash
   cd flutter_frontend
   flutter pub get
   ```

3. Ensure the backend API is running on `http://localhost:3001`

4. Run the app
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── constants/        # App constants and configuration
├── models/          # Data models (Contest, etc.)
├── pages/           # Main screens (Landing, Auth, Dashboard, Contests)
├── services/        # API service layer
├── theme/           # App theme and colors
└── widgets/         # Reusable UI components
```

## API Integration

The app connects to the backend API at `http://localhost:3001/api`. Make sure your backend server is running before using the app.

### Endpoints Used

- `GET /api/contests` - Fetch all contests
- `GET /api/contests/:id` - Get contest details
- `GET /api/contests/:id/joined/:address` - Check if user joined

## Key Dependencies

- `http` - API requests
- `google_fonts` - Typography
- `shared_preferences` - Local storage
- `web3dart` - Web3 wallet integration (future)

## Navigation

- `/` - Landing page
- `/auth` - Authentication page
- `/dashboard` - Main dashboard with tabs

## Theme

The app uses a cyberpunk/neon theme with:
- Primary color: Cyber Green (#39FF14)
- Background: Cyber Black (#0F0F1A)
- Glassmorphism effects
- Neon button animations

## Notes

- Wallet connection is currently mocked for demo purposes
- Full Web3 integration will be added in future updates
- Some dashboard tabs are placeholder pages ready for implementation
