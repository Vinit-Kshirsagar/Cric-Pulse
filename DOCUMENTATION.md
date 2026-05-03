# CricPulse - Detailed Documentation

## Project Overview
CricPulse is a Flutter-based cricket companion application designed to enhance the cricket viewing experience with real-time scores, interactive polls, predictions, trivia, and AI-powered chat features. The application follows a modular architecture with clear separation of concerns between UI, state management, services, and data layers.

## Supabase Backend Integration

### Why Supabase?
Supabase was chosen as the backend solution because it provides:
- PostgreSQL database with real-time capabilities
- Authentication services (Auth)
- Auto-generated RESTful APIs (PostgREST)
- Edge functions for serverless logic
- File storage
- All services are accessible through a unified client SDK

### Connection Setup
The Supabase connection is established in `lib/main.dart` during the application's initialization phase:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  await Supabase.initialize(
    url: 'https://uwix------base.co',
    anonKey: 'eyJh------gAIOKU',
  );
  
}
```

This creates a global Supabase client instance that can be accessed throughout the application via `Supabase.instance.client`.

### Authentication Flow
Authentication is the primary Supabase integration currently implemented:

#### Client-Side Implementation
1. **Service Layer** (`lib/services/auth_service.dart`):
   - Wraps Supabase Auth methods
   - Provides signUp, signIn, signOut functions
   - Exposes current user and auth state streams

2. **State Management** (`lib/providers/auth_provider.dart`):
   - Listens to auth state changes from Supabase
   - Maintains user session state
   - Provides login/logout methods to UI layers

3. **Usage in UI**:
   - Providers are made available through `MultiProvider` in `main.dart`
   - Screens access authentication state via `Provider.of<AuthProvider>(context)`

#### Supabase Auth Features Used
- Email/password authentication
- User metadata storage (full_name in user.data)
- JWT-based session management
- Auth state change listeners

### Database Structure (Planned)
While currently using mock data for most features, the planned Supabase schema includes:

#### Tables
1. **profiles** - Extended user information
   - id (UUID, references auth.users)
   - full_name (text)
   - avatar_url (text)
   - created_at (timestamp)
   - xp_points (integer)
   - level (integer)

2. **matches** - Cricket match information
   - id (UUID)
   - team1, team2 (text)
   - start_time, end_time (timestamp)
   - status (text: upcoming, live, completed)
   - score1, score2 (jsonb for detailed scoring)

3. **polls** - Interactive polls
   - id (UUID)
   - match_id (UUID, references matches)
   - question (text)
   - created_at (timestamp)
   - expires_at (timestamp)

4. **poll_options** - Poll answer options
   - id (UUID)
   - poll_id (UUID, references polls)
   - option_text (text)
   - vote_count (integer, default 0)

5. **user_votes** - Track user voting
   - id (UUID)
   - user_id (UUID, references auth.users)
   - poll_option_id (UUID, references poll_options)
   - voted_at (timestamp)

6. **chat_messages** - AI and user messages
   - id (UUID)
   - user_id (UUID, references auth.users, nullable for AI)
   - message_text (text)
   - is_ai_response (boolean)
   - created_at (timestamp)

7. **predictions** - User predictions
   - id (UUID)
   - user_id (UUID, references auth.users)
   - match_id (UUID, references matches)
   - prediction_data (jsonb)
   - points_earned (integer)
   - created_at (timestamp)

### API Communication Patterns

#### Direct Supabase Client Usage
The application communicates with Supabase through the official Dart client, which provides:

1. **REST API Access** (via PostgREST):
   ```dart
   
   final response = await supabase.from('matches').select();
   
   await supabase.from('profiles').insert({
     'id': user.id,
     'full_name': user.userMetadata['full_name']
   });
   
   await supabase.from('profiles').update({'xp_points': 150}).eq('id', user.id);
   

   await supabase.from('old_predictions').delete().match({'user_id': user.id});
   ```

2. **Real-time Subscriptions**:
   ```dart

   supabase
     .from('matches')
     .on(Update, (payload) => {

     })
     .subscribe();
   

   supabase
     .from('polls')
     .on(Insert, (payload) => {

     })
     .subscribe();
   ```

3. **Authentication Integration**:
   ```dart

   final session = supabase.auth.currentSession;
   
  
   supabase.auth.onAuthStateChange.listen((event) {
     
   });
   ```

#### Service Layer Abstraction
Each feature has a corresponding service that encapsulates Supabase interactions:

```dart

class PollService {
  final SupabaseClient _supabase;
  
  PollService(this._supabase);
  
  Future<List<Poll>> getActivePolls() async {
    final response = await _supabase
      .from('polls')
      .select('*, poll_options(*)')
      .eq('expires_at', gt: DateTime.now().toIso8601String())
      .order('created_at', ascending: false);
    
    return response.map((json) => Poll.fromJson(json)).toList();
  }
  
