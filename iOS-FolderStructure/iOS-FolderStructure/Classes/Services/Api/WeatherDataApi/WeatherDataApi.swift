//
//  WeatherDataApi.swift
//  iOS-FolderStructure
//
//  Created by Tharindu Perera on 2/22/19.
//  Copyright © 2019 Tharindu Perera. All rights reserved.
//

import Foundation

class WeatherDataApi: ApiCommunicator {
    
    init() {
        super.init(subPath: "data")
    }
    
    //////////////////////////////////////////////////////
    //MARK: - Public Methods
    //////////////////////////////////////////////////////
    
    func getData(cityId: String, completion: @escaping (Bool, String, WeatherData?) -> Void) {
        
        let params = [
            "id": cityId,
            "units": "metric",
            "appid": ApiKey
        ]
        
        callApi(endpoint: "2.5/group", params: params, method: .get) { (content, message, code, status) in
            
            if status == SuccessStatus {
                if let dataList = content?.value(forKey: "list") as? [[String: Any]], let data = dataList.first {
                    let weatherData = WeatherData(json: data)
                    
                    // DB caching
                    WeatherData.updateOrCreateWeatherData(data: weatherData)
                    
                    completion(true, Strings.Messages.Success.dataDownload, weatherData)
                } else {
                    completion(false, message, nil)
                }
            } else {
                completion(false, message, nil)
            }
        }
        
    }
    
}
