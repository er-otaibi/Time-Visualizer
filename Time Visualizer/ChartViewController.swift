//
//  ChartViewController.swift
//  Time Visualizer
//
//  Created by Mac on 19/05/1443 AH.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    @IBOutlet weak var chartView: UIView!
    
    var events = [Event]()
    var tasks = [String]()
    var numberOfApperence = [Double]()
    let pieChartView = PieChartView(frame: .zero)
    var tasksDetails : [EventEntity]?
    let colors: [UIColor] = [
        .systemPurple , .systemBlue, .systemGreen,
        .systemTeal, .systemRed, .gray
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        guard var tasksDetails = tasksDetails else {return }
        ////        print(tasksDetails.count)
        //
        //        for i in 0..<tasksDetails.count - 1 {
        //            print(i)
        //            guard let task = tasksDetails[i].task else {return }
        //
        //            if task.isEmpty{
        //                tasksDetails.remove(at: i)
        //            }
        //        }
        
        grabTasksToAnalyzeData()
        makePieChart()
    }
    
    
    
    func makePieChart(){
        let dataPoints = tasks
        let values = numberOfApperence
        pieChartView.frame = self.chartView.frame
        pieChartView.isHidden = false
        view.addSubview(pieChartView)
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = self.colors
        pieChartDataSet.entryLabelColor = .black
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
    }
    
    
    
    func grabTasksToAnalyzeData() {
        
        guard let tasksDetails = tasksDetails else {return }
        
        for i in tasksDetails{
            tasks.append(i.task!)
        }
        
        let countedSet = NSCountedSet(array: tasks)
        // 3
        for value in countedSet {
            print("Element:", value, "count:", countedSet.count(for: value))
            events.append(Event(task: value as! String,count: Double(countedSet.count(for: value))))
        }
        tasks.removeAll()
        
        for task in events {
            tasks.append(task.task)
        }
        
        
        
        for eventCount in events{
            numberOfApperence.append(eventCount.count)
        }
        print("counts: \(numberOfApperence)")

    }

    
}

struct Event {
    var task : String
    var count : Double = 1
}
