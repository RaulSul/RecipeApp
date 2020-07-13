import Foundation
import UIKit

class RecipeImageCell: UICollectionViewCell {
    var imageView: UIImageView?
    var deleteButton: DeleteButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        self.imageView = imageView
        
        let deleteButton = DeleteButton()
        deleteButton.addTarget(self, action: #selector(deletePicture(sender:)), for: .touchUpInside)
        insertSubview(deleteButton, aboveSubview: imageView)
        self.deleteButton = deleteButton
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: -10).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deletePicture(sender: DeleteButton) {
        sender.onDeletePressed?()
    }
}

class DeleteButton: UIButton {
    var onDeletePressed: (() -> Void)?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        setTitle("X", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 0.5 * bounds.size.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
