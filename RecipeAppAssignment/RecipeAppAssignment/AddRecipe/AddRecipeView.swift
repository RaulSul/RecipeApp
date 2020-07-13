import Foundation
import UIKit

class AddRecipeView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    //TextFields:
    var recipeTitle: UITextField?
    var recipeDescription: UITextView?
    
    //Images:
    var imageCollection: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var contentIDArray: [String] = []
    
    //Buttons:
    var addNewPicture:(() -> Void)?
    
    //Miscellanious:
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    var imagesLabel: UILabel?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor(red: 0.96, green: 0.85, blue: 0.64, alpha: 1.00)
        
        let titleLabel: UILabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.clipsToBounds = true
        titleLabel.text = "Title:"
        addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let recipeTitle: UITextField = UITextField()
        recipeTitle.translatesAutoresizingMaskIntoConstraints = false
        recipeTitle.clipsToBounds = true
        recipeTitle.placeholder = "My New Recipe"
        recipeTitle.borderStyle = .bezel
        recipeTitle.backgroundColor = .white
        addSubview(recipeTitle)
        self.recipeTitle = recipeTitle
        
        let descriptionLabel: UILabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.clipsToBounds = true
        descriptionLabel.text = "Description:"
        addSubview(descriptionLabel)
        self.descriptionLabel = descriptionLabel
        
        let recipeDescription: UITextView = UITextView()
        recipeDescription.translatesAutoresizingMaskIntoConstraints = false
        recipeDescription.clipsToBounds = true
        recipeDescription.layer.borderWidth = 1
        recipeDescription.isEditable = true
        addSubview(recipeDescription)
        self.recipeDescription = recipeDescription
        
        let imagesLabel: UILabel = UILabel()
        imagesLabel.translatesAutoresizingMaskIntoConstraints = false
        imagesLabel.clipsToBounds = true
        imagesLabel.text = "Images:"
        addSubview(imagesLabel)
        self.imagesLabel = imagesLabel
        
        //MARK: - Collection View
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset.top = 15
        layout.sectionInset.bottom = 15
        layout.sectionInset.left = 15
        layout.sectionInset.right = 15
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .horizontal
        self.layout = layout
        
        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.clipsToBounds = true
        imageCollection.backgroundColor = UIColor(red: 0.96, green: 0.85, blue: 0.64, alpha: 1.00)
        imageCollection.showsHorizontalScrollIndicator = false
        imageCollection.showsHorizontalScrollIndicator = true
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(RecipeImageCell.self, forCellWithReuseIdentifier: "imageCell")
        addSubview(imageCollection)
        self.imageCollection = imageCollection
        
        //MARK: - Layout
        titleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        
        recipeTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        recipeTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        recipeTitle.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        recipeTitle.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        
        descriptionLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        
        recipeDescription.heightAnchor.constraint(equalToConstant: 100).isActive = true
        recipeDescription.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        recipeDescription.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        recipeDescription.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        
        imagesLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imagesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imagesLabel.topAnchor.constraint(equalTo: recipeDescription.bottomAnchor, constant: 30).isActive = true
        imagesLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        
        imageCollection.topAnchor.constraint(equalTo: imagesLabel.bottomAnchor, constant: 10).isActive = true
        imageCollection.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        imageCollection.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        imageCollection.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
    }
    required init?(coder: NSCoder) { return nil }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentIDArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var image4cell: UIImage?
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! RecipeImageCell
        imageCell.backgroundColor = .white
        
        switch contentIDArray[indexPath.item] {
        case "addImageCircle":
            image4cell = UIImage(named: "addImageCircle")?.resized(toSide: 100)
            imageCell.imageView?.contentMode = .center
            imageCell.deleteButton?.isHidden = true
        default:
            let path = getDocumentsDirectory().appendingPathComponent(contentIDArray[indexPath.item])
            image4cell = UIImage(contentsOfFile: path.path)?.resized(toSide: 200)
            imageCell.deleteButton?.isHidden = false
        }
        
        imageCell.imageView?.image = image4cell
        imageCell.contentView.contentMode = .scaleAspectFit
        
        imageCell.deleteButton?.onDeletePressed = {
            self.contentIDArray.remove(at: indexPath.item)
            collectionView.reloadData()
        }
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if contentIDArray[indexPath.item] == "addImageCircle" { addNewPicture?() }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
