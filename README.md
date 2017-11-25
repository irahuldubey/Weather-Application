# Weather Application

Weather Application uses Weather API to fetch the data and displayed to use in customized format.

Public API for weather details:
http://api.openweathermap.org/data/2.5/weather?q=Westervile,oh,us&APPID=YOUR_APP_ID

Icons can be download from here:
http://openweathermap.org/weather-conditions 

## Warnings :

App Icons need to fit the default sizes expected by the XCode. Runs on all iOS Devices

## Improvements : 

1. ImageDownload Manager: Need to have caching mechanism to download the Image. Handle caching in memory and NSCache.
2. Data Store Manager: This is responsible for handling data operations in the application as of now the application uses NSUserDefaults to save the last searched String and fetch the same with latest update when use visits the application next time.
3. Error Handling: As of now application handles few error scenarios but to be bullet proof we need to handle all the expected errors and display a valid error message to user to be more interactive.
4. Business Rules: Validation of the city requested can be checked before we make any call to the Weather Service API
5. Weather Service API returns data in 2 formats : Celsius
 and Fahrenheit. Current application calls the service in Celsius
 format. There can be customization to accept the parameter type as Celsius
 or Fahrenheit formats. If use needs to toggle between the C and F we need to add customization from the application side.

## Additions:

1. Add unit test cases: Add Mocks and Stubs as necessary to test different scenarios of JSON response from the server.

## Application Screenshots

### Launch Image 

<img width="545" alt="Launch Page" src="https://user-images.githubusercontent.com/29422737/33234538-9499d770-d1f6-11e7-9980-3d23403db934.png">

### Landing Page

<img width="545" alt="Landing Screen" src="https://user-images.githubusercontent.com/29422737/33234624-818b8c9e-d1f8-11e7-8884-47afd656f3b6.png">


### Search Result Screen

<img width="545" alt="Home Screen" src="https://user-images.githubusercontent.com/29422737/33234547-b4d5aa82-d1f6-11e7-901d-cff589e3b0e9.png">



