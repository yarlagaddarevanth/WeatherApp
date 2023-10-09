# WeatherApp
Revanth Interview Exercise for JPMC 

* Developed using Xcode 14.0
* Please open WeatherApp.xcworkspace file with Xcode(as Cocoapods is used).

# The APP

![Simulator Screen Shot - Clone 2 of iPhone 14 Pro - 2023-10-09 at 12 14 29](https://github.com/yarlagaddarevanth/WeatherApp/assets/15115837/9c88adec-afb7-4f03-a1d0-e28d078fce71)

On Launch:
* Priority 1: If user grants location permission, weather for user's current location is shown by default on launch.
* Priority 2: If user has previously searched any city, weather for the latest searched city is shown by default on launch.
* User can search for any city in the provided search bar and tap on search button on the keyboard to see the weather data.
* Basic weather details are shown for the city with status icon. 

# Technical Details:
* Followed MVVM for all the views.
* Used 'SDWebImage' library on Cocoapods for Image Caching of weather status icons. Dependent Pods are included within the project repository as recommended.
* 'WTLocationManager' manages permission requests and fetching user's current location.
* Used Apple's Reverse geocoding functions to get user's current city from user's current location coordinates. 
* Followed Dependency Injection for DataProvider, APIService and URLBuilder using protocols. Given more time, We can also implement dependency injection for the HomeViewModel.
* Unit tests included and all of them pass.
* Latest searched city name is saved and persisted using UserDefaults, on successful receiving of the weather data.

# TODO:
* Save weather data as well along with city name to instantly show data on launch
* Give choice to users to view temperature in different Units.
* Given more time, add more unit tests to increase test coverage.
* Bugfix - Fix the initial delay on app launch when fetching location fails.

