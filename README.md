# iOS Push Notification SDK

## Introduction

The Local Push Notification Library is designed to simplify the process of setting up and managing push notifications in your iOS projects. This library provides easy integration with Firebase for handling remote push notifications.

## Prerequisites

Before you begin, make sure you have the following set up:

1. An active Firebase project: You must have a Firebase project set up on the Firebase Console to use remote push notifications.

2. Firebase configuration file: Obtain the `GoogleService-Info.plist` file from your Firebase project and add it to your Xcode project.

## Getting Started

Follow the steps below to integrate the Local Push Notification Library into your iOS project:

### Step 1: Add Push Notification Capability

- Enable the "Push Notifications" capability for your app.

### Step 2: Add Local Library Framework

- Add the Local Push Notification Library framework.
- Drag and drop the framework into your Xcode project.

### Step 3: Configure Push Notification Manager in AppDelegate

- In your `AppDelegate.swift`, configure the push notification manager.  
