# CricPulse Application Architecture

## Overview
CricPulse is a Flutter-based cricket companion application that provides live scores, polls, predictions, trivia, and chat features. The application uses Supabase as its backend for authentication and is designed to eventually migrate other features to Supabase real-time database.

## Supabase Integration

### Initialization
The Supabase client is initialized in `lib/main.dart` during application startup:

```dart
await Supabase.initialize(
  url: 'https://uw-------ase.co',
  anonKey: 'eyJhbG------RtgAIOKU',
);
```

This establishes a connection to the Supabase project using the provided URL and anonymous key.

### Authentication Service
Authentication is handled through the `AuthService` class (`lib/services/auth_service.dart`), which provides:
- User registration (`signUp`)
- User login (`signIn`)
- User logout (`signOut`)
- Current user access (`currentUser`)
- Authentication state changes (`authStateChanges`)

The `AuthProvider` (`lib/providers/auth_provider.dart`) manages authentication state throughout the application using Flutter's Provider pattern.

### Current Implementation Status
While authentication is fully integrated with Supabase, other features currently use mock data:
- **Polls**: Implemented in `lib/services/poll_service.dart` with simulated real-time updates
- **Matches/Live Scores**: Managed through providers but using mock/simulated data
- **Chat**: Uses Gemini AI for responses, with message storage to be implemented
- **Trivia/Prediction**: Currently use local data sources

### Migration Path to Supabase
The codebase is prepared for migration to Supabase for other features:

1. **Poll Service Migration**: 
   - Replace mock data with Supabase table operations
   - Implement real-time subscriptions using Supabase Realtime
   - Example structure:
     ```dart

     final polls = await supabase.from('polls').select();
     

     supabase.from('polls').on(Insertion, (payload) => {

     }).subscribe();
     ```

2. **Match Data**:
   - Store match information in Supabase tables
   - Use database functions for score updates
   - Implement real-time subscriptions for live score updates

3. **Chat Messages**:
   - Store messages in a Supabase `messages` table
   - Implement real-time subscriptions for new messages
   - Add message persistence

## API Communication Pattern

### Supabase as Backend API
Supabase provides a PostgREST API that allows direct database operations through REST endpoints. The Flutter application communicates with this API through the official Supabase Dart client.

### Data Flow
1. **Client Initialization**: Supabase client created with project credentials
2. **Authentication**: JWT-based authentication via Supabase Auth
3. **Database Operations**: 
   - Queries: `supabase.from('table').select()`
   - Modifications: `supabase.from('table').insert()/update()/delete()`
   - Real-time: `supabase.from('table').on(EventType, callback)`

### Security Considerations
- Row Level Security (RLS) policies should be defined in Supabase for data protection
- Anonymous key is used for client-side operations; service role key should be used for backend operations (not currently implemented)
- User-specific data access is controlled through RLS policies tied to authenticated user IDs

## Provider Architecture
The application uses Flutter's Provider pattern for state management:
- Each feature has a corresponding Provider (e.g., `AuthProvider`, `PollProvider`)
- Providers manage state and business logic
- Services handle external API/data source communication
- UI components consume provider state

