# Firebase Authentication with BLoC in Flutter

A Flutter application demostrating Firebase authentication using the BLoC architecture. This project shows the implementation of sign-up, sign-in and sign-out functionalities, along with password validation.

## Features

- **User Authentication**: Sign up, Sign in and Sign out with Firebase.
- **Password Validation**: Enforces strong passwords with minimum criteria.
- **State Management**: Implemented with BLoC for clean and scalable code.

## Getting Started

### Prerequisites

- **Flutter SDK**
- **Firebase account**
- **An IDE such as Visual Studio Code or Android Studio**

### Setting Up Firebase

1. **Create a Firebase Project**:
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Click on "Add project" and follow the prompts to create a new project.

2. **Add an App to Your Project**:
   - In your Firebase project dashboard, click on the Flutter icon.
   - Register your app by providing a nickname.
   - Click on "Register app".
   - Go to the [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?continue=https%3A%2F%2Ffirebase.google.com%2Flearn%2Fpathways%2Ffirebase-flutter%23article-https%3A%2F%2Ffirebase.google.com%2Fdocs%2Fflutter%2Fsetup&platform=android) for further help.

3. **Add Firebase SDK**:
   - After registering your app, Firebase will provide you with a configuration snippet. It looks something like this:

     ```javascript
     // Your web app's Firebase configuration
     const firebaseConfig = {
       apiKey: "YOUR_API_KEY",
       authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
       projectId: "YOUR_PROJECT_ID",
       storageBucket: "YOUR_PROJECT_ID.appspot.com",
       messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
       appId: "YOUR_APP_ID",
       measurementId: "YOUR_MEASUREMENT_ID"
     };

     // Initialize Firebase
     firebase.initializeApp(firebaseConfig);
     ```

4. **Add Firebase to Your Flutter Project**:
   - Open your Flutter project and locate the `pubspec.yaml` file.
   - Make sure you have the necessary dependencies for Firebase:

     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       firebase_core: latest_version
       firebase_auth: latest_version
       # Add any other Firebase services you need
     ```

   - Run `flutter pub get` to install the dependencies.

5. **Initialize Firebase in Your App**:
   - In your `main.dart`, initialize Firebase before running the app:

     ```dart
     import 'package:flutter/material.dart';
     import 'package:firebase_core/firebase_core.dart';

     void main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await Firebase.initializeApp();
       runApp(MyApp());
     }

     class MyApp extends StatelessWidget {
       @override
       Widget build(BuildContext context) {
         return MaterialApp(
           title: 'Flutter Firebase App',
           home: YourHomeScreen(),
         );
       }
     }
     ```

### Running the App

1. Clone the repository or download the ZIP file.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Run the app using `flutter run`.
