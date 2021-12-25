//
//  CustomTableViewCell.swift
//  Time Visualizer
//
//  Created by Mac on 19/05/1443 AH.
//

import UIKit
import CoreData

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var taskTextField: UITextField!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasksDetails = [EventEntity]()
    
    var titleText: String?
    var indexPath: IndexPath?
    var day:String?
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        guard let task = taskTextField.text else {return}
        guard let hour = hourLabel.text else {return}
        guard let day = day else {return}
        
        
        let thing = NSEntityDescription.insertNewObject(forEntityName: "EventEntity", into: managedObjectContext) as! EventEntity
        
        thing.task = task
        thing.hour = hour
        thing.day = day
        
        print("task \(task)")
        print("hour \(hour)")
        print("day \(day)")
        
        tasksDetails.append(thing)
        
        
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
                
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
}


