import AppKit

let size = 1024
let image = NSImage(size: NSSize(width: size, height: size))
image.lockFocus()
guard let context = NSGraphicsContext.current?.cgContext else {
    fatalError("Unable to create icon drawing context")
}
context.setAllowsAntialiasing(true)
context.setShouldAntialias(true)

let rect = CGRect(x: 0, y: 0, width: size, height: size)
let colors = [
    NSColor(calibratedRed: 0.015, green: 0.055, blue: 0.13, alpha: 1).cgColor,
    NSColor(calibratedRed: 0.0, green: 0.36, blue: 0.62, alpha: 1).cgColor
] as CFArray
let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1])!
context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size, y: size), options: [])

let tv = CGRect(x: 150, y: 275, width: 724, height: 475)
let tvPath = NSBezierPath(roundedRect: tv, xRadius: 76, yRadius: 76)
NSColor(calibratedRed: 0.04, green: 0.78, blue: 0.98, alpha: 1).setFill()
tvPath.fill()

let screen = CGRect(x: 198, y: 323, width: 628, height: 379)
NSBezierPath(roundedRect: screen, xRadius: 42, yRadius: 42).fill()
NSColor(calibratedRed: 0.015, green: 0.055, blue: 0.13, alpha: 1).setFill()
NSBezierPath(roundedRect: screen.insetBy(dx: 8, dy: 8), xRadius: 34, yRadius: 34).fill()

// Wireless signal arcs
let center = CGPoint(x: 512, y: 525)
for (radius, width) in [(115.0, 28.0), (205.0, 28.0)] {
    let arc = NSBezierPath()
    arc.lineWidth = width
    arc.lineCapStyle = .round
    arc.appendArc(withCenter: center, radius: radius, startAngle: 48, endAngle: 132, clockwise: false)
    NSColor(calibratedRed: 0.04, green: 0.78, blue: 0.98, alpha: 1).setStroke()
    arc.stroke()
}
NSColor.white.setFill()
NSBezierPath(ovalIn: CGRect(x: 476, y: 489, width: 72, height: 72)).fill()

let stand = NSBezierPath(roundedRect: CGRect(x: 466, y: 205, width: 92, height: 70), xRadius: 18, yRadius: 18)
NSColor(calibratedRed: 0.04, green: 0.78, blue: 0.98, alpha: 1).setFill()
stand.fill()
NSBezierPath(roundedRect: CGRect(x: 350, y: 170, width: 324, height: 42), xRadius: 21, yRadius: 21).fill()

image.unlockFocus()

let output = URL(fileURLWithPath: "Assets.xcassets/AppIcon.appiconset")
try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
guard let tiff = image.tiffRepresentation,
      let bitmap = NSBitmapImageRep(data: tiff),
      let png = bitmap.representation(using: .png, properties: [:]) else {
    fatalError("Unable to encode app icon")
}
try png.write(to: output.appendingPathComponent("AppIcon.png"))
