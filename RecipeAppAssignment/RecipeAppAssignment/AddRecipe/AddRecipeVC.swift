import UIKit

class AddRecipeVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var recipeVM: RecipeViewModel?
    
    var addRecipeView: AddRecipeView?
    var imagePicker: UIImagePickerController?
    var onRecipeSaved: ((RecipeModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Recipe"
        
        let recipeModel = RecipeModel()
        let recipeVM = RecipeViewModel(recipe: recipeModel)
        self.recipeVM = recipeVM
        let addRecipeView: AddRecipeView = AddRecipeView()
        
        recipeVM.configure(addRecipeView)
        addRecipeView.addNewPicture = {
            let vc = UIImagePickerController()
            vc.sourceType = .savedPhotosAlbum
            vc.allowsEditing = true
            vc.delegate = self
            self.imagePicker = vc
            self.present(vc, animated: true)
        }
        view.addSubview(addRecipeView)
        self.addRecipeView = addRecipeView
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveRecipe))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        addRecipeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addRecipeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        addRecipeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        addRecipeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func saveRecipe() {
        guard let newRecipe = recipeVM?.collectRecipeData(from: addRecipeView!) else { return }
        onRecipeSaved?(newRecipe)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageID = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageID)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) { try? jpegData.write(to: imagePath) }
        addRecipeView?.contentIDArray.append(imageID)
        addRecipeView?.imageCollection?.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

