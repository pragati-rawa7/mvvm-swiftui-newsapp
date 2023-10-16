# mvvm-swiftui-newsapp
Created a Repo using MVVM, Swift UI, Unit and UI Testing 

# SwiftUI MVVM App with Unit and UI Testing

This is a sample SwiftUI project showcasing the MVVM (Model-View-ViewModel) architecture. It includes unit tests and UI tests to ensure the quality of the application.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Running Unit Tests](#running-unit-tests)
- [Running UI Tests](#running-ui-tests)
- [License](#license)

## Overview

This project is a SwiftUI application that follows the MVVM architectural pattern. It separates concerns between the Model, View, and ViewModel, providing a clean and testable structure. The application demonstrates how to manage and display a list of todos, add new todos, and mark them as completed.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Xcode (Version 13.3 or later)
- A macOS or iOS device/simulator to run the app

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/pragat-rawa7/mvvm-swiftui-newsapp/.git
Open the project in Xcode:

bash
Copy code
cd mvvm-swiftui-newsapp/
open NewsAppiOS.xcodeproj
Build and run the application on your chosen device or simulator.

Project Structure
The project is structured as follows:

Model: Contains the data models.
ViewModel: Implements the business logic and prepares data for the views.
View: Defines the SwiftUI views and how data is presented.
Tests: Contains unit tests and UI tests.
Running Unit Tests
The project includes unit tests to ensure the correctness of the ViewModel logic. To run the unit tests:

In Xcode, go to the "NewsAppiOS" project.
Select the "NewsAppiOS" target.
Go to the "Product" menu and choose "Test" or use the keyboard shortcut (⌘U).
Running UI Tests
The project includes UI tests to validate the user interface and interactions. To run the UI tests:

In Xcode, go to the "NewsAppiOS" project.
Select the "NewsAppiOSUITests" target.
Go to the "Product" menu and choose "Test" or use the keyboard shortcut (⌘U).

License
You are free to use, modify, and distribute the code as you see fit. See the LICENSE file for more details.

