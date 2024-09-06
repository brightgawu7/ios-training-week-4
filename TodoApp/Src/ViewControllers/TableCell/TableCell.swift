import UIKit

/**
 A custom `UITableViewCell` subclass that represents a single row in the todo list.

 This class is responsible for displaying the todo item with an icon and a label.
 It also manages the visual appearance of the cell based on the completion status of the todo item.
 */
class TableCell: UITableViewCell {
  /// The reuse identifier for this cell.
  static let identifier = "cell"

  /// A flag indicating whether the todo item is completed.
  var isComplete: Bool = false

  /// The image view displaying the icon for the todo item.
  @IBOutlet var rowIcon: UIImageView!

  /// The label displaying the title of the todo item.
  @IBOutlet var rowLabel: UILabel!

  /**
   Configures the cell with the provided todo item.

   - Parameter todo: The `Todo` object containing the title, image, and completion status.

   This method sets the label text, icon image, and updates the cell's appearance based
   on the todo item's completion status.
   */
  func set(todo: Todo) {
    rowLabel.text = todo.title
    isComplete = todo.isComplete
    rowIcon.image = UIImage(systemName: todo.image)
    updateChecked()
  }

  /**
   Configures the cell's checked state.

   - Parameter checked: A boolean indicating whether the todo item is completed.

   This method updates the visual appearance of the cell based on the checked state.
   */
  func set(checked: Bool) {
    isComplete = checked
    updateChecked()
  }

  /**
   Updates the visual appearance of the cell based on its completion status.

   This method adds or removes a strikethrough style from the label text to indicate whether the todo item is completed.
   */
  private func updateChecked() {
    // Create an attributed string from the label's text
    let attributedString = NSMutableAttributedString(string: rowLabel?.text ?? "")

    // Define the range for the entire text
    let range = NSRange(location: 0, length: attributedString.length)

    // Apply or remove strikethrough based on completion status
    if isComplete {
      attributedString.addAttribute(
        .strikethroughStyle,
        value: 2,
        range: range
      )
    } else {
      attributedString.removeAttribute(.strikethroughStyle, range: range)
    }

    // Update the label's attributed text
    rowLabel.attributedText = attributedString
  }
}
