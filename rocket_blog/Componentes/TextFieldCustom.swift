//
//  TextFieldCustom.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//
import UIKit

class TextFieldCustom: UIView {
    
    var image: UIImage? {
        get {
            return self.imageTextField.image
        }
        set {
            return self.imageTextField.image = newValue
        }
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let parentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 7
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private let textFieldBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 13
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private let imageBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let imageTextField: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    public let userTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: K.Fonts.montserratSemiBold, size: 12)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    public let errorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    public let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.montserratSemiBold, size: 13)
        label.textAlignment = .left
        label.textColor = UIColor(named: K.Colors.redError)
        return label
    }()
    
    func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(parentStackView)
        addSubview(parentStackView)
        parentStackView.addArrangedSubview(textFieldBackground)
        textFieldBackground.addSubview(secondStackView)
        
        secondStackView.addArrangedSubview(imageBG)
        imageBG.addSubview(imageTextField)
        secondStackView.addArrangedSubview(userTextField)
        
        parentStackView.addArrangedSubview(errorView)
        errorView.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            parentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            secondStackView.topAnchor.constraint(equalTo: textFieldBackground.topAnchor, constant: 5),
            secondStackView.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: 5),
            secondStackView.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -5),
            secondStackView.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -5),
            
            imageBG.heightAnchor.constraint(equalToConstant: 42),
            imageBG.widthAnchor.constraint(equalToConstant: 42),
            
            imageTextField.centerXAnchor.constraint(equalTo: imageBG.centerXAnchor),
            imageTextField.centerYAnchor.constraint(equalTo: imageBG.centerYAnchor),
            imageTextField.heightAnchor.constraint(equalToConstant: 20),
            imageTextField.widthAnchor.constraint(equalToConstant: 20),
    
            errorLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16),
            errorLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: errorView.topAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: errorView.bottomAnchor),
            
        ])
    }
    
    var isWarning: Bool = false {
        didSet{
            if isWarning {
                textFieldBackground.layer.borderColor = UIColor(named: K.Colors.mediumGray)?.cgColor
            } else {
                imageBG.backgroundColor = UIColor(named: K.Colors.redError)
                textFieldBackground.layer.borderColor = UIColor(named: K.Colors.redError)?.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewCustom()
        setupHierarchy()
        setupConstraints()
        setupTextField(.secondary)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadViewCustom() {
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func hidePassword() {
        userTextField.textContentType = .oneTimeCode
        userTextField.isSecureTextEntry = true
    }
    
    func setupTextField(_ colorType: ColorType) {
        switch colorType {
        case .primary:
            imageBG.backgroundColor = UIColor(named: K.Colors.pinkJessie)
            isWarning = true
        case .secondary:
            imageBG.backgroundColor = UIColor(named: K.Colors.blueJames)
            isWarning = true
        case .textFieldErrorStatus:
            isWarning = false
        }
        textFieldBackground.layer.cornerRadius = K.DefaultValues.cornerRadius
        textFieldBackground.layer.masksToBounds = true
        textFieldBackground.layer.borderWidth = K.DefaultValues.borderWidth
        imageBG.clipsToBounds = true
    }
}

enum ColorType {
    case primary
    case secondary
    case textFieldErrorStatus
}

