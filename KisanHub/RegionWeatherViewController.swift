//
//  RegionWeatherViewController.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/28/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//

import UIKit

class RegionWeatherViewController: UIViewController {
    var regionString:String?
    @IBOutlet weak var activityIndicatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: AppConstants.filter)

        if let regionStringNonNil = regionString{
            
            if !UserDefaults.standard.bool(forKey: regionStringNonNil) {
                //// If previously already saved some values
                DispatchQueue.main.async {
                    CoreDataModel.shared.deleteValues(region: regionStringNonNil)
                    self.saveWeatherData(regionCode: regionStringNonNil)
                }

            }
            else {
                activityIndicatorView.isHidden = true

            }
            self.navigationItem.title = regionString

        }
        // Do any additional setup after loading the view.
    }

    func saveWeatherData(regionCode:String) {
        do{
            let keyarray = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC","WIN","SPR","SUM","AUT","ANN"]
            var url = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).last!
            url = url.appendingPathComponent(regionCode)
            let fileContents = try FileManager.default.contentsOfDirectory(atPath: url.path)
            for file in fileContents {
                let content =  try String(contentsOf: url.appendingPathComponent(file))
                let lineEntryArray = content.components(separatedBy: "\n")
                for lineEntry in lineEntryArray {
                    let dataArray = lineEntry.components(separatedBy: ",")
                    if dataArray.first?.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                        var index = 0
                        var type = Type.unknowntype
                        if file.contains("Tmax"){
                            type = Type.tMax
                        }
                        else if file.contains("Tmin"){
                            type = Type.tMin
                        }
                        else if file.contains("Sunshine"){
                            type = Type.sunshine
                        }
                        else if file.contains("Rainfall"){
                            type = Type.rainfall
                        }
                        for data in dataArray {
                            if index%2 == 1 {
                                if  let weatherItem = CoreDataModel.shared.getObjectInstance(objectName: DatabaseConstant.weatherItem) as? WeatherItem  {
                                    weatherItem.data = data
                                    weatherItem.key = keyarray[index/2]
                                    weatherItem.regionCode = regionCode
                                    weatherItem.type = type.rawValue
                                    weatherItem.actualData = dataArray[index - 1]
                                    CoreDataModel.shared.savedataContext()
                                }
                            }
                            index += 1
                        }
                    }
                }
            }
            if let regionStringNonNil = regionString{
                UserDefaults.standard.set(true, forKey: regionStringNonNil)
                for viewController in childViewControllers {
                    if let regionWeatherTableController = viewController as? RegionWeatherTableViewController{
                        regionWeatherTableController.reloadData(filter: nil)
                    }
                }
                activityIndicatorView.isHidden = true
            }
        }
        catch{
            print(error)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ActivityIndicatorViewController {
            destination.customTextString = LoadingConstants.savingData
        }
    }
 

}
