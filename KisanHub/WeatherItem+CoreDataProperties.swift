//
//  WeatherItem+CoreDataProperties.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/28/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherItem> {
        return NSFetchRequest<WeatherItem>(entityName: "WeatherItem")
    }

    @NSManaged public var regionCode: String?
    @NSManaged public var type: String?
    @NSManaged public var data: String?
    @NSManaged public var key: String?
    @NSManaged public var actualData:String?
    override public var description: String{
        var stringToPrint = ""
        if let dataNonNil = data {
            stringToPrint += dataNonNil
        }
//        if let typeNonNil = type {
//            stringToPrint += " " + typeNonNil
//
//        }
        if let dataNonNil = actualData {
            stringToPrint += " " + dataNonNil
        }
        if let keyNonNil = key {
            stringToPrint += " " + keyNonNil

        }
        
        return stringToPrint
    }
}
