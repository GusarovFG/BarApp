//
//  CalendarViewController.swift
//  BarApp
//
//  Created by Фаддей Гусаров on 14.12.2021.
//

import UIKit

class CalendarViewController: UIViewController {


    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var sharedButton: UIBarButtonItem!

    var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sharedButton.isEnabled = false
        setTextField()
    }
    
    @IBAction func dateButtonPressed(sender: UIButton) {

        if sender.titleLabel?.text == " " {
            sender.setTitle("X", for: .normal)
            if self.view.traitCollection.userInterfaceStyle == .dark {
                sender.tintColor = .white
            }
        } else {
            sender.setTitle(" ", for: .normal)

        }
    }
    @IBAction func sharedAction(_ sender: Any) {
        let sharingScreenshot = self.view.takeScreenshot()
        if self.dateTextField.text?.isEmpty == false {

            let activityController = UIActivityViewController.init(activityItems: [sharingScreenshot], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
            CoreDataManager.shared.save(date: self.dateTextField.text ?? "", screenShot: sharingScreenshot)
        }
    }

    private func setTextField() {

        self.dateTextField.inputView = self.datePicker
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.datePickerMode = .date


        let localeID = Locale.preferredLanguages.first
        self.datePicker.locale = Locale(identifier: localeID!)

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        self.dateTextField.inputAccessoryView = toolBar
    }

    @objc func doneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd.MM.YYYY"


        let localeID = Locale.preferredLanguages.first
        formatter.locale = Locale(identifier: localeID!)

        let formattedDate = formatter.string(from: self.datePicker.date)

        let nextDate = Calendar.current.date(byAdding: .day, value: 6, to: self.datePicker.date)

        let week = formatter.string(from: nextDate! as Date)

        self.dateTextField.text = "\(formattedDate) - \(week)"
        self.sharedButton.isEnabled = true
        self.view.endEditing(true)
    }

}
