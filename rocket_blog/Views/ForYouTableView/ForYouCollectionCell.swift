//
//  ForYouCollectionCell.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class ForYouCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageCollection: UIImageView!
    @IBOutlet weak var postDescriptionTitle: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setConrnerRadius()
    }
    
    func setupLayoutCell(featuredPosts: FeaturedPostsResponse, index: Int) {
        checkIfImageIsEmpty(featuredPosts,index)
        authorName.text = "\(self.formatAuthorName(featuredPosts, index))"
        postDescriptionTitle.text = featuredPosts.data?.featuredPosts[index].title
    }
    
    func formatAuthorName(_ featuredPosts: FeaturedPostsResponse, _ index: Int) -> String {
        if let fullName = featuredPosts.data?.featuredPosts[index].postedBy.first?.name {
            let userNameSplited = fullName.components(separatedBy: " ")
            guard let firstName = userNameSplited.first else {return ""}
            guard let lastName = userNameSplited.last else {return ""}
            let formatedName = "\(firstName) \(lastName)"
            return formatedName
        }
        return ""
    }
        
    private func checkIfImageIsEmpty(_ featuredPosts: FeaturedPostsResponse, _ index: Int) {
        if let bgImage = featuredPosts.data?.featuredPosts[index].image?.imageFromBase64 {
            imageCollection.image = bgImage
        } else {
            imageCollection.image = UIImage(named: K.DefaultValues.defaultBackgroundInCollection)
        }
        
        if let image = featuredPosts.data?.featuredPosts[index].postedBy.first?.avatar?.imageFromBase64 {
            authorImage.image = image
        } else {
            authorImage.image = UIImage(systemName: K.DefaultValues.defaultAvatarInCollection)
        }
    }
    
    private func setConrnerRadius() {
        imageCollection.layer.cornerRadius = 12
        authorImage.layer.cornerRadius = authorImage.layer.bounds.width / 2
    }
    
}
