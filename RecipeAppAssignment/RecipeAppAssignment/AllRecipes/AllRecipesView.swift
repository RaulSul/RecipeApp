import UIKit

class AllRecipesView: UIScrollView, UIScrollViewDelegate {
    
    var allRecipes: [RecipeModel] = []
    var stackView: UIStackView?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        delegate = self
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 20
        addSubview(stackView)
        self.stackView = stackView
        
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func addNewRecipe(_ recipe: RecipeModel, _ loadingAllRecipes: Bool = false) {
        let newRecipeView = RecipeView(recipeName: recipe.title, recipeDescription: recipe.recipeDescription, recipeImages: recipe.images)
        stackView?.insertArrangedSubview(newRecipeView, at: 0)
        
        newRecipeView.heightAnchor.constraint(equalToConstant: 390).isActive = true
        newRecipeView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        
        if !(loadingAllRecipes) { allRecipes.append(recipe) }
    }
    
    func loadAllRecipes() { allRecipes.forEach { addNewRecipe($0, true) } }
    
    required init?(coder: NSCoder) { return nil }
}
