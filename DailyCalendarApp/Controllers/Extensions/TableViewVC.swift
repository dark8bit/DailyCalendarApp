//
//  TableViewVC.swift
//  DailyCalendarApp
//
//  Created by Владислав Клепиков on 27.06.2020.
//  Copyright © 2020 Vladislav Klepikov. All rights reserved.
//

import UIKit

// MARK: TableView
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsDaily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DailyTableViewCell
        var daily = Daily(id: 0,
                          name: "",
                          descriptionDaily: "",
                          date_start: 0,
                          date_finish: 0)
        let DH = DateHandler.shared
        
        let dateStart = DH.timeConverter(time: indexPath.row)
        let dateFinish = DH.timeConverter(time: indexPath.row + 1)
        
        eventsOfSelectedDay.forEach({
            if DH.setDate(dailyDate: $0.date_start) == dateStart {
                daily = $0
            }
        })
        
        if !isSelectedDate {
            eventsDaily[indexPath.row] = daily
        }
        
        cell.dailyName.text = daily.name
        cell.dailyDescription.text = daily.descriptionDaily
        cell.dailyDateStart.text = "\(dateStart).00"
        cell.dailyDateFinish.text = "\(dateFinish).00"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if eventsDaily[indexPath.row].name.count > 0 {
            self.performSegue(withIdentifier: "dailyInfo", sender: self)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            showAlert(title: "Внимание", message: "На выбранное вами время - событий нет")
        }
    }
}
