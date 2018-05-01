//
//  TestViewController.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/30/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    let coordinator = Coordinator.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Trying to read in JSON")
        do {
            if let questions = try coordinator.readQuestionsJSON() {
                print("Questions: ", questions.count)
            }
        } catch let error {
            print(error)
        }
    }

}
