//
//  QuestionsTableViewController.swift
//  Encryptugla
//
//  Created by Mitchell Murphy on 4/29/18.
//  Copyright © 2018 Mitchell Murphy. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController {
    
    var coordinator: Coordinator = Coordinator.shared
    
    var questions: [Question]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //print("Users: ", coordinator.users.count)
        refreshQuestions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // refresh questions
        refreshQuestions()
    }
    
    func refreshQuestions() {
        do {
            if let gotQuestions = try coordinator.readQuestionsJSON() {
                questions = gotQuestions
                tableView.reloadData()
            }
        } catch let error {
            // show an error message
            questions = [Question]()
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)

        // Configure the cell...
        let question = questions[indexPath.row]
        
        if question.title == "" {
            cell.textLabel?.text = "Sorry there are no questions at this time"
        } else {
            cell.textLabel?.text = question.title
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showQuestionDetail" {
            let navigationController = segue.destination as! UINavigationController
            let questionVC = navigationController.viewControllers.first as! QuestionViewController
            // set/pass the question
            if let questionIndex = tableView.indexPathForSelectedRow?.row {
                questionVC.question = questions[questionIndex]
            }
        }
    }

}
