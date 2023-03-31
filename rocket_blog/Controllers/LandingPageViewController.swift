//
//  LandingPageViewController.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//
import UIKit

class LandingPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupViewConstraints()
        setupActions()
    }
    
    private let backgroudImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.ProjectImages.backgroundLandingPage)
        return image
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.ProjectImages.ladingPageLogo)
        return image
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private let loginButton: UIButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.styleButton()
        button.backgroundColor = UIColor(named: K.Colors.pinkJessie)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    
    private let registerButton: UIButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.styleButton()
        button.backgroundColor = UIColor(named: K.Colors.blueJames)
        button.setTitle("Inscrever-se", for: .normal)
        return button
    }()
    
    
    func setupViewHierarchy() {
        view.addSubview(backgroudImage)
        view.addSubview(logoImage)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(loginButton)
        buttonsStackView.addArrangedSubview(registerButton)
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            backgroudImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroudImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroudImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroudImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            logoImage.widthAnchor.constraint(equalToConstant: 230),
            logoImage.heightAnchor.constraint(equalToConstant: 250),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 24),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            buttonsStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 45),
            
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            registerButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func loginButtonTapped() {
        let loginScreen = LoginViewController()
        self.navigationController?.pushViewController(loginScreen, animated: true)
    }
    
    @objc func registerButtonTapped() {
        let registerScreen = RegisterViewController()
        self.navigationController?.pushViewController(registerScreen, animated: true)
    }
}

