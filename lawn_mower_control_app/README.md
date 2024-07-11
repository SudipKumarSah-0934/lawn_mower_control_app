# Lawn Mower Control App
This Flutter application provides a control interface for a lawn mower, including functionalities to operate the machine, manage the engine, view machine information, handle errors, and change passwords.

## Features
Machine Information Screen: View detailed information about the machine.
Error Information Screen: View and manage error information.
Machine Operating Screen: Control the movement of the machine.
Engine Operation Screen: Start and stop the engine of the machine.
Password Change Screen: Change the user password.
Settings: Access various settings of the app.
## Screens
Main Screen
The main entry point of the application which navigates to different features using a grid layout.

Machine Information Screen
Provides detailed information about the lawn mower machine.

Error Information Screen
Displays error information related to the machine.

Machine Operating Screen
Allows the user to control the movement of the machine, including moving forward, backward, left, and right.

Engine Operation Screen
Allows the user to start and stop the engine of the machine.

Password Change Screen
Enables the user to change their password.

Setting Screen
Provides access to various settings of the application.
## User manual
- Start or Stop engine button
    - Audio plays of vehicle start
    - Move rectangular like object for specific time in specific direction based on direction list input value [1,128,255] left movement, forward movement and right movement on small green bush land 
- At the bottom of screen
    -  there are four button arrow button represent forward, reverse, left and right movement of rectangular object   with circular button in centre for representing red blade for cutting when button start or stop is pressed, in background it plays audio also.
    - show snackbar on reaching end of each side of lane boundaries.
- Slide to increase speed in setting screen
- Raise the volume to full to hear the sound of engine start and blade cutting

- Please extract zip file and hit pub get to fetch the package required to build the application.
- change directory to the main project folder and hit flutter build apk for apk file to test.