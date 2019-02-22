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
    
    //////////////////////////////////////////////////////
    //MARK: - View Controller Methods
    //////////////////////////////////////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAlerts(containerView: mainContainerView)
        resetDetailsView()
        fetchData()
    }

    //////////////////////////////////////////////////////
    //MARK: - Private Methods
    //////////////////////////////////////////////////////
    
    private func fetchData() {
        showActivityIndicator()
        weatherDataApi.getData(cityId: CityCode) { (success, message, data) in
            self.hideActivityIndicator()
            if success && data != nil  {
                self.setDetailsView(cityName: data!.name ?? "N/A", id: "\(data!.locationId == UnknownInt ? "N/A" : "\(data!.locationId)")", temp: "\(data!.temp == UnkownFloat ? "N/A" : "\(data!.temp)")", description: data!.weatherDescription ?? "N/A")
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
    
    private func setDetailsView(cityName: String, id: String, temp: String, description: String) {
        cityLbl.setTitleAndValue(title: "City:  ", value: cityName)
        idLbl.setTitleAndValue(title: "ID:  ", value: id)
        tempLbl.setTitleAndValue(title: "Temp:  ", value: temp)
        descLbl.setTitleAndValue(title: "Descrption:  ", value: description)
    }
    
    private func resetDetailsView() {
        self.setDetailsView(cityName: "N/A", id: "N/A", temp: "N/A", description: "N/A")
    }
    
    //////////////////////////////////////////////////////
    //MARK: - Events
    //////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////
    //MARK: - Delegate Methods
    //////////////////////////////////////////////////////

}

