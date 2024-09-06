struct Todo {
  let title: String
  let image: String
  let isComplete: Bool

  init(title: String, image: String, isComplete: Bool = false) {
    self.title = title
    self.isComplete = isComplete
    self.image = image
  }

  func completeToggled() -> Todo {
    Todo(title: title, image: image, isComplete: !isComplete)
  }
}
