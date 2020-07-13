import UIKit

class RecipeView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var recipeName: String?
    var recipeDescription: String?
    var imageAddresses: [String] = []
    
    var recipeTitle: UILabel?
    var recipeDescriptionTextView: UITextView?
    
    var layout: UICollectionViewFlowLayout?
    var imageCollection: UICollectionView?
    
    init(recipeName: String, recipeDescription: String, recipeImages: [String]) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor(red: 0.96, green: 0.85, blue: 0.64, alpha: 1.00)
        layer.cornerRadius = 10
        
        self.recipeName = recipeName
        self.recipeDescription = recipeDescription
        self.imageAddresses = recipeImages
        
        let recipeTitle: UILabel = UILabel()
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        recipeTitle.clipsToBounds = true
        recipeTitle.text = recipeName
        addSubview(recipeTitle)
        self.recipeTitle = recipeTitle
        
        let recipeDescriptionTextView = UITextView()
        recipeDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        recipeDescriptionTextView.clipsToBounds = true
        recipeDescriptionTextView.text = recipeDescription
        recipeDescriptionTextView.backgroundColor = UIColor(red: 0.89, green: 0.70, blue: 0.47, alpha: 1.00)
        recipeDescriptionTextView.isEditable = false
        recipeDescriptionTextView.layer.cornerRadius = 5
        addSubview(recipeDescriptionTextView)
        self.recipeDescriptionTextView = recipeDescriptionTextView
        
        //MARK: - Collection View
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset.top = 5
        layout.sectionInset.bottom = 5
        layout.sectionInset.left = 5
        layout.sectionInset.right = 5
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .horizontal
        self.layout = layout
        
        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.clipsToBounds = true
        imageCollection.backgroundColor = UIColor(red: 0.96, green: 0.85, blue: 0.64, alpha: 1.00)
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(RecipeImageCell.self, forCellWithReuseIdentifier: "imageCell")
        addSubview(imageCollection)
        self.imageCollection = imageCollection
        
        //MARK: - Layout
        recipeTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        recipeTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        recipeTitle.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        recipeTitle.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        imageCollection.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 10).isActive = true
        imageCollection.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        imageCollection.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        imageCollection.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        recipeDescriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        recipeDescriptionTextView.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 20).isActive = true
        recipeDescriptionTextView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        recipeDescriptionTextView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) { return nil }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageAddresses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var content4cell: UIImage?
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! RecipeImageCell
        imageCell.deleteButton?.isHidden = true
        imageCell.backgroundColor = .black
        
        switch imageAddresses[indexPath.item] {
        case "greenCurry", "greenCurry1", "greenCurry2", "lemonQuinoa", "lemonQuinoa1", "lemonQuinoa2", "hairOfTheDog", "hairOfTheDog1", "macNCheese", "macNCheese1", "macNCheese2":
            content4cell =  UIImage(named: imageAddresses[indexPath.item])?.resized(toSide: 200)
        default:
            let path = getDocumentsDirectory().appendingPathComponent(imageAddresses[indexPath.item])
            content4cell = UIImage(contentsOfFile: path.path)?.resized(toSide: 200)
        }
        imageCell.imageView?.image = content4cell
        imageCell.imageView?.contentMode = .scaleAspectFit
        
        return imageCell
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
