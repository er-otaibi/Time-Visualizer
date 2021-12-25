//
//  CalenderTableViewController.swift
//  Time Visualizer
//
//  Created by Mac on 19/05/1443 AH.
//

import UIKit
import CoreData

class CalenderTableViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasksDetails = [EventEntity]()
    let daysOfWeek:[String] = ["Sun" ,"Mon","Tues", "Wed", "Thurs", "Friday", "Sat"  ]
    
    let hours = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, 21,22,23,24]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItemsCoreData()
        
    }
    
    @IBAction func progressButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "chart", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! ChartViewController
        fetchAllItemsCoreData()
        destination.tasksDetails = tasksDetails
        
        
    }
    
    func fetchAllItemsCoreData(){
        
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EventEntity")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            tasksDetails = results as! [EventEntity]
            
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return daysOfWeek[section]
    }
    
   
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.systemPurple
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
        
        cell.hourLabel.text = "\(hours[indexPath.row])"
        
        for detail in tasksDetails {
            if detail.day ==  daysOfWeek[indexPath.section] && detail.hour == String(hours[indexPath.row]) {
                cell.taskTextField.text = detail.task
                break
            }else{
                cell.taskTextField.text = ""
            }
        }
        
        
        cell.day = daysOfWeek[indexPath.section]
        
        cell.taskTextField.backgroundColor = .purple.withAlphaComponent(0.1)
        
        return cell
    }
}


