import SwiftFigletKit
 
/// Prints a Banner-like message
struct Banner {
    static func print(message: String) {
        if let font = SFKFont.from(file: "fonts/banner.flf") {
            SwiftFigletKit.print(string: message, usingFont: font)
        }
    }
}
