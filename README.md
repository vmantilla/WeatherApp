# WeatherApp

WeatherApp is a weather application that allows users to check the current weather and forecast for different locations. The application supports iOS 11 and follows the MVVM (Model-View-ViewModel) architectural pattern with the Coordinator pattern. It utilizes the Alamofire and Kingfisher libraries for networking and image loading, respectively.

## Installation

1. Clone or download the repository.
2. Install the required dependencies using CocoaPods. Open a terminal window, navigate to the project directory, and run the following command:

3. Open the `WeatherApp.xcworkspace` file in Xcode.
4. Build and run the application on the iOS simulator or a physical device running iOS 11 or later.

## Features

- View the current weather and forecast for different locations.
- Search for locations to retrieve weather information.
- Display weather condition icons.
- Handle errors and show appropriate messages.

## Models

The application uses the following models:

- `Location`: Represents a location with an ID, name, and country.
- `Forecast`: Contains forecast data for a location, including the current weather and forecast details.
- `CurrentWeather`: Represents the current weather information, including temperature, condition, wind, pressure, precipitation, humidity, and visibility.
- `ForecastDetails`: Contains forecast details for multiple days, including maximum and minimum temperatures, precipitation, snowfall, visibility, humidity, and UV index.
- `DayForecast`: Represents the forecast for a specific day, including the date and day details.
- `DayDetails`: Contains details for a specific day, including maximum and minimum temperatures, average temperature, wind, precipitation, snowfall, visibility, humidity, and UV index.
- `Condition`: Represents a weather condition, including the condition text, icon URL, and code.

## View Models

The application uses the following view models:

- `LocationViewModel`: Handles the search and management logic for locations. It communicates with the `NetworkService` to fetch location data. The view model provides methods to search locations, get the number of locations, and retrieve location information at a specific index.
- `ForecastViewModel`: Manages the forecast data for a specific location. It retrieves the forecast data from the `NetworkService` and provides methods to get the forecast, current weather, current location, and the image name for the weather condition.

## Networking

The application uses the Alamofire library for network requests. The `NetworkService` protocol defines methods for fetching location and forecast data. The `NetworkService` implementation utilizes Alamofire to perform API requests and handles the response data parsing.

## Image Loading

The Kingfisher library is used for image loading and caching. The `ForecastCollectionViewCell` and `CurrentCollectionViewCell` utilize Kingfisher to load weather condition icons from a URL and display them in the respective views.

## Coordinator Pattern

The Coordinator pattern is used to handle navigation and flow control within the application. The coordinators manage the view controllers and facilitate communication between them. The application includes the following coordinators:

- `LocationCoordinator`: Manages the location-related view controllers and coordinates the flow between them. It initializes the `LocationViewModel` and presents the `LocationViewController`. It also handles the navigation to the forecast details screen using the `ForecastCoordinator`.
- `ForecastCoordinator`: Manages the forecast-related view controllers and coordinates the flow between them. It initializes the `ForecastViewModel` with a specific location and presents the `ForecastViewController`. It also handles the retrieval of forecast data and communicates with the parent coordinator to signal completion.

## Configuration

The application requires a `Secrets.plist` file to store sensitive information such as the base URL and API key.

### Secrets.plist

The Secrets.plist file is a configuration file used to store sensitive information, such as API keys and other credentials, securely in your application. It is commonly used to separate sensitive data from the rest of the codebase and to prevent exposing this information in version control systems.

In the context of the WeatherApp project, the Secrets.plist file is used to store the baseURL and apiKey values required to access the weather API. These values are necessary for the application to communicate with the API and retrieve weather data.

- `baseURL`: The base URL for the weather API.
- `apiKey`: The API key for accessing the weather data.

During development, the Secrets.plist file is typically created locally and added to the project. The API key is stored as a string value in the file for convenience. However, for production deployment, it is recommended to provide the API key as a Data object and convert it to a string during runtime. This helps to protect the API key and prevent unauthorized access.

To ensure the security of sensitive data, it is important to follow best practices, such as:

- Adding the Secrets.plist file to the project's .gitignore file to prevent it from being accidentally committed and pushed to a public repository.
- Keeping the file secure and not sharing it with unauthorized individuals.
- Using secure methods to access and retrieve the sensitive information from the Secrets.plist file within the application code.
- By using the Secrets.plist file, you can maintain the confidentiality of sensitive data and improve the overall security of your application.

Ensure that you add the `Secrets.plist` file to the project and configure the keys correctly for the application to function properly.

## Requirements

- Xcode 12 or later.
- Swift 5.0 or later.
- iOS 11.0 or later.


