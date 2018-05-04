//
//  QuestionViewController.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/30/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var question: Question?
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let question = question {
            navTitle.title = question.title
            textView.text = question.description
        }
    }
    
    @IBAction func back(_ sender: Any) {
        // dismiss nav
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
