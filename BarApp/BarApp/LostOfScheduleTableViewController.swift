//
//  LostOfScheduleTableViewController.swift
//  BarApp
//
//  Created by Фаддей Гусаров on 16.12.2021.
//

import UIKit

class LostOfScheduleTableViewController: UITableViewController {

    var schedule: [Schedule]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.schedule = CoreDataManager.shared.fetch()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.schedule?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let schedule = self.schedule?[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "Смены \(schedule?.date ?? "")"
        cell.contentConfiguration = content


        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.schedule?.remove(at: indexPath.row)
            CoreDataManager.shared.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as! DetailViewController
            detailVC.schelude = schedule![indexPath.row]
        }
    }


}
