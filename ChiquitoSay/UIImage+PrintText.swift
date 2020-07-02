import Foundation
import AppKit

extension NSImage {
    func print(text: String) -> NSImage {
        let image = self
        let font = NSFont.boldSystemFont(ofSize: 30)
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let textRect = CGRect(x: 5, y: 5, width: image.size.width - 5, height: image.size.height - 5)
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let textFontAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: NSColor.white,
            NSAttributedString.Key.paragraphStyle: textStyle
        ]
        let im:NSImage = NSImage(size: image.size)
        let rep:NSBitmapImageRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(image.size.width), pixelsHigh: Int(image.size.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: NSColorSpaceName.calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0)!
        im.addRepresentation(rep)
        im.lockFocus()
        image.draw(in: imageRect)
        text.draw(in: textRect, withAttributes: textFontAttributes)
        im.unlockFocus()
        return im
    }
}

extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
}
extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}
extension NSImage {
    var png: Data? { tiffRepresentation?.bitmap?.png }
}

