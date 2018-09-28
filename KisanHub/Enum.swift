//
//  Enum.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/26/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//

import Foundation
enum Type:String {
   case tMax = "Tmax"
   case tMin = "Tmin"
    case sunshine = "Sunshine"
    case rainfall = "Rainfall"
    case unknowntype = "unknown_type"
    static let array = [Type.tMax,Type.tMin,Type.sunshine,Type.rainfall,Type.unknowntype]
}
enum Key:String{
    case jan = "JAN"
    case feb = "FEB"
    case mar = "MAR"
    case apr = "APR"
    case may = "MAY"
    case jun = "JUN"
    case jul = "JUL"
    case aug = "AUG"
    case sep = "SEP"
    case oct = "OCT"
    case nov = "NOV"
    case dec = "DEC"
    case win = "WIN"
    case spr = "SPR"
    case sum = "SUM"
    case aut = "AUT"
    case ann = "ANN"
   static let keyarray = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC","WIN","SPR","SUM","AUT","ANN"]

}
