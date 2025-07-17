import SwiftCrossUI

extension Color {
    var cssString: String {
        "rgba(\(Int(red * 255)), \(Int(green * 255)), \(Int(blue * 255)), \(alpha))"
    }
}
