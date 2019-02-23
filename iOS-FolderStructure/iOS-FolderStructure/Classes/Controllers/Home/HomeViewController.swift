//
//  ViewController.swift
//  iOS-FolderStructure
//
//  Created by Tharindu Perera on 2/22/19.
//  Copyright © 2019 Tharindu Perera. All rights reserved.
//

import UIKit

class HomeViewController: AppParentViewController {
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var detailsContainerView: UIView!

    private let weatherDataApi = WeatherDataApi()
    
    private var isDataLoadingNeeded = true
    
    //////////////////////////////////////////////////////
    //MARK: - View Controller Methods
    //////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAlerts(containerView: mainContainerView)
        setupUI()
        isDataLoadingNeeded = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isDataLoadingNeeded {
            fetchData()
            isDataLoadingNeeded = false
        }
    }

    //////////////////////////////////////////////////////
    //MARK: - Private Methods
    //////////////////////////////////////////////////////
    
    private func setupUI() {
        // Show details using DB caching
        self.setDetailsView(data: WeatherData.getWeatherDataByLocationId(locationId: Int(CityCode) ?? UnknownInt))
    }
    
    private func fetchData() {
        
        showActivityIndicator()
        
        weatherDataApi.getData(cityId: CityCode) { (success, message, data) in
            self.hideActivityIndicator()
            if success && data != nil  {
                self.showAlert(message: message, type: .success, showed: nil, hidden: nil)
                self.setDetailsView(data: data)
            } else {
                self.showAlert(message: message, type: .error, showed: nil, hidden: nil)
            }
        }
    }
    
    private func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = UIColor.purple
        activityIndicator.center = CGPoint(x: detailsContainerView.bounds.width / 2, y: detailsContainerView.bounds.height / 2)
        detailsContainerView.addSubview(activityIndicator)
        detailsContainerView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        let subviews: [UIView] = detailsContainerView.subviews
        for subview in subviews {
            guard let activityView = subview as? UIActivityIndicatorView else { continue }
            
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        }
    }
    
    private func setDetailsView(data: WeatherData?) {
        if let weatherData = data {
            cityLbl.setTitleAndValue(title: "City:  ", value: weatherData.name ?? "N/A")
            idLbl.setTitleAndValue(title: "ID:  ", value: "\(weatherData.locationId == UnknownInt ? "N/A" : "\(weatherData.locationId)")")
            tempLbl.setTitleAndValue(title: "Temp:  ", value: "\(weatherData.temp == UnkownFloat ? "N/A" : "\(weatherData.temp) C")")
            descLbl.setTitleAndValue(title: "Descrption:  ", value: weatherData.weatherDescription ?? "N/A")
        } else {
            cityLbl.setTitleAndValue(title: "City:  ", value: "N/A")
            idLbl.setTitleAndValue(title: "ID:  ", value: "N/A")
            tempLbl.setTitleAndValue(title: "Temp:  ", value: "N/A")
            descLbl.setTitleAndValue(title: "Descrption:  ", value: "N/A")
        }
    }
    
    //////////////////////////////////////////////////////
    //MARK: - Events
    //////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////
    //MARK: - Delegate Methods
    //////////////////////////////////////////////////////

}

