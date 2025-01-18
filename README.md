# Weather Forecasting App

A simple cross-platform mobile application for weather forecasting built with Flutter. This app allows users to search for a city, view current weather details, and a 3-day weather forecast. Users can also toggle between Celsius and Fahrenheit temperature units.

## Features

- **Search Bar**: Search for any city to view weather details.
- **Current Weather Information**:
  - Temperature
  - Humidity
  - Weather description (e.g., sunny, cloudy)
- **3-Day Weather Forecast**: Scrollable list of weather predictions for the next three days.
- **Unit Conversion**: Toggle between Celsius and Fahrenheit.
- **Local Storage**:
  - Save the last searched city.
  - Save preferred temperature unit.
- **Error Handling**: Gracefully handles API errors with appropriate messages.

## API Integration

The app uses the [OpenWeather API](https://openweathermap.org/api) to fetch weather data. The free tier is sufficient for testing.

## Design

- **UI**: Clean, user-friendly, and responsive design.
- **Platforms**: Works seamlessly on both Android and iOS devices.

## Technical Requirements

- **State Management**: Implemented using Provider.
- **Local Storage**: Utilized SharedPreferences to store user preferences.
- **Error Handling**: Displays error messages for network issues, invalid city searches, or API-related errors.

## How to Run the App

1. **Prerequisites**:
   - [Flutter](https://flutter.dev/docs/get-started/install) installed on your system.
   - An active OpenWeather API key.

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/KevinShingala/weather_app_kevin.git
   cd weather_forecasting_app
   ```

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the App**:
   - On an Android Emulator or iOS Simulator:
     ```bash
     flutter run
     ```

5. **APK Testing**:
   - Download the pre-built APK from the `releases` section in this repository.

## Challenges and Solutions

1. **API Error Handling**:
   - **Challenge**: Managing errors like invalid city names or network failures.
   - **Solution**: Used try-catch blocks and displayed user-friendly error messages.

2. **State Management**:
   - **Challenge**: Ensuring efficient and clean state management.
   - **Solution**: Adopted Provider for managing app state.

3. **Responsive Design**:
   - **Challenge**: Making the UI look good on various screen sizes.
   - **Solution**: Used Flutter's layout widgets and media queries for responsiveness.

4. **Local Storage**:
   - **Challenge**: Saving user preferences for the last searched city and temperature unit.
   - **Solution**: Integrated SharedPreferences for lightweight local storage.

## Screenshots

https://drive.google.com/file/d/10W9TJUlthMpIBcEzWWFWC32-GjwKTmRS/view?usp=sharing
https://drive.google.com/file/d/1ucHtjN-wjJzPe-6GFbefBK09_nuUJy_V/view?usp=sharing
https://drive.google.com/file/d/1h_YvTk7UHhbm37P-nllMcZtAtTB9xtyS/view?usp=sharing

## Technologies Used

- **Framework**: Flutter
- **State Management**: Provider
- **Storage**: SharedPreferences
- **API**: OpenWeather API
- **Tools**: VS Code, Git


## Contact

For any inquiries or feedback, please contact:
- **Email**: kevinshingala73462@gmail.com
