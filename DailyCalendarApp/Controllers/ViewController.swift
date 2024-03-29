//
//  ViewController.swift
//  DailyCalendarApp
//
//  Created by Владислав Клепиков on 27.06.2020.
//  Copyright © 2020 Vladislav Klepikov. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var isSelectedDateInfo: UILabel!
    
    var isSelectedDate: Bool = true
    
    var dailies: Results<Daily>!
    var eventsOfSelectedDay: [Daily] = [Daily]()
    var eventsDaily = Array(repeating: Daily(id: 0,
                                             name: "",
                                             descriptionDaily: "",
                                             date_start: 0,
                                             date_finish: 0), count: 24)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailies = realm.objects(Daily.self)
        
        isSelectedDateInfo.isHidden = false
        tableView.isHidden = true

        calendar.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dailyInfo" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dailyInfo = segue.destination as! InfoDailyViewController
                dailyInfo.daily = eventsDaily[indexPath.row]
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func reloadData() {
        calendar.reloadData()
        tableView.reloadData()
    }
}