  Stream<List<Poll>> pollUpdates() {
    return _supabase
      .from('polls')
      .stream(primaryKey: ['id'])
      .map((event) => event.map((json) => Poll.fromJson(json)).toList());
  }
}
```

## Current Implementation Status

### Fully Implemented with Supabase
1. **Authentication** - Complete implementation using Supabase Auth
   - User registration, login, logout
   - Persistent session management
   - Auth state providers

### Currently Using Mock Data (Planned for Supabase Migration)
1. **Polls** (`lib/services/poll_service.dart`)
   - Currently uses mock data with simulated real-time updates
   - Planned migration: Replace with Supabase tables and real-time subscriptions

2. **Matches/Live Scores** 
   - Currently uses mock/simulated data in providers
   - Planned migration: Store match data in Supabase with real-time updates

3. **Chat** (`lib/services/gemini_service.dart` and `lib/providers/chat_provider.dart`)
   - Currently uses Gemini AI for responses
   - Planned enhancement: Store messages in Supabase for persistence

4. **Trivia/Prediction**
   - Currently uses local JSON/assets
   - Planned migration: Store questions and user responses in Supabase

## Provider Architecture
The application uses Flutter's Provider package for state management:

### Provider Types
1. **ChangeNotifierProvider.value()** - For providers with existing instances
   ```dart
   ChangeNotifierProvider.value(value: authProvider),
   ```

2. **ChangeNotifierProvider(create: (_) => Provider())** - For lazy initialization
   ```dart
   ChangeNotifierProvider(create: (_) => RankingsProvider()),
   ```

### Provider Responsibilities
- **AuthProvider**: Manages authentication state
- **SettingsProvider**: Handles user preferences
- **LiveScoresProvider**: Manages live match scores
- **MatchesProvider**: Handles match schedules and results
- **RankingsProvider**: Manages user rankings and XP
- **PollProvider**: Handles poll data and voting
- **TriviaProvider**: Manages trivia questions and answers
- **PredictProvider**: Handles user predictions
- **ChatProvider**: Manages chat messages and AI responses

### Data Flow
UI → Provider (state changes) → Service (API calls) → Supabase → Database
Database changes → Supabase Realtime → Service → Provider → UI

## Environment Setup

### Prerequisites
- Flutter SDK (version compatible with sdk: ^3.10.4)
- Dart SDK
- Supabase account and project

### Setup Instructions
1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd cric_pulse
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Create a project at https://supabase.com
   - Obtain your project URL and anon key
   - Replace the values in `lib/main.dart` lines 20-21
   - Optionally set up environment variables for security

4. **Run the application**
   ```bash
   flutter run
   ```

### Database Setup (For Future Implementation)
When implementing the Supabase backend:
1. Enable the Auth service in Supabase dashboard
2. Create tables using the SQL schema outlined above
3. Enable Row Level Security (RLS) on all tables
4. Set up appropriate RLS policies
5. Enable Realtime for tables requiring live updates

## Security Considerations

### Current Implementation
- Uses Supabase anon key for client-side operations
- Authentication handled via Supabase Auth (JWT tokens)
- No sensitive data exposed in client-side code

### Recommended Enhancements
1. **Row Level Security (RLS)**:
   - Implement policies to restrict data access based on user ID
   - Example: Users can only update their own profile
   - Example: Users can only vote once per poll

2. **API Key Management**:
   - Consider using environment variables for sensitive keys
   - Implement backend services for operations requiring service_role key

3. **Data Validation**:
   - Implement database constraints and triggers
   - Add input validation in service layers

## Testing
The project includes basic test files:
- `test/widget_test.dart` - Widget testing
- `test_supabase.dart` - Supabase connection testing
- `test_http_signup.dart` - Authentication flow testing

To run tests:
```bash
flutter test
```

## Future Development Roadmap

### Phase 1: Supabase Migration
1. Migrate polls to Supabase with real-time updates
2. Implement match data storage and live score updates
3. Add chat message persistence
4. Implement user profiles and XP tracking

### Phase 2: Feature Enhancements
1. Implement complex prediction scoring algorithms
2. Add social features (following users, sharing predictions)
3. Implement tournament brackets and fantasy leagues
4. Add push notifications for match updates

### Phase 3: Performance & Scale
1. Implement database indexing strategies
2. Add caching layers for frequently accessed data
3. Optimize real-time subscriptions
4. Implement serverless functions for complex operations

### Phase 4: Analytics & Insights
1. Add user engagement analytics
2. Implement match prediction accuracy tracking
3. Add leaderboards and achievement systems
4. Implement personalized content recommendations

## Troubleshooting

### Common Supabase Issues
1. **Connection Failed**:
   - Verify internet connectivity
   - Check Supabase project status
   - Confirm URL and anon key are correct

2. **Authentication Errors**:
   - Verify email/password credentials
   - Check if email confirmation is required (if enabled)
   - Confirm user exists in auth.users table

3. **Permission Denied**:
   - Check RLS policies on tables
   - Verify user ID matches expected values
   - Confirm auth state is properly maintained

### Debugging Tips
1. Enable Supabase logging:
   ```dart
   Supabase.instance.client.logger.level = Level.info;
   ```

2. Check network requests in Flutter DevTools

3. Verify real-time subscription status:
   ```dart
   // Check if subscription is active
   print(subscription.isClosed);
   ```

## Conclusion
CricPulse provides a solid foundation for a cricket companion application with Supabase handling authentication. The modular architecture makes it straightforward to migrate additional features to Supabase as the backend. The current implementation demonstrates best practices for integrating Supabase with Flutter applications using the Provider pattern for state management.

For any questions or contributions, please refer to the project repository.