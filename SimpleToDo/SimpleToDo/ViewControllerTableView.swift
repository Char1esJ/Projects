//
//  ViewControllerTableView.swift
//  Assignment-N16
//
//  Created by Charles Janjgava on 10/11/25.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return completedTodos.count
        } else {
            return notCompletedTodos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskData", for: indexPath) as? taskData else { return UITableViewCell() }
        
        let todo: ToDo
        if indexPath.section == 0 {
            todo = completedTodos[indexPath.row]
            cell.emptyCheckList.setImage(UIImage(named: "checkMark"), for: .normal)
        } else {
            todo = notCompletedTodos[indexPath.row]
            cell.emptyCheckList.setImage(UIImage(named: "emptyCheckMark"), for: .normal)
        }
        
        cell.taskTitleLabel.text = todo.title
        cell.leftColorView.backgroundColor = todo.viewColor
        cell.dateLabel.text = todo.date
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let todo = completedTodos[indexPath.row]
            completedTodos.remove(at: indexPath.row)
            notCompletedTodos.insert(todo, at: 0)
        } else {
            let todo = notCompletedTodos[indexPath.row]
            notCompletedTodos.remove(at: indexPath.row)
            completedTodos.append(todo)
        }
        updateCounts()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    ViewController()
}
