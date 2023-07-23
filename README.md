# Auberge - IET Hostel Management App

🏨📱 Auberge - IET Hostel Management App 🚀

- Welcome to Auberge, the cutting-edge hostel management app designed with 💖 for hostel residents and administrators alike! Powered by the latest technologies like Flutter, Firebase, and Google Sheets API, Auberge offers a seamless and efficient platform for managing all aspects of hostel life.

- 📢 Stay informed! With Auberge, residents receive important announcements from administrators right at their fingertips. No more missing out on crucial updates!

- 🛠️ Report maintenance issues made easy! Residents can effortlessly submit maintenance complaints through the app, ensuring a swift resolution to any problems.

- 🍽️ Hungry? Check out the daily mess menu! Auberge provides daily updates on the mess menu, making it a breeze for residents to plan their meals. 🍕🍔🍲

- 😋 Share your thoughts on food quality! With Auberge, residents can provide valuable feedback by rating the food they eat. Let's make the mess even better together! 👍👎

- 🌟 Elegant and user-friendly! Auberge boasts a sleek interface that guarantees a delightful user experience. Smooth sailing through every feature! ⛵

- 🌟 Join the Auberge community! As an open-source app, we warmly welcome contributions from passionate developers like you! 🤝 Together, we can make Auberge even more extraordinary! 🚀

With Auberge, hostel management has never been more efficient and enjoyable. Join us in this exciting journey of innovation and excellence!

<div align="center">
 <img src="https://github.com/Photon3009/Auberge/assets/100941430/a20053ef-53d5-4433-95bd-bfbe013e0f99" alt="Logo" width="250" height = "250" />
</div>

## Table of Contents

