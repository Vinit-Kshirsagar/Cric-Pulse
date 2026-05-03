# CricPulse

A Flutter-based cricket companion application that enhances the cricket viewing experience with live scores, interactive polls, predictions, trivia, and AI-powered chat features.

## Features

- **Live Scores**: Real-time cricket match updates
- **Interactive Polls**: Engage with match-related polls and see live voting results
- **Predictions**: Make predictions on match outcomes and earn points
- **Trivia**: Test your cricket knowledge with quizzes
- **AI Chat**: Get instant cricket insights from our AI-powered chatbot (Gemini integration)
- **Leaderboards**: Compete with friends and global users
- **Authentication**: Secure user login and registration (Supabase-powered)
- **Personalized Experience**: Track your progress, XP, and achievements

## How It Works

### Backend
CricPulse uses Supabase as its backend for:
- **Authentication**: Secure user registration, login, and session management
- **Future Database**: Planned migration of polls, matches, chat, and user data to Supabase for real-time synchronization

### Frontend
Built with Flutter for cross-platform compatibility (mobile, web, desktop).

### Architecture
- **State Management**: Provider pattern for efficient state updates
- **Navigation**: go_router for declarative routing
- **Services Layer**: Abstracts external APIs (Supabase, Gemini AI) from UI logic
- **Modular Design**: Separation of concerns between UI, business logic, and data layers

### Current Implementation
- ✅ **Authentication**: Fully integrated with Supabase
- ⚠️ **Other Features**: Currently using mock data with planned migration to Supabase:
  - Polls: Simulated real-time updates (to be replaced with Supabase Realtime)
  - Matches/Live Scores: Mock data (to be migrated to Supabase tables)
  - Chat: Gemini AI responses (to be enhanced with Supabase message persistence)
  - Trivia/Prediction: Local data (to be migrated to Supabase)

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.4)
- Dart SDK
- A Supabase account (for authentication)

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/cric_pulse.git
   cd cric_pulse
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Supabase:
   - Create a project at [Supabase](https://supabase.com)
   - Obtain your project URL and anon key
   - Update the values in `lib/main.dart` (lines 20-21):
     ```dart
     await Supabase.initialize(
       url: 'YOUR_SUPABASE_URL',
       anonKey: 'YOUR_SUPABASE_ANON_KEY',
     );
     ```

4. Run the application:
   ```bash
   flutter run
   ```

### For Web
```bash
flutter run -d chrome
```

### For Desktop (macOS example)
```bash
flutter run -d macos
```

## Project Structure
```
lib/
├── main.dart              # App entry point
├── app.dart               # Main application widget
├── services/              # External API/services
│   ├── auth_service.dart  # Supabase authentication
│   ├── poll_service.dart  # Poll logic (currently mock)
│   ├── gemini_service.dart # AI chat service
│   └── ...                # Other services
├── providers/             # State management (Provider pattern)
│   ├── auth_provider.dart # Authentication state
│   ├── poll_provider.dart # Poll state
│   └── ...                # Other providers
├── screens/               # UI screens
│   ├── home/              # Home screen
│   ├── polls/             # Polls screen
│   ├── chat/              # Chat screen
│   └── ...                # Other screens
├── widgets/               # Reusable UI components
│   ├── chat_bubble.dart   # Chat message bubble
│   ├── poll_card.dart     # Poll display card
│   └── ...                # Other widgets
└── theme/                 # App theming
    └── app_theme.dart     # Theme definition
```

## Contributing
We welcome contributions! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- [Supabase](https://supabase.com) for the backend infrastructure
- [Flutter](https://flutter.dev) for the UI toolkit
- [Google Gemini AI](https://ai.google.dev/) for powering the chat feature
- [Provider](https://pub.dev/packages/provider) for state management
- [go_router](https://pub.dev/packages/go_router) for routing

## Contact
For questions or feedback, please open an issue in the repository.

Enjoy using CricPulse to enhance your cricket experience!