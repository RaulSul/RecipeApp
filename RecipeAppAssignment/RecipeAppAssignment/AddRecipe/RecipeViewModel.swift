import Foundation

class RecipeViewModel {
    var recipeModel: RecipeModel?
    
    init(recipe model: RecipeModel) { self.recipeModel = model }
    
    func configure(_ view: AddRecipeView) {
        view.recipeTitle?.placeholder = recipeModel?.title
        view.contentIDArray.append("addImageCircle")
    }
    
    func collectRecipeData(from view: AddRecipeView) -> RecipeModel {
        if let newTitle = view.recipeTitle?.text { recipeModel?.title = newTitle }
        if let newDescription = view.recipeDescription?.text { recipeModel?.recipeDescription = newDescription }
        
        view.contentIDArray.forEach { if $0 != "addImageCircle" { recipeModel?.images.append($0) } }
        
        let newRecipe = RecipeModel(title: recipeModel!.title, description: recipeModel!.recipeDescription, images: recipeModel!.images)
        if newRecipe.title == "" { newRecipe.title = "My New Recipe" }
        
        return newRecipe
        
    }
    
}
