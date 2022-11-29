# Using the Tutorial App to trigger the in-app message

### Getting Started

Follow the steps below to download the InappTutorialApp from the [Messaging GitHub repository](https://github.com/adobe/aepsdk-messaging-ios).

1. Navigate to the GitHub repository using the URL https://github.com/adobe/aepsdk-messaging-ios/tree/messaging-tutorials.

2. Click on **Code (1)** then select **Download ZIP (2)** from the pop-up dialog.

| ![Messaging Extension Code](assets/messaging-github-code.png?raw=true) |
| :---: |
| **Messaging Extension Code** |

> [!NOTE]
> Steps 3-6 in this section include commands you can run from your favorite Terminal app.  

3. Copy the `aepsdk-messaging-ios-messaging-tutorials.zip` file from your `Downloads` directory to another appropriate location. For example, your home directory

```
mv ~/Downloads/aepsdk-messaging-ios-messaging-tutorials.zip ~/
```

4. Unzip the file in the target location.

```
cd ~/
unzip aepsdk-messaging-ios-messaging-tutorials.zip
```

5. Change directory to the `InappTutorialApp-Start`

```
cd aepsdk-messaging-ios-messaging-tutorials/docs/tutorials/InappTutorialApp-Start
```

6. Open Xcode workspace file `InappTutorialApp.xcworkspace` in Xcode.

```
open InappTutorialApp.xcworkspace
```

### Install AEPMessaging SDK Extension in your mobile application

Follow the steps in [Install SDK Extensions guide](../getting-started/install-sdk-extensions.md) to install the AEPMessaging SDK extension and its dependencies in your mobile application.

For this tutorial, the `InappTutorialApp` uses [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) for dependency management. The `Podfile` is already integrated in the workspace and the pod dependencies are installed. Verify `Podfile.lock` to inspect the dependency versions.

### Initialize the mobile SDK

Follow the steps in [Initialize SDK guide](../getting-started/init-sdk.md) to initialize the Experience Platform mobile SDK by registering the SDK extensions with `Mobile Core`.

For this tutorial, initlization code is already implemented in `InappTutorialApp`.

### Run the mobile application

Follow the steps below to run the `InappTutorialApp` app:

1. Select the mobile app target **InappTutorialApp (1)** and the destination device e.g. iPhone 14 simulator (2). Click on Play icon (3).

| ![Run Mobile App](../../assets/mobile-app-run.png?raw=true) |
| :---: |
| **Run Mobile App** |

2. You should see the mobile app running on your simulator device.

|![Offers View](../../assets/mobile-app-offers-view.png?raw=true) | ![Settings View](../../assets/mobile-app-settings-view.png?raw=true) |
| :---------: | :------------: |
| **Offers View** |  **Settings View** |