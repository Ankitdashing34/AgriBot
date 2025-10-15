# 🌱 AgriBot - AI Agriculture Assistant

An intelligent chatbot designed specifically for agriculture purposes, helping farmers and agricultural professionals with farming advice, crop management, pest control, and agricultural best practices.

## 🏗️ Architecture Overview

This project follows a modern full-stack architecture:

- **Frontend**: Flutter (Mobile/Web) - Cross-platform user interface
- **Backend**: Python Flask - RESTful API server with AI integration
- **Database**: MySQL - Structured data storage for users, chats, and agricultural data
- **AI**: OpenAI GPT integration for intelligent agricultural assistance

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│                 │    │                 │    │                 │
│  Flutter App    │◄──►│  Python Flask   │◄──►│   MySQL DB      │
│  (Frontend)     │    │   (Backend)     │    │  (Database)     │
│                 │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │                 │
                       │   OpenAI API    │
                       │   (AI Service)  │
                       │                 │
                       └─────────────────┘
```

## 🚀 Features

### 🤖 AI-Powered Chat Assistant
- Intelligent responses to agriculture-related queries
- Specialized knowledge in farming, crops, pests, and soil management
- Context-aware conversations with chat history

### 📱 Cross-Platform Mobile App
- Native performance on iOS and Android
- Clean, intuitive user interface
- Real-time chat functionality
- Offline capability (planned)

### 🌾 Agriculture-Specific Features
- Crop management advice
- Pest and disease identification
- Soil health recommendations
- Weather-based farming tips
- Sustainable farming practices
- Equipment and technology guidance

### 📊 Data Management
- User profile and farming information
- Comprehensive chat history storage
- Agricultural knowledge database
- User feedback and analytics

## 🛠️ Technology Stack

### Frontend (Flutter)
- **Framework**: Flutter 3.9+
- **Language**: Dart
- **HTTP Client**: http package
- **State Management**: Built-in setState (expandable to Provider/Riverpod)
- **UI Components**: Material Design 3

### Backend (Python)
- **Framework**: Flask 2.3+
- **AI Integration**: OpenAI GPT-3.5/4
- **Database ORM**: SQLAlchemy (optional)
- **HTTP Client**: PyMySQL for database connections
- **Environment Management**: python-dotenv
- **CORS Support**: flask-cors

### Database (MySQL)
- **Version**: MySQL 8.0+
- **Character Set**: UTF8MB4
- **Features**: Full-text search, indexes for performance
- **Tables**: Users, Messages, Crops, Pests, Weather data

### AI & External Services
- **AI Provider**: OpenAI GPT API
- **Authentication**: JWT tokens (expandable)
- **Deployment**: Gunicorn-ready for production

## 📦 Project Structure

```
agri-chatbot/
├── backend/                    # Python Flask backend
│   ├── app.py                 # Main Flask application
│   ├── requirements.txt       # Python dependencies
│   └── .env.example          # Environment variables template
├── frontend/                  # Flutter frontend
│   └── agri_chatbot_app/     # Flutter project
│       ├── lib/
│       │   └── main.dart     # Main Flutter application
│       └── pubspec.yaml      # Flutter dependencies
├── database/                  # MySQL database files
│   ├── schema.sql            # Database schema and initial data
│   └── README.md             # Database setup instructions
├── docs/                      # Documentation
└── README.md                 # This file
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.9.2 or higher
- **Python**: 3.8 or higher
- **MySQL**: 8.0 or higher
- **OpenAI API Key**: For AI functionality

### 1. Clone the Repository

```bash
git clone <repository-url>
cd agri-chatbot
```

### 2. Database Setup

```bash
# Create MySQL database
mysql -u root -p < database/schema.sql
```

### 3. Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment variables
cp .env.example .env
# Edit .env with your database credentials and OpenAI API key

# Run the backend server
python app.py
```

### 4. Frontend Setup

```bash
cd frontend/agri_chatbot_app

# Get Flutter dependencies
flutter pub get

# Run the Flutter app
flutter run
```

## ⚙️ Configuration

### Backend Configuration (.env)

```env
# Database Configuration
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=agri_chatbot

# OpenAI API Configuration
OPENAI_API_KEY=your_openai_api_key_here

# Flask Configuration
FLASK_ENV=development
FLASK_DEBUG=True
```

### Frontend Configuration

Update the `_backendUrl` in `main.dart` to point to your backend server:

```dart
final String _backendUrl = 'http://localhost:5000';
```

## 📚 API Endpoints

### Chat Endpoints

- **POST** `/api/chat` - Send message to AI assistant
- **GET** `/api/chat/history/<user_id>` - Get chat history for user

### Health Check

- **GET** `/health` - Backend health check

### Request/Response Examples

#### Send Chat Message

```http
POST /api/chat
Content-Type: application/json

{
  "message": "How do I control aphids on my tomato plants?",
  "user_id": "user123"
}
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "response": "To control aphids on tomato plants, you can use several methods...",
  "timestamp": "2023-10-11T15:30:00Z"
}
```

## 🌱 Agricultural Knowledge Base

The system includes comprehensive information about:

### Crops
- Rice, Wheat, Corn, Tomato, Potato, Cotton, Sugarcane
- Growing seasons, water requirements, soil preferences
- Harvest times and yield expectations

### Pests & Diseases
- Common agricultural pests (Aphids, Stem Borers, Cutworms)
- Plant diseases (Late Blight, Powdery Mildew)
- Symptoms, prevention, and treatment methods

### Best Practices
- Crop rotation strategies
- Irrigation management
- Sustainable farming techniques
- Integrated Pest Management (IPM)

## 🧪 Testing

### Backend Testing

```bash
cd backend
python -m pytest tests/  # When test files are created
```

### Frontend Testing

```bash
cd frontend/agri_chatbot_app
flutter test
```

## 🚀 Deployment

### Backend Deployment

The Flask application is production-ready with Gunicorn:

```bash
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Frontend Deployment

```bash
# Build for web
flutter build web

# Build for Android
flutter build apk

# Build for iOS
flutter build ios
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Future Enhancements

- [ ] Image recognition for plant/pest identification
- [ ] Weather API integration
- [ ] Offline mode support
- [ ] Multi-language support
- [ ] Voice input/output capabilities
- [ ] Push notifications for farming alerts
- [ ] Social features (farmer community)
- [ ] Advanced analytics dashboard

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- OpenAI for providing the GPT API
- Flutter team for the amazing cross-platform framework
- Agricultural experts and farmers for domain knowledge
- Open source community for inspiration and tools

## 📞 Support

For support and questions:
- Create an issue in this repository
- Contact: [your-email@example.com]
- Documentation: Check the `/docs` folder for detailed guides

---

**Happy Farming! 🚜🌾**