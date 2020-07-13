import Foundation
import UIKit

class RecipeModel: NSObject, Codable {
    var title: String
    var recipeDescription: String
    var images: [String]
    
    init(title: String = "My New Recipe", description: String = "", images: [String] = []) {
        self.title = title
        self.recipeDescription = description
        self.images = images
    }
}
