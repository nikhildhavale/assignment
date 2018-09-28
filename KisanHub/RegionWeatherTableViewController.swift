//
//  RegionWeatherTableViewController.swift
//  KisanHub
//
//  Created by Nikhil Modi on 9/28/18.
//  Copyright © 2018 Nikhil Modi. All rights reserved.
//

import UIKit
import CoreData
class RegionWeatherTableViewController: UITableViewController {
    var fetchResultController:NSFetchedResultsController<WeatherItem>?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: MainStoryBoardConstants.regionCellIdentifier)
        self.tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
  //      if fetchResultController != nil {
            let filterText =  UserDefaults.standard.object(forKey: AppConstants.filter) as? String
            reloadData(filter: filterText)
 //       }

        

    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController?.sections?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchResultController?.sections?[section].name
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchResultController?.sections?[section].numberOfObjects ?? 0
    }
    func reloadData(filter:String?){
        do {
            if let parent = self.parent as? RegionWeatherViewController {
                if let region = parent.regionString {
                    
                    fetchResultController = CoreDataModel.shared.getFetchRequestController(region: region,filter: filter)
                   try fetchResultController?.performFetch()
                    tableView.reloadData()
                }
            }
        }
        catch {
            
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainStoryBoardConstants.regionCellIdentifier, for: indexPath) as! TitleTableViewCell
        if let weatherItem = fetchResultController?.object(at: indexPath) {
            cell.titleLabel.text = "\(weatherItem)"
        }
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
