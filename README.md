# Weather Application

Weather Application uses Weather API to fetch the data and displayed to use in customized format.

Public API for weather details:
http://api.openweathermap.org/data/2.5/weather?q=Westervile,oh,us&APPID=YOUR_APP_ID

Icons can be download from here:
http://openweathermap.org/weather-conditions 

Sample URL with Personal Key: http://api.openweathermap.org/data/2.5/weather?appid=f0fabeaad750dd1a5de08d011233f5c2&q=tampa&mode=json&units=imperial. 

Warnings : App Icons need to fir the default sizes expected by the XCode. Runs on all iOS Devices

###headings
Improvements : 

1. ImageDownload Manager: Need to have caching mechanism to download the Image. Handle caching in memory and NSCache.
2. Data Store Manager: This is responsible for handling data operations in the application as of now the application uses NSUserDefaults to save the last searched String and fetch the same with latest update when use visits the application next time.
3. Error Handling: As of now application handles few error scenarios but to be bullet proof we need to handle all the expected errors and display a valid error message to user to be more interactive.
4. Business Rules: Validation of the city requested can be checked before we make any call to the Weather Service API
5. Weather Service API returns data in 2 formats : Celsius
 and Fahrenheit. Current application calls the service in Celsius
 format. There can be customization to accept the parameter type as Celsius
 or Fahrenheit formats. If use needs to toggle between the C and F we need to add customization from the application side.

Additions:

1. Add unit test cases: Add Mocks and Stubs as necessary to test different scenarios of JSON response from the server.




