Put smisla

<p align="center">
  <strong>A structured path to learning, reflection, and personal meaning.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white" alt="SQLite">
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=flat-square&logo=android&logoColor=white" alt="Android">
</p>

Overview

Put smisla is an educational and self-reflective mobile application inspired by the principles of logotherapy. It presents learning content through three progressive levels and combines education, quizzes, progress tracking, and a private space for personal reflections.

The application was developed in Flutter and Dart as a final project in Informatics and Information Technology. It is designed to work offline, with user accounts, progress, quiz results, and reflections stored locally on the device.

Key Features

Local user registration and login

Three structured educational levels

Learning content presented through concise lesson cards

Quizzes with randomized answer order

Best-score and level-completion tracking

Progressive unlocking of new levels

Personal reflections with create, read, update, and delete functionality

Completion certificate after finishing the learning path

Option to reset progress

Fully offline operation with local data storage

Technologies

Technology

Purpose

Flutter

Cross-platform application framework and user interface

Dart

Application logic and data handling

SQLite

Local persistence of users, quizzes, progress, and reflections

Material 3

Visual design system and reusable interface components

Project Structure

lib/
├── data/
│   └── levels_data.dart
├── db/
│   └── app_database.dart
├── models/
│   └── models.dart
├── ui/
│   ├── notes/
│   └── application screens
├── app.dart
└── main.dart

assets/
├── icons/
└── lessons/

The educational content is separated from the interface logic, while database operations are centralized in AppDatabase. This structure keeps the code easier to maintain and extend.

Running the Project

Make sure the Flutter SDK is installed and configured, then run:

git clone https://github.com/modobasic/put-smisla.git
cd put-smisla
flutter pub get
flutter run

Use flutter doctor if you need to verify the local Flutter setup.

Privacy

The application does not use an external server or cloud synchronization. User accounts, learning progress, quiz results, and personal reflections remain in the application's local SQLite database on the user's device.

Project Scope

Put smisla is an educational and self-reflective tool. It is not psychotherapy, medical treatment, or a substitute for professional mental health support.

Author

Designed and developed by Marija Odobašić.

Copyright

Copyright © 2026 Marija Odobašić. All rights reserved.

This repository does not include an open-source license. The source code and educational content may not be copied, redistributed, or used to create derivative works without prior written permission.