- [Features](#features)
- [UI Preview](#ui-preview)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Setup](#firebase-setup)
  - [Google Sheets API Setup](#google-sheets-api-setup)
- [Contributing](#contributing)
  - [Fork the Repository](#fork-the-repository)
  - [Create a New Branch](#create-a-new-branch)
  - [Make Changes](#make-changes)
  - [Commit and Push](#commit-and-push)
  - [Submit a Pull Request](#submit-a-pull-request)
- [Pre-Release Version](#pre-release-version)
- [Testing Credentials](#testing-credentials)
- [License](#license)
- [Contact](#contact)

## Features

- **Announcements and Notifications** 🔔: Administrators can effortlessly send important announcements to all residents through the app in real-time. Stay informed about events, notices, and updates!

- **Complaint Management** 🛠️: Lodge maintenance complaints with ease through a user-friendly interface. We ensure prompt attention to problems, leading to a smoother living environment.

- **Mess Menu Updates** 🍽️: Access daily updated mess menus through the app to plan your meals accordingly and improve your mealtime experiences.

- **Food Rating System** 🌟: Provide feedback on the quality of daily mess food through our rating system. Foster transparency and encourage continuous improvement in food services.

- **User-Friendly UI** 🎨📱: Auberge boasts a beautiful and intuitive user interface, ensuring a pleasant experience for all users. The clean design enhances navigation and usability.

- **Future Feature Expansion** 🚀🔮: As an open-source project, we welcome contributions from developers like you! Expect exciting new features in the future, ensuring the app remains relevant and constantly evolving to meet users' needs.
## UI Preview

| Splash Screen | Onboarding Screen | Login/SignUp Screen |
| ------------- | ------------- |------------- |
|      <img src="https://github.com/Photon3009/Auberge/assets/100941430/736e0f73-51bc-45c6-99af-4d2b4309d9b1" alt="animated " height = "500" width= "230" /> |  <img src = "https://github.com/Photon3009/Auberge/assets/100941430/7ba7eca4-c13c-4270-a1a5-b58e82b6b4a2" alt = "animated"  height = "500" width= "230"/> |<img src = "https://github.com/Photon3009/Auberge/assets/100941430/33359c4f-03c4-40a5-bb4e-a151581b33e4" alt = "animated"  height = "500" width= "230"/> |

### UserSection

| Announcements Screen | User Complaint Screen | Mess Screen |User Profile Screen |
| ------------- | ------------- |------------- |------------- |
| <img src="https://github.com/Photon3009/Auberge/assets/100941430/dc8d0899-0047-473d-b18a-c15a1e174873" alt="animated " height = "500" width= "230" /> |  <img src = "https://github.com/Photon3009/Auberge/assets/100941430/3e74427f-dd9e-4710-9c38-7f97c1117743" alt = "animated"  height = "500" width= "230"/> |<img src = "https://github.com/Photon3009/Auberge/assets/100941430/4c010c69-7045-4363-9000-df1e78a7913d" alt = "animated"  height = "500" width= "230"/> |<img src = "https://github.com/Photon3009/Auberge/assets/100941430/10d6a862-9924-4b16-9093-289d3a229c94" alt = "animated"  height = "500" width= "230"/> |

### Admin Section
| Mess Menu Change Screen | Admin Complaint Screen | Mess Screen |Create Announcement Screen |
| ------------- | ------------- |------------- |------------- |
|      <img src="https://github.com/Photon3009/Auberge/assets/100941430/df9edaf3-d6cd-4a6b-a4cf-4db682263677" alt="animated " height = "500" width= "230" /> |  <img src = "https://github.com/Photon3009/Auberge/assets/100941430/1d140c54-c36c-4228-918c-eb4ad94a9d1e" alt = "animated"  height = "500" width= "230"/> |<img src = "https://github.com/Photon3009/Auberge/assets/100941430/ace315a9-6b55-4676-90d5-3d0af560376a" alt = "animated"  height = "500" width= "230"/> |<img src = "https://github.com/Photon3009/Auberge/assets/100941430/a83c71e9-b1e2-4683-962d-55e3b3a50f4b" alt = "animated"  height = "500" width= "230"/> |

## Getting Started

To run this app on your local machine, follow these steps:

### Prerequisites

- Flutter SDK: Make sure you have Flutter installed on your machine. You can download it from the [official Flutter website](https://flutter.dev/docs/get-started/install).

### Installation

1. Clone the repository:
   
```
   git clone https://github.com/Photon3009/Auberge.git
```


3. Navigate to the project directory:
   
```
   cd Auberge
```


5. Install dependencies:
   
```
   flutter pub get
```


### Firebase Setup

In order to enable authentication and Firestore services for the Auberge app, follow these steps to set up Firebase in your project:

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/).

2. Click on "Add project" and provide a name for your project.

3. Follow the on-screen instructions to create the Firebase project.

## Step 2: Enable Authentication

1. In the Firebase Console, navigate to "Authentication" from the left-side menu.

2. Click on "Get started" and then choose the "Sign-in method" tab.

3. Enable the sign-in methods you want to use for authentication (e.g., Email/Password, Google Sign-In, etc.).

## Step 3: Enable Firestore Database

1. In the Firebase Console, navigate to "Firestore Database" from the left-side menu.

2. Click on "Create database" and choose "Start in test mode" for development purposes.

3. Choose a region for your database.

4. Click "Enable" to create the Firestore database.

## Step 4: Add Firebase Configuration to Your App

1. For Flutter apps, add the Firebase configuration to the `android/app` and `ios/Runner` folders.

   - For Android:
     - Download the `google-services.json` file from the Firebase Console.
     - Place the `google-services.json` file inside the `android/app` directory.

   - For iOS:
     - Download the `GoogleService-Info.plist` file from the Firebase Console.
     - Place the `GoogleService-Info.plist` file inside the `ios/Runner` directory.

2. In your Flutter project, add the Firebase packages:

   ```
   dependencies:
     flutter:
       sdk: flutter
     firebase_core: ^latest_version
     firebase_auth: ^latest_version
     cloud_firestore: ^latest_version
   ```


### Google Sheets API Setup

- You can check out this youtube video for setting up GSheets API for this project or can follow below steps:
  [Youtube Link](https://www.youtube.com/watch?v=HiwJ8L7ce7Y)
  
1. Create a new project on the [Google Developers Console](https://console.developers.google.com/).

2. Enable the Google Sheets API for your project.

3. Generate and download the API credentials (JSON format).

4. Don't forget to place your API credentials and spreadsheetID in auberge\lib\ghseets.dart.

<div align="center">
 <img src="https://github.com/Photon3009/Auberge/assets/100941430/2a616e58-ace9-43c6-b35c-cded80480e62" alt="ghseets" width="500" height = "150" />
</div>


5. At last add sheets for all hostels of IET LKO in your spreadsheet project like below: (Enter any dummy data in them to test the app)

<div align="center">
 <img src="https://github.com/Photon3009/Auberge/assets/100941430/b3947ea2-b912-4839-9920-cd97ff9d014d" alt="ghseets" width="900" height = "150" />
</div>


### Run the app

```
flutter run
```


## Contributing

We welcome contributions to Auberge! 👋
By contributing to Auberge, you can help us refine existing features, add exciting new functionalities, improve user experience, and address issues. Your expertise and creativity can play a vital role in making Auberge even more robust and user-friendly.

Whether it's coding, testing, documenting, or providing valuable insights, your contributions are valuable and highly appreciated. Together, we can foster a collaborative environment that empowers users and elevates the app to new heights.

To contribute, follow these steps:

### Fork the Repository

- Click on the "Fork" button at the top right of this repository to create your fork.

### Create a New Branch

- Create a new branch for your changes:
```git add .
git commit -m "My feature implementation"
git push origin my-feature
```

### Make Changes

To make changes to the project or add new features, follow these steps:

1. Open the project in your preferred code editor or IDE.

2. Navigate to the relevant files you want to modify or add new features.

3. Make the necessary changes to the codebase.

4. Save the changes.

### Commit and Push

After making the changes, follow these steps to commit and push them to your GitHub repository:

1. Open a terminal or command prompt.

2. Navigate to the project directory.

3. Add the changes to the staging area:

### Commit and Push

After making the changes, follow these steps to commit and push them to your GitHub repository:

1. Open a terminal or command prompt.

2. Navigate to the project directory.

3. Add the changes to the staging area:
```
   git add . //The dot . adds all the changed files to the staging area. Alternatively, you can specify the file name to add individual files.
   git commit -m "Brief description of the changes made" //Commit the changes with a descriptive message
   git push origin main //Replace main with the branch name if you are using a different branch.
```

### Submit a Pull Request

- Go to the original repository on GitHub and click on "Compare & pull request."

- Fill in the necessary details about your changes and click on "Create pull request."

- Your pull request will be reviewed, and once approved, your changes will be merged into the main repository.

## Pre-Release Version

A pre-release version of Auberge is available for testing and feedback. You can access the pre-release on the [Releases page](https://github.com/Photon3009/Auberge/releases). Please download the APK file for the pre-release and feel free to provide feedback and report any issues you encounter. Your feedback is valuable in improving Auberge for everyone.
![Screenshot (633)](https://github.com/Photon3009/Auberge/assets/100941430/03c49113-7e2d-448f-990d-eee517ad392c)

## Testing Credentials

### User Credentials

- **User Email:** testuser1@gmail.com
- **Password:** -testuser1-

### Admin Credentials

- **Admin Email:** testadmin1@gmail.com
- **Password:** -testadmin1-


## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any inquiries or questions, you can reach out to the project maintainer:

- Name: Shivam Verma
- Email: sv30092001@gmail.com
- GitHub: [My GitHub Profile](https://github.com/Photon3009)

If you like this project then, show ❤️ by ⭐ this repository.

Happy coding😊
