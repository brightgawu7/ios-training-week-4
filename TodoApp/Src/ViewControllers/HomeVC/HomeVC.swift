//
//  HomeVC.swift
//  TodoApp
//
//  Created by AMALITECH-PC-105889 on 9/6/24.
//

import UIKit

class HomeVC: UIViewController {
  /// Array that holds the todo items.
  var todos = [Todo]()

  /// Array that holds the image symbols for the todo items.
  var imageSymbols = [String]()

  @IBOutlet var tableView: UITableView!

  /**
   Called after the view has been loaded. Performs initial setup and configuration.
   */
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.prefersLargeTitles = true
    title = String(localized: "Todo List ✅")

    imageSymbols = loadFileContentsAsArray(filename: "symbols", withExtension: "txt")
    if imageSymbols.isEmpty {
      imageSymbols = ["star.fill"]
    }

    let localTodos = loadFileContentsAsArray(filename: "todos", withExtension: "txt")

    for todo in localTodos {
      todos.append(Todo(title: todo, image: imageSymbols.randomElement() ?? "star.fill"))
    }
  }

  /**
   Action triggered when the 'Add' button is tapped. Presents an alert to add a new todo item.

   - Parameter sender: The button that triggered the action. This parameter is not used in this implementation.
   */
  @IBAction func addButtonTapped(_: UIButton) {
    let alertController = UIAlertController(
      title: String(localized: "Add new task"),
      message: String(localized: "Enter task"),
      preferredStyle: .alert
    )

    alertController.addTextField()

    alertController
      .addAction(UIAlertAction(
        title: String(localized: "Add"),
        style: .default
      ) { [weak self, weak alertController] _ in
        guard let answer = alertController?.textFields?[0].text else { return }
        self?.addNewTodo(answer)
      })

    present(alertController, animated: true)
  }

  /**
   Action triggered when the 'Edit' button is tapped. Toggles the editing mode of the table view.

   - Parameter sender: The button that triggered the action. This parameter is not used in this implementation.
   */
  @IBAction func editButtonTapped(_: UIButton) {
    tableView.isEditing = !tableView.isEditing
  }

  /**
   Adds a new todo item to the list.

   - Parameter newTodo: The title of the new todo item to add. This should be a non-empty string.

   If the title is not empty, a new `Todo` item is created with a random image symbol and inserted at
   the beginning of the list. The table view is updated to reflect this change.
   */
  func addNewTodo(_ newTodo: String) {
    if !newTodo.isEmpty {
      todos.insert(Todo(title: newTodo, image: imageSymbols.randomElement() ?? "star.fill"), at: 0)

      let indexPath = IndexPath(row: 0, section: 0)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
}
