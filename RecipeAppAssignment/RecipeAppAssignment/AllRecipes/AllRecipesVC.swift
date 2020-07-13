import UIKit

class AllRecipesVC: UIViewController {
    var allRecipesVM: AllRecipesVM?
    var allRecipesView: AllRecipesView?
    var recipes: [RecipeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All Recipes"
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.31, green: 0.69, blue: 0.56, alpha: 1.00).cgColor, UIColor(red: 0.45, green: 0.76, blue: 0.40, alpha: 1.00).cgColor, UIColor(red: 0.67, green: 0.87, blue: 0.46, alpha: 1.00).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        loadRecipes()
        
        let allRecipesVM = AllRecipesVM(recipes: recipes)
        self.allRecipesVM = allRecipesVM
        
        let allRecipesView = AllRecipesView()
        allRecipesVM.configure(allRecipesView)
        view.addSubview(allRecipesView)
        self.allRecipesView = allRecipesView
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addNewRecipe))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        //MARK: - Layout
        allRecipesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        allRecipesView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        allRecipesView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        allRecipesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func addNewRecipe() {
        let addRecipeVC = AddRecipeVC()
        addRecipeVC.onRecipeSaved = { newRecipe in
            self.allRecipesView?.addNewRecipe(newRecipe)
//            self.allRecipesView?.allRecipes.append(newRecipe)
            
            self.saveRecipes(self.allRecipesView!.allRecipes)
            
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(addRecipeVC, animated: false)
    }
    
    func saveRecipes(_ recipes: [RecipeModel]) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(recipes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "recipes")
        } else {
            print("Failed to save recipes.")
        }
    }
    
    
    func loadRecipes() {
        let defaults = UserDefaults.standard
        
        if let savedRecipes = defaults.object(forKey: "recipes") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                recipes = try jsonDecoder.decode([RecipeModel].self, from: savedRecipes)
            } catch {
                print("Failed to load recipes")
            }
        }
    }
}
