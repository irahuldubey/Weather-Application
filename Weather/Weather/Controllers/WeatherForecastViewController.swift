//
//  WeatherForecastViewController.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import UIKit


class WeatherForecastViewController: UIViewController, ActivityIndicatorProtocol {
  
  ///MARK: - IBOutlets
  
  @IBOutlet weak var welcomeView: UIStackView!
  @IBOutlet weak var weatherDetailView: UIView!
  @IBOutlet weak var forecastType: UILabel!
  @IBOutlet weak var cityName: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherLogo: UIImageView!
  @IBOutlet weak var minimumTemperature: UILabel!
  @IBOutlet weak var maximumTemperature: UILabel!
  @IBOutlet weak var windSpeed: UILabel!
  @IBOutlet weak var humidity: UILabel!
  @IBOutlet weak var pressure: UILabel!
  @IBOutlet weak var visibility: UILabel!
  
  @IBOutlet weak var sunsetTime: UILabel!
  @IBOutlet weak var sunriseTime: UILabel!
  
  ///MARK: - Protocols
  ///Activity Protocol Conformance
  var activityIndicator = UIActivityIndicatorView()
  
  ///MARK: - Properties
  lazy var weatherForecardViewModel: WeatherForecastViewModel = WeatherForecastViewModel()
  lazy var dataStore: DataStoreManager = DataStoreManager.sharedInstance
  
  //Search Controller, Lazily Initialized on the first access
  lazy var searchController: UISearchController  = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = PlaceHolders.search
    searchController.searchBar.delegate = self
    return searchController
  }()
  
  //MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Add search controller to navigation bar.
    setUpNavigationAndSearchBar()
    
    //Set Up Searched Result as per webservice call
    updateUIOnLaunch()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //MARK: - Deinitializer
  
  deinit {
    //Will be replaced by Logger API
    print("Deinitialized WeatherForecastViewController")
  }
  
  //MARK: - Private Functions
  private func setUpNavigationAndSearchBar() {
    navigationItem.searchController = searchController
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    definesPresentationContext = true
  }
  
  /// Show/Hide the Welcome View and Weather details view
  private func searchResult(shouldShow: Bool) {
    self.weatherDetailView.isHidden = !shouldShow
    self.welcomeView.isHidden = shouldShow
  }
  
  /// Clear Searched Results Data
  private func clearSearchedResults() {
    searchController.searchBar.text = nil
    searchController.searchBar.resignFirstResponder()
  }
  
  ///Perform any additional updates on service success
  private func updateViewOnSuccess() {
    forecastType.text = weatherForecardViewModel.forecastType
    cityName.text  = weatherForecardViewModel.cityName
    temperatureLabel.text  = weatherForecardViewModel.temperature
    minimumTemperature.text  = weatherForecardViewModel.minimumTemperature
    maximumTemperature.text  = weatherForecardViewModel.maximumTemperature
    windSpeed.text  = weatherForecardViewModel.windSpeed
    humidity.text  = weatherForecardViewModel.humidity
    pressure.text  = weatherForecardViewModel.pressure
    visibility.text  = weatherForecardViewModel.visibility
    
    ///Download the image, Calling the download service to download the image, Personally. I rerfrain from using UIKit elements in view models hence added the download logic here. ImageDownloader can get the UIImage and pass it to the view controllers
    ImageDownloadManager.sharedInstance.fetchImage(with: weatherForecardViewModel.iconID,
                                                   completionHandler: { [weak self] (image) in
          guard let `self` = self else { return }
          DispatchQueue.main.async {
              self.weatherLogo.image = image
          }
    })
  }
  
  ///Perform any additional updates on service failure
  private func updateViewOnFailure() {
    
    var errorText: String =  Message.defaultErrror
    if let error = weatherForecardViewModel.errorText {
      errorText = error
    }
    
    /// Hide the search result view
    searchResult(shouldShow: false)
    
    ///Call the extension method of the UIViewController on the webservice failure
    show(title: Message.alertTitle, message: errorText, actionTitle: Message.ok, preferredStyle: .alert, actionStyle: .cancel)
  }
  
  ///Checks for the last queried city in the Data Store if not it goes ahead and reset the view
  private func updateUIOnLaunch() {
    ///Check if the last city was queried, if yes update the view with last city and name and current weather details
    
    guard dataStore.hasValue(for: DataStoreKey.lastSearchedItem),
          let searchedText = dataStore.fetchDataFromStore(for: DataStoreKey.lastSearchedItem) as? String else {
      //Reset the UI as fresh start
      clearSearchedResults()
      ///Display welcome message
      searchResult(shouldShow: false)
      return
    }

    ///Fetch the details for the last city searched
    fetchWeatherDetails(for: searchedText)
  }
  
  ///Call the webservice and update the View Controller
  private func fetchWeatherDetails(for city: String?) {
    ///Guard the Valid Search Text else Return
    guard let city = city,  city.count > 0 else {
      //Will be replaced by Logger API
      print("Enter a valid City Name")
      return
    }
    
    //Show Loading Indicator with Medium Size
    showLoadingIndicator(withSize: CGSize.init(width: 80, height: 80))
    
    ///Call the webservice to update the Weather Data
    weatherForecardViewModel.fetchWeatherDetails(for: city) { [weak self] (status) in
      guard let `self` = self else { return }
      ///Update the UI on the Dispatch Queue since service call was on the Background Queue
      DispatchQueue.main.async {
        switch status {
        case .success:
          ///Update the veiw controller on success response
          self.updateViewOnSuccess()
          ///Show the searched result
          self.searchResult(shouldShow: true)
          //Update the database
          self.dataStore.saveDataToStore(for: [DataStoreKey.lastSearchedItem : city])
        case .failure:
          ///Update the veiw controller on failure response
          self.updateViewOnFailure()
          ///Remove the Key from the store
          self.dataStore.removeDataFromStore(for: DataStoreKey.lastSearchedItem)
        }
        //Remove the Activity Indicator once response is received
        self.removeLoadingIndicator()
      }
    }
  }
}

//MARK: - Search Bar Delegate
extension WeatherForecastViewController:  UISearchBarDelegate {
  
  /// Search Delegate Method when return is pressed in the search bar
  ///
  /// - Parameter searchBar: is of type UISearchBar
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    //Dismiss the Keyboards
    searchBar.resignFirstResponder()
    
    ///Fetch the weather details from the API
    guard let _ = searchBar.text else {
      show(title: Message.alertTitle,
           message: Message.emptySearch,
           actionTitle: Message.ok,
           preferredStyle: .alert,
           actionStyle: .cancel)
      
      ///Good to Have: We can add additional checks here like calling the service to check for the valid cities.
      ///Validation for Alphanumeric, Numbers etc as per the requirement.
      ///There will be a function in View Model to do the validation
      return
    }
    
    ///Fetch method to fetch the details from the service
    fetchWeatherDetails(for: searchBar.text)
  }
}
