# 🏡 Aldawlia Real Estate App

A Flutter-based real estate mobile application that allows users to manage properties, generate QR codes, and submit service requests with Firebase integration.

---

## 📌 Features
- **Authentication** (Login, Signup, Forgot Password using Firebase Auth)
- **Home Screen** (View latest projects, company announcements)
- **QR Code Generation** (Visitor & Owner QR with sharing option)
- **Property Management** (View owned properties with details)
- **Service Requests** (Submit maintenance or service requests)
- **Firebase Integration** (Auth, Firestore, Storage)
- **State Management** using `Provider`

---

## 🛠️ Prerequisites
Before running the project, ensure you have the following:
- **Flutter SDK** installed ([Download Here](https://flutter.dev/docs/get-started/install))
- **Android Studio** / **VS Code**
- **Firebase Project** setup ([Firebase Console](https://console.firebase.google.com/))
- **Enable Firebase Auth & Firestore** in Firebase Console

---

## 🚀 Installation & Running the App
```sh
# Clone the repository
git clone https://github.com/renadhaitham/aldawlia_real_estate.git
cd aldawlia_real_estate

# Install dependencies
flutter pub get

# Run the application
flutter run
```

⚠ **Ensure you add your Firebase configuration files (`google-services.json` for Android & `GoogleService-Info.plist` for iOS).**

---

## 🔧 Technologies Used
- **Flutter** (Dart)
- **Firebase Auth** (User authentication)
- **Cloud Firestore** (Database management)
- **qr_flutter** (QR code generation)
- **Provider** (State management)
- **Google Fonts** (Custom styling)

---

## 📂 Project Structure
```
📦 aldawlia_real_estate
 ┣ 📂 lib
 ┃ ┣ 📂 screens
 ┃ ┃ ┣ 📜 login.dart
 ┃ ┃ ┣ 📜 sign_up.dart
 ┃ ┃ ┣ 📜 home.dart
 ┃ ┃ ┣ 📜 my_properties.dart
 ┃ ┃ ┣ 📜 service_requests.dart
 ┃ ┃ ┣ 📜 qr_code
 ┃ ┃ ┃ ┣ 📜 owner_qr.dart
 ┃ ┃ ┃ ┗ 📜 visitor_qr.dart
 ┃ ┣ 📂 models
 ┃ ┃ ┗ 📜 project_model.dart
 ┃ ┣ 📂 services
 ┃ ┃ ┗ 📜 firebase_service.dart
 ┃ ┣ 📂 widgets
 ┃ ┃ ┣ 📜 custom_button.dart
 ┃ ┃ ┣ 📜 custom_text_field.dart
 ┃ ┃ ┗ 📜 notification_icon.dart
 ┃ ┗ 📜 main.dart
```

---

## 📸 Screenshots *
| Login Screen | Home Screen | Services |
|-------------|------------|---------|
|![login](https://github.com/user-attachments/assets/649c3193-7ce0-4b41-b347-3f9f03fd67a3) |![homescreen](https://github.com/user-attachments/assets/a013be40-c694-4c50-aab7-2f1d57e1c2b7)|![service](https://github.com/user-attachments/assets/9387b756-b447-4de4-bfe3-3a17d28b8972)



---

## 👩‍💻 Developer Info
Developed by **Renad Haitham**.

For any inquiries, contact me at: 📧 [renadelkhuty@gmail.com]

---

