
import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    static let identifier = "PeopleCellIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupViewConstraints()
        showProfileButton.addTarget(self, action: #selector(showProfileButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let contentViewBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(named: K.Colors.grayStrongLight)
        return view
    }()
    
    private var imageViewBG: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = 30
        return avatarImage
    }()
    
    private let authorNameLabel: UILabel = {
        let authorNameLabel = UILabel()
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.numberOfLines = 0
        authorNameLabel.font = UIFont(name: K.Fonts.montserratSemiBold, size: 15)
        authorNameLabel.textAlignment = .center
        authorNameLabel.textColor = .black
        authorNameLabel.accessibilityLabel = ""
        authorNameLabel.accessibilityTraits = .staticText
        authorNameLabel.accessibilityHint = ""
        authorNameLabel.accessibilityValue = ""
        return authorNameLabel
    }()
    
    private let showProfileButton: UIButton = {
        let showProfileButton = UIButton()
        showProfileButton.translatesAutoresizingMaskIntoConstraints = false
        showProfileButton.layer.cornerRadius = 12.0
        showProfileButton.tintColor = .white
        showProfileButton.titleLabel?.font = UIFont(name: K.Fonts.montserratBold, size: K.DefaultValues.fontSize)
        showProfileButton.backgroundColor = UIColor(named: K.Colors.pinkJessie)
        showProfileButton.setTitle("Ver Perfil", for: .normal)
        return showProfileButton
    }()
    
    @objc func showProfileButtonTapped() {
       print("Button tapped")
    }

    func configCell(peopleCards: PeopleCardsResponse, index: Int) {
        authorNameLabel.text = "\(self.formatAuthorName(peopleCards, index))"
        
        if let bgImage = peopleCards.data.users[index].background?.imageFromBase64 {
            imageViewBG.image = bgImage
        } else {
            imageViewBG.image = UIImage(named: K.DefaultValues.defaultBackgroundInCollection)
        }
        if let avatar = peopleCards.data.users[index].avatar?.imageFromBase64 {
            avatarImage.image = avatar
        } else {
            avatarImage.image = UIImage(systemName: K.DefaultValues.defaultAvatarInCollection)
        }
    }
    
    func formatAuthorName(_ peopleCards: PeopleCardsResponse, _ index: Int) -> String {
        if let fullName = peopleCards.data.users[index].name {
            let userNameSplited = fullName.components(separatedBy: " ")
            guard let firstName = userNameSplited.first else {return ""}
            guard let lastName = userNameSplited.last else {return ""}
            let formatedName = "\(firstName) \(lastName)"
            return formatedName
        }
        return ""
    }
    
    func setupShadowCell(cell: PeopleCollectionViewCell) {
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.16
        cell.layer.masksToBounds = false
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(contentViewBG)
        contentViewBG.addSubview(imageViewBG)
        contentViewBG.addSubview(avatarImage)
        contentViewBG.addSubview(authorNameLabel)
        contentViewBG.addSubview(showProfileButton)
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            contentViewBG.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentViewBG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentViewBG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentViewBG.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentViewBG.widthAnchor.constraint(equalToConstant: 140.0),
            
            imageViewBG.topAnchor.constraint(equalTo: contentViewBG.topAnchor),
            imageViewBG.leadingAnchor.constraint(equalTo: contentViewBG.leadingAnchor),
            imageViewBG.trailingAnchor.constraint(equalTo: contentViewBG.trailingAnchor),
            imageViewBG.heightAnchor.constraint(equalToConstant: 78),
            
            avatarImage.topAnchor.constraint(equalTo: contentViewBG.topAnchor, constant: 49),
            avatarImage.leadingAnchor.constraint(equalTo: contentViewBG.leadingAnchor, constant: 41),
            avatarImage.trailingAnchor.constraint(equalTo: contentViewBG.trailingAnchor, constant: -41),
            avatarImage.heightAnchor.constraint(equalToConstant: 58),
            avatarImage.widthAnchor.constraint(equalToConstant: 58),
            
            authorNameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            authorNameLabel.leadingAnchor.constraint(equalTo: contentViewBG.leadingAnchor, constant: 19),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentViewBG.trailingAnchor, constant: -19),
            authorNameLabel.bottomAnchor.constraint(equalTo: showProfileButton.topAnchor, constant: -7),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            showProfileButton.bottomAnchor.constraint(equalTo: contentViewBG.bottomAnchor, constant: -34),
            showProfileButton.trailingAnchor.constraint(equalTo: contentViewBG.trailingAnchor, constant: -16),
            showProfileButton.leadingAnchor.constraint(equalTo: contentViewBG.leadingAnchor, constant: 16),
            showProfileButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
}

