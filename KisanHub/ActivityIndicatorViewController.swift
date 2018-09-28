//
//  ActivityIndicatorViewController.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/26/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
    var customTextString  = "" {
        didSet{
            self.customText?.text = customTextString
        }
    }
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var customText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        customText.text = customTextString
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.superview?.backgroundColor = UIColor.clear
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
