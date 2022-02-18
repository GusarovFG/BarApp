//
//  RandomViewController.swift
//  BarApp
//
//  Created by Фаддей Гусаров on 14.12.2021.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet weak var shurricImage: UIImageView!
    var participants: [String] = []
    var bartenders = BartendersList.bartenders

    @IBOutlet weak var participantsTableView: UITableView!
    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.shurricImage.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.shurricImage.frame.origin.x = 500
    }


    @IBAction func randomButtonPressed(_ sender: UIButton) {

        self.winnerLabel.text = self.participants.randomElement()

        if !participants.isEmpty {
            sender.isEnabled = false
        }
        self.shurricImage.isHidden = false
        UIView.animate(withDuration: 1) {
            self.shurricImage.frame.origin.x = 280
        }
    }

    @IBAction func sharedButtonPressed(_ sender: UIBarButtonItem) {

        let sharingScreenshot = self.view.takeScreenshot()

        let activityController = UIActivityViewController.init(activityItems: [sharingScreenshot], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}

extension RandomViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.membersTableView {
            return bartenders.count
        } else {
            return participants.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.membersTableView {
            let scell = tableView.dequeueReusableCell(withIdentifier: "bartenderCell")

            var content = scell?.defaultContentConfiguration()
            content?.text = bartenders[indexPath.row]
            scell?.contentConfiguration = content
            return scell!

        } else {
            let qcell = tableView.dequeueReusableCell(withIdentifier: "participantsCell")

            var content = qcell?.defaultContentConfiguration()
            content?.text = participants[indexPath.row]
            qcell?.contentConfiguration = content
            return qcell!
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.membersTableView {
            self.participants.append(self.bartenders[indexPath.row])
            self.bartenders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.participantsTableView.reloadData()
        } else {
            self.bartenders.append(self.participants[indexPath.row])
            self.participants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.membersTableView.reloadData()
        }
    }


}
