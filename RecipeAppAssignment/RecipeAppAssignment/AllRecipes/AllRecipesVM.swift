import Foundation

class AllRecipesVM {
    var recipes: [RecipeModel] = []
    
    init(recipes: [RecipeModel]) {
        self.recipes = recipes
    }
    
    func configure(_ view: AllRecipesView) {
        view.allRecipes = recipes
        
        switch recipes.count {
        case 0:
            addDefaultRecipes(to: view)
        default:
            view.loadAllRecipes()
        }
    }
    
    func addDefaultRecipes(to view: AllRecipesView) {
        
        let quinoa = RecipeModel()
        quinoa.title = "Lemon Quinoa with Asparagus Ribbons"
        quinoa.recipeDescription = """
        - 15-oz can chickkpeas
        - Salt
        - Pepper
        - 1 c. quinoa
        """
        quinoa.images += ["lemonQuinoa", "lemonQuinoa1", "lemonQuinoa2"]
        view.addNewRecipe(quinoa)
        
        let greenCurry = RecipeModel()
        greenCurry.title = "Green Chicken Curry"
        greenCurry.recipeDescription = """
        - 500g Chicken
        - 1 Peanut Oil
        - 1 Coconut Milk
        """
        greenCurry.images += ["greenCurry", "greenCurry1", "greenCurry2"]
        view.addNewRecipe(greenCurry)
        
        let hairyDog = RecipeModel()
        hairyDog.title = "Hair of the Dog"
        hairyDog.recipeDescription = """
        - 120 ml Whiskey
        - 60 ml Honey
        - 60 ml Cream
        
        (Perfect for hangovers)
        """
        hairyDog.images += ["hairOfTheDog", "hairOfTheDog1"]
        view.addNewRecipe(hairyDog)
        
        let macNCheese = RecipeModel()
        macNCheese.title = "Max'n'Cheese"
        macNCheese.recipeDescription = """
        - 1 cup Macaroni
        - 1/4 cup Butter
        - 1/4 cup Flower
        - 1/2 tsp Salt
        - 1 pinch Ground Black Pepper
        - 2 cups Milk
        - 2 cups (or blocks...) Shredded Cheddar Cheese
        - More Cheese
        """
        macNCheese.images += ["macNCheese", "macNCheese1", "macNCheese2"]
        view.addNewRecipe(macNCheese)
    }
}
