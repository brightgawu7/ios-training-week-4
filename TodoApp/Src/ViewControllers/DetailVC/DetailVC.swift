import UIKit

/**
 A view controller that displays the details of a selected todo item.

 This class presents the title of the todo and a randomly selected image.
 It also provides functionality to share the todo item via the `UIActivityViewController`.
 */
class DetailVC: UIViewController {
  /// The storyboard identifier for this view controller.
  static let storyboardId = "detailVC"

  /// An array of image names to display in the image view.
  let images = [
    "nssl0033",
    "nssl0034",
    "nssl0041",
    "nssl0042",
    "nssl0043",
    "nssl0045",
    "nssl0046",
    "nssl0049",
    "nssl0051",
    "nssl0091",
  ]

  /// The todo item to be displayed in the detail view.
  var todo: Todo?

  /// The image view that displays a randomly selected image.
  @IBOutlet var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Hide the large title for this view controller
    navigationItem.largeTitleDisplayMode = .never

    // Set a random image from the images array
    imageView.image = UIImage(named: images.randomElement() ?? "nssl0033")

    // Add a share button to the navigation bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .action,
      target: self,
      action: #selector(shareTodo)
    )
  }

  /**
   Configures the view controller with the provided todo item.

   - Parameter todo: The `Todo` object to be displayed.
   */
  func set(todo: Todo) {
    self.todo = todo
    title = todo.title
  }

  /**
   Presents a share sheet to allow the user to share the todo item.

   This method uses `UIActivityViewController` to present a share sheet with the todo's title.
   */
  @objc func shareTodo() {
    guard let text = todo?.title else { return }

    // Create a UIActivityViewController to share the todo title
    let activityController = UIActivityViewController(activityItems: [text], applicationActivities: [])
    activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(activityController, animated: true)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
}
