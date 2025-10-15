# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

AgriBot is an AI-powered agriculture assistant built with a Flutter frontend, Python Flask backend, MySQL database, and OpenAI GPT integration. The system helps farmers with crop management, pest control, soil health, and agricultural best practices.

## Architecture

This is a full-stack application with clear separation between frontend, backend, and database layers:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Flutter App    │◄──►│  Python Flask   │◄──►│   MySQL DB      │
│  (Frontend)     │    │   (Backend)     │    │  (Database)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   OpenAI API    │
                       │   (AI Service)  │
                       └─────────────────┘
```

### Key Components

- **Frontend**: Single Flutter app (`frontend/agri_chatbot_app/`) with Material Design 3
- **Backend**: Flask REST API (`backend/app.py`) with direct OpenAI integration
- **Database**: MySQL schema with agriculture-specific tables (users, chat_messages, crops, pests_diseases, etc.)
- **AI Integration**: Cerebras AI with Llama3.1-8b model and agricultural system prompt

## Development Commands

### Environment Setup

```bash
# Backend setup
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
# Edit .env with database credentials and Cerebras API key

# Frontend setup
cd frontend/agri_chatbot_app
flutter pub get
```

### Database Setup

```bash
# Create and initialize MySQL database
mysql -u root -p < database/schema.sql
```

### Running the Application

```bash
# Start backend server (from backend/ directory)
python app.py

# Start Flutter app (from frontend/agri_chatbot_app/ directory)
flutter run

# Production backend with Gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Testing

```bash
# Flutter tests
cd frontend/agri_chatbot_app
flutter test

# Backend API health check
curl http://localhost:5000/health
```

### Building for Production

```bash
# Flutter web build
cd frontend/agri_chatbot_app
flutter build web

# Flutter mobile builds
flutter build apk      # Android
flutter build ios      # iOS
```

## Development Patterns

### Backend API Structure

The Flask backend follows a simple route-based structure:
- `/health` - Health check endpoint
- `/api/chat` - Main chat endpoint with Cerebras AI integration
- `/api/chat/history/<user_id>` - Chat history retrieval

All chat interactions are stored in the MySQL database with user_id, message content, type (user/assistant), and timestamps.

### Frontend Architecture

The Flutter app uses a single-screen chat interface with:
- StatefulWidget for chat screen with message state management
- HTTP client for backend communication
- Simple message model with timestamp and user/assistant distinction
- Material Design 3 theming with green agriculture color scheme

### Database Schema

The MySQL schema includes specialized agriculture tables:
- `users` - Farmer profiles with farm details
- `chat_messages` - All chat interactions
- `crops` - Agricultural crop information
- `pests_diseases` - Pest and disease database
- `agriculture_topics` - Hierarchical topic categorization
- `best_practices` - Agricultural best practices database
- `weather_data` - Weather tracking
- `user_feedback` - User feedback and ratings

### Cerebras AI Integration

The system uses a specialized agricultural assistant prompt that focuses on:
- Crop management and farming techniques
- Pest and disease control
- Weather and seasonal advice
- Soil health and fertilization
- Sustainable farming practices
- Agricultural technology and tools

## Configuration

### Backend Environment Variables (.env)

Required environment variables:
- `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME` - MySQL connection
- `CEREBRAS_API_KEY` - Cerebras AI API access
- `FLASK_ENV`, `FLASK_DEBUG` - Flask configuration

### Frontend Configuration

Update `_backendUrl` in `lib/main.dart` to match your backend server URL. Default is `http://localhost:5000`.

## Key Development Notes

- The backend uses PyMySQL for direct database connections (no ORM)
- Frontend state management uses built-in setState (can be extended to Provider/Riverpod)
- Cerebras AI integration uses requests library with Llama3.1-8b model
- The system includes comprehensive agricultural knowledge base seeded in the database
- Chat history is limited to 50 messages per user in the API
- Error handling includes connection failures and API errors
- CORS is enabled for cross-origin requests

## Tech Stack Versions

- Flutter SDK: 3.9.2+
- Python: 3.8+
- MySQL: 8.0+
- Flask: 2.3.3
- Cerebras AI: REST API via requests
- Dart SDK: ^3.9.2