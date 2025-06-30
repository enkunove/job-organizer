# handwritten readme!!
if something is not working i can share a docker image of the devenv. because everything is working

## my development env:
- Flutter 3.32.5
- Dart 3.8.1
- Android SDK 35.0.1 
- XCode 16.3

## min technical requirements to launch:
- IOS 13.0
- Android SDK 23

## used technologies, patterns etc:
- Clean architecture. might be a little overengeneering for this kind of task, but i followed solid
- MVVM in presentation layer with Provider
- Navigator 2.0 with AutoRoute. Choosen it since we need Web support, now app has beautiful uri pagination
- FirebaseAuth and Firestore
- GetIt for DI
- SharedPrefs for storing user settings
- Mocktail, FirebaseAuthMocks and Integration Tests for testing
- FlutterLocalNotifications for permisions and scheduling notifications

## features
- firebase auth with remember me (including Web)
- boards system for managing tasks. Creating, editing, archiving boards with description and custom user styling
- same for tasks, although they have a more complex lifecycle and priority system
- sorting and filtration algorythms for tasks
- light/dark theme
- notifications 1 day before meeting the deadline of a task
- restoring of deleted or archived data
- pages are adopted for the screen size. different design in some cases
- no comments or documentations. but the classes, functions and vars names are clear
