//
//  WeatherData.swift
//  iOS-FolderStructure
//
//  Created by Tharindu Perera on 2/22/19.
//  Copyright © 2019 Tharindu Perera. All rights reserved.
//

import Foundation
import OLCOrm

class WeatherData: OLCModel {
    
    // Reserved for WeatherData ID in WeatherData OLCOrm DB Table
    @objc var Id: NSNumber?
    
    @objc var locationId: Int = UnknownInt
    @objc var name: String?
    @objc var weatherDescription: String?
    @objc var temp: Float = UnkownFloat
    
    override init() {
        super.init()
    }
    
    init(locationId: Int, name: String, weatherDescription: String, temp: Float) {
        self.locationId = locationId
        self.name = name
        self.weatherDescription = weatherDescription
        self.temp = temp
    }
    
    init(json: [String:Any]) {
        if let name = json["name"] as? String {
            self.name = name
        }
        
        if let id = json["id"] as? Int {
            self.locationId = id
        }
        
        if let main = json["main"] as? [String:Any], let temp = main["temp"] as? Float {
            self.temp = temp
        }
        
        if let weather = json["weather"] as? [[String:Any]], let first = weather.first, let description = first["description"] as? String {
            self.weatherDescription = description
        }
    }
    
    // Public get methods
    
    static func getWeatherDataByLocationId(locationId: Int) -> WeatherData? {
        
        if let weatherDataSet = WeatherData.__where("locationId=\(locationId)", sortBy: "Id", accending: true) as? [WeatherData], let weatherData = weatherDataSet.first {
            return weatherData
        }
        
        return nil
    }
    
    // Public update methods
    
    static func updateWeatherTemperature(locationId: Int, temp: Float) -> Bool {

        if let existingWeatherData = getWeatherDataByLocationId(locationId: locationId) {
            existingWeatherData.temp = temp
            existingWeatherData.update()
            return true
        }
        
        return false
    }
    
    static func updateOrCreateWeatherData(data: WeatherData) {
        
        if let existingWeatherData = getWeatherDataByLocationId(locationId: data.locationId) {
            data.Id = existingWeatherData.Id
            data.update()
        } else {
            data.save()
        }
    }
    
    // Public delete methods
    
    static func deleteWeatherDataByLocationId(locationId: Int) {
        WeatherData.query("delete from '\(DBName).WeatherData' locationId=\(locationId)")
    }
    
}
