import UIKit

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    todos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Dequeue a reusable cell, or create a new one if none are available
    let cell = tableView
      .dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell ?? TableCell()

    // Configure the cell with the todo item for the current row
    cell.set(todo: todos[indexPath.row])

    return cell
  }

  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      // Remove the todo item from the data source
      todos.remove(at: indexPath.row)
      // Delete the row from the table view
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Instantiate the detail view controller
    guard let detailVc = storyboard?.instantiateViewController(withIdentifier: DetailVC.storyboardId) as? DetailVC
    else { return }

    // Pass the selected todo item to the detail view controller
    detailVc.set(todo: todos[indexPath.row])
    // Navigate to the detail view controller
    navigationController?.pushViewController(detailVc, animated: true)
  }

  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .delete
  }

  func tableView(
    _ tableView: UITableView,
    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    // Create a swipe action for marking the todo item as complete
    let action = UIContextualAction(style: .normal, title: String(localized: "Complete")) { _, _, complete in

      // Toggle the completion state of the todo item
      let todo = self.todos[indexPath.row].completeToggled()
      self.todos[indexPath.row] = todo

      // Update the cell to reflect the new completion state
      let cell = tableView.cellForRow(at: indexPath) as? TableCell ?? TableCell()
      cell.set(checked: todo.isComplete)

      // Complete the swipe action
      complete(true)
    }

    // Return the configuration with the action
    return UISwipeActionsConfiguration(actions: [action])
  }
}
