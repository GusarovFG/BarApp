//
//  DetailViewController.swift
//  BarApp
//
//  Created by Фаддей Гусаров on 16.12.2021.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var image: UIImageView!

    var schelude: Schedule?



    override func viewDidLoad() {
        super.viewDidLoad()


        self.image.image = UIImage(data: (self.schelude?.schedule)!)


    }

}
