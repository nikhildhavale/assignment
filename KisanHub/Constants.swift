//
//  Constants.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/26/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//

import Foundation
struct  AppConstants {
    static let txtArray = ["UK.txt","England.txt","Scotland.txt","Wales.txt"]
    static let urls = ["http://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/ranked/","http://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmin/ranked/","http://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmean/ranked/","http://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Sunshine/ranked/","http://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Rainfall/ranked/"]
    static let downloadedData = "downloadData"
    static let filter = "filter"
}
struct MainStoryBoardConstants {
    static let regionCellIdentifier = "regionCellIdentifiers"
    static let showWeather = "showWeather"
}
struct  DatabaseConstant {
    static let weatherItem = "WeatherItem"
}
struct LoadingConstants {
    static let downloadingData = "Downloading Data"
    static let savingData = "Saving Data"
}
