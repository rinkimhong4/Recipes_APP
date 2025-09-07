# Recipe App

A comprehensive Flutter-based mobile application for discovering, saving, and managing recipes. This app provides users with an intuitive interface to explore culinary delights, manage their favorite recipes, and stay updated with new recipe notifications.

## Features

### 🔐 User Authentication

- **Login & Signup**: Secure user registration and authentication
- **Social Login**: Integration with Google and Facebook for quick access
- **Secure Storage**: Encrypted local storage for user credentials

### 🏠 Home & Navigation

- **Responsive Design**: Optimized layouts for medium and small screens
- **Main Navigation**: Seamless navigation between app sections
- **Splash Screen**: Engaging app launch experience

### 🍳 Recipe Management

- **Recipe Discovery**: Browse and explore a variety of recipes
- **Save Recipes**: Bookmark favorite recipes for later access
- **Recipe Filtering**: Advanced filtering options to find specific recipes
- **Recipe Models**: Structured data models for recipes and products

### 🔔 Notifications

- **New Recipe Alerts**: Get notified about new recipes
- **Notification Center**: Centralized notification management

### 👤 Profile Management

- **User Profile**: Personalized user profiles
- **Phone Number Formatting**: Proper formatting for contact information

### 🎨 User Interface & Experience

- **Animations**: Smooth animations using Animate Do library
- **Loading Effects**: Shimmer effects for better loading experiences
- **Pull-to-Refresh**: Easy content refreshing
- **Custom Fonts**: Poppins font family for modern typography
- **Image Handling**: Image picker and cached network images

### 🌐 Additional Features

- **Internationalization**: Support for multiple languages
- **Offline Storage**: Shared preferences for local data
- **Networking**: HTTP requests for data fetching
- **Theming**: Customizable app themes

## Project Structure

- **lib/**: Core application code

  - `main.dart`: Application entry point
  - `modules/auth/`: Authentication module (login, signup, social login)
  - `modules/Home/`: Main app features (home screen, notifications, profile, saved recipes)
  - `modules/item/`: Recipe item components
  - `config/`: App configuration (routes, themes, responsive design)
  - `core/`: Core services and utilities
  - `widget/`: Reusable UI components

- **android/**: Android platform-specific code
- **ios/**: iOS platform-specific code
- **linux/**, **macos/**, **windows/**, **web/**: Cross-platform support

## Dependencies

Key Flutter packages used:

- **Get**: State management and routing
- **Flutter SVG**: SVG image support
- **Cached Network Image**: Image caching
- **Flutter Secure Storage**: Secure data storage
- **HTTP**: Network requests
- **Shared Preferences**: Local data storage
- **Image Picker**: Image selection
- **Shimmer**: Loading animations
- **Animate Do**: UI animations
- **Pull to Refresh**: Content refreshing
- **Intl**: Internationalization
- **Google Fonts**: Font management

## Getting Started

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio or Xcode for platform-specific development

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/rinkimhong4/Recipes_APP.git
   cd Recipes_APP
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

> **Note:** Ensure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://pub.dev/packages/get)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
