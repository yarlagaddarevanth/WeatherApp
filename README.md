# WeatherApp
Revanth Interview Exercise for JPMC 

* Developed using Xcode 14.0
* Please open WeatherApp.xcworkspace file with Xcode(as Cocoapods is used).

# The APP
On Launch:
* Priority 1: If user grants location permission, weather for user's current location is shown by default on launch.
* Priority 2: If user has previously searched any city, weather for the latest searched city is shown by default on launch.
* User can search for any city in the provided search bar and tap on search button on the keyboard to see the weather data.

# Technical Details:
* Followed MVVM for all the views
* Used SDWebImage library on Cocoapods for Image Caching if weather status icons.

# TODO:
* Spinner for load stateds
* Save weather data as well along with city name to instantly show data on launch

