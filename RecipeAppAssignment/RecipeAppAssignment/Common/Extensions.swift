import Foundation
import UIKit

extension UIImage {
    func resized(toSide size: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size, height: size)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
