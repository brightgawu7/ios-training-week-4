import Foundation

func loadFileContentsAsArray(
  filename: String,
  withExtension ext: String,
  separatedBy separator: String = "\n"
) -> [String] {
  if let fileUrl = Bundle.main.url(forResource: filename, withExtension: ext) {
    if let fileContents = try? String(contentsOf: fileUrl) {
      return fileContents.components(separatedBy: separator).filter { !$0.isEmpty }
    }
  }
  return []
}
