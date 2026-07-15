# Criteria to PDF Generator

A Flutter application that allows users to input specific criteria and interactively generate a tailored PDF document. The generated PDF strictly adheres to the provided criteria without adding external fluff or leaving any input out.

## Features
- **Strict Content Adherence**: The PDF content is generated using exactly the criteria provided by the user.
- **Interactive Form**: Users can easily add, edit, and review multiple criteria points before generating the document.
- **Cross-Platform PDF Generation**: Uses the `pdf` and `printing` packages to generate and display the document natively on iOS, Android, Web, and Desktop.
- **Preview & Share**: The app provides a real-time preview of the generated PDF and allows sharing or printing the final output.

## Tech Stack
- **Framework**: Flutter
- **Packages**:
  - `pdf`: For creating the document structure and drawing the content.
  - `printing`: For previewing, printing, and sharing the generated PDF.

## Setup Instructions
1. Ensure you have Flutter installed (version ^3.7.2 or later).
2. Clone the repository and navigate to the project directory.
3. Run `flutter pub get` to fetch dependencies.
4. Run `flutter run` to launch the app on your preferred platform.

## Usage
1. Open the app to see the main form.
2. Enter your criteria points in the text fields. You can add as many as needed by pressing the "Add Criterion" button.
3. Once all your criteria are listed, tap the "Generate PDF" button.
4. The app will generate a clean, strictly formatted PDF containing only your inputs and present it for preview or sharing.

---

## About CouldAI
This app was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
