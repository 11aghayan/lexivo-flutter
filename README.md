# Lexivo

**Personal Language Dictionary & Practice App (Flutter)**

## About Lexivo

Lexivo is a mobile app that allows users to create and manage custom language dictionaries. Users can add words or grammar rules, then practice and track their learning using interactive flashcards. The app is designed to make language learning structured, flexible, and adaptive.  

## Features

- **Custom Dictionaries:** Create dictionaries for any language.  
- **Add Words & Grammar Rules:** Store translation / description, word type, past forms, level, and gender information.  
- **Practice Mode:**  
  - Select 10, 25, or 50 words for practice.  
  - Apply optional filters: word type, level, gender.  
  - Randomized flashcards for effective learning.  
  - Swipe interactions mark words as known or unknown.  
  - Unknown words have a countdown (starting at 7), which decreases as the user answers correctly. Words with higher countdowns appear first in future practice sessions.  
- **Test Mode (Coming Soon):** Evaluate knowledge with structured tests.


## Getting Started

### Prerequisites

- Flutter SDK (latest stable version recommended)  
- Android or iOS device / emulator  
- Code editor (VS Code, Android Studio, etc.)  

### Running Locally

```bash
# Clone the repository
git clone https://github.com/11aghayan/lexivo-flutter.git
cd lexivo-flutter

# Install dependencies
flutter pub get

# Run on your desired platform
flutter run          # Default device
flutter run -d chrome # For web testing
