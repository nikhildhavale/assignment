//
//  ViewController.swift
//  KisanHub
//
//  Created by Nikhil Modi on 8/16/16.
//  Copyright © 2016 Nikhil Modi. All rights reserved.
//

import UIKit

class RegionViewController: UIViewController {
    @IBOutlet weak var activityContainerView: UIView!
    var regionIndex = 0
    var contentURLIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserDefaults.standard.bool(forKey: AppConstants.downloadedData) {
            downloadContent()

        }
        else {
            activityContainerView.isHidden = true
        }
            


        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        for viewController in childViewControllers {
//            if let activityIndicatorController =
//        }
//    }
    func downloadContent(){
            if self.contentURLIndex == AppConstants.urls.count  {
                DispatchQueue.main.async {
                    self.activityContainerView.isHidden = true
                }
                UserDefaults.standard.set(true, forKey: AppConstants.downloadedData)
                return
            }
            let contentURL = AppConstants.urls[contentURLIndex]
            let txt = AppConstants.txtArray[regionIndex]
            
                let networkSession = NetworkSession(success: { data,urlString,requestString in
                    let actualData =  String(data: data, encoding: String.Encoding.utf8)
                    guard let lastString = actualData?.components(separatedBy: "Last updated").last else {
                        return
                    }
                    if var url = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask).last{
                        do {
                             url = url.appendingPathComponent(txt.replacingOccurrences(of: ".txt", with: ""))
                            if !FileManager.default.fileExists(atPath: url.path, isDirectory: nil){
                                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
                            }
                           // let url = URL(string: urlString)!
                            let pathComponentURL  =   url.appendingPathComponent(urlString.replacingOccurrences(of: "/", with: ""))
                            print("File written \(pathComponentURL)")
                            try lastString.convertToCSV().write(to: pathComponentURL, atomically: true, encoding: String.Encoding.utf8)
                                    self.regionIndex += 1
                                    if self.regionIndex == AppConstants.txtArray.count {
                                        self.regionIndex = 0
                                        self.contentURLIndex += 1
                                    }
                                    self.downloadContent()
                        }
                        catch{
                            print(error)
                        }
                    }
                }, andFailure: { error, url, requestString in
                    DispatchQueue.main.async {
                         self.showAlertOK(title: "Error", message: error.localizedDescription)
                    }
                }, andCommonUI:nil)
                
                let completeContentURL =  contentURL + txt
                networkSession.setUpGetRequest(urlString: completeContentURL)
                
            
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ActivityIndicatorViewController {
            destination.customTextString = LoadingConstants.downloadingData
        }
        else if let destination = segue.destination as? RegionWeatherViewController {
            if let regionString = sender as? String {
                destination.regionString = regionString

            }
        }
    }

}

