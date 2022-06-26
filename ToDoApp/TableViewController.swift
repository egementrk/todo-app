//
//  TableViewController.swift
//  ToDoApp
//
//  Created by Egemen on 26.06.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tasks = [String]()
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Task", style: .done, target: self, action: #selector(addTask))
        
        tasks = userDefaults.object(forKey: "tasks") as? [String] ?? []
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let title = "Done"
        let action = UIContextualAction(style: .normal, title: title){
            (action, view, completion) in
            
            tableView.beginUpdates()
            self.tasks.remove(at: indexPath.row)
            self.userDefaults.set(self.tasks, forKey: "tasks")
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            completion(true)
        }
        action.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
        
    }

    @objc func addTask(){
        let ac = UIAlertController(title: "Enter Task", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let alertAddButton = UIAlertAction(title: "Add", style: .default){
            [weak self, weak ac] _ in
            guard let task = ac?.textFields?[0].text else { return }
            self?.add(task)
        }
        
        ac.addAction(alertAddButton)
        present(ac, animated: true)
    }
    func add(_ task: String) {
        tasks.append(task)
        tableView.reloadData()
        userDefaults.set(tasks, forKey: "tasks")
    }
}
