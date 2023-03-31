//
//  LoginViewController.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class LoginViewController: UIViewController {

    let loadingView = LoadingView()
    var accountManager = NetworkingManager()
    var userTextValidate = UserTextValidate(name: false, email: false, password: false, confirmPassword: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewHierarchy()
        setupViewConstraints()
        setupLayout()
        setupNavigationController()
        setupActions()
    }
   
    private let contentView: UIView = {
        let stackView = UIView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: K.ProjectImages.logoRegister)
        return image
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bem vindo!"
        label.font = UIFont(name: K.Fonts.montserratBold, size: 30)
        label.textAlignment = .center
        label.textColor = .black
        label.accessibilityLabel = ""
        label.accessibilityTraits = .staticText
        label.accessibilityHint = ""
        label.accessibilityValue = ""
        return label
    }()
    
    private let createNewAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Criar nova conta?"
        label.font = UIFont(name: K.Fonts.montserratSemiBold, size: 13)
        label.textAlignment = .center
        label.textColor = UIColor(named: K.Colors.strongGray)
        return label
    }()
    
    private let middleStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 14
        return stackview
    }()
    
    private let bottomStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 10
        return stackview
    }()
    
    private let emailTextfield: TextFieldCustom = {
       let textfield = TextFieldCustom()
        textfield.image = UIImage(named: "envelop")
        return textfield
    }()
    
    private let passwordTextfield: TextFieldCustom = {
       let textfield = TextFieldCustom()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.image = UIImage(named: "padlock")
        return textfield
    }()
    
    private let loginButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: K.Colors.pinkJessie)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Inscrever-se", for: .normal)
        button.tintColor = UIColor(named: K.Colors.blueJames)
        button.titleLabel?.font = UIFont(name: K.Fonts.montserratSemiBold, size: 13)
        return button
    }()
    
    func setupViewHierarchy() {
        view.addSubview(contentView)
        contentView.addSubview(backgroundImage)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(middleStackView)
       
        middleStackView.addArrangedSubview(emailTextfield)
        middleStackView.addArrangedSubview(passwordTextfield)
        
        contentView.addSubview(loginButton)
        contentView.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(createNewAccountLabel)
        bottomStackView.addArrangedSubview(registerButton)
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            backgroundImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            backgroundImage.heightAnchor.constraint(equalToConstant: 140),
            backgroundImage.widthAnchor.constraint(equalToConstant: 144),
            
            welcomeLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 40),
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            
            middleStackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            middleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            middleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -55),
            
            emailTextfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            passwordTextfield.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            
            loginButton.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -55),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            
            bottomStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50),
            bottomStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            
            createNewAccountLabel.heightAnchor.constraint(equalToConstant: 25),
            registerButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        validateEmail()
        validatePassword()
        
        if userTextValidate.isReadytoLogin() {
            loadingView.showLoadingView(sender: self)
            postApiCallLoginScreen()
        }
    }
    
    @objc private func registerButtonTapped() {
        let registerScreen = RegisterViewController()
        self.navigationController?.pushViewController(registerScreen, animated: true)
    }
    
    func setupNavigationController() {
        let button = UIBarButtonItem(image: UIImage(named: K.ProjectImages.arrowBack), style: .plain,target: self, action: #selector(popController))
        button.tintColor = .black
        navigationItem.leftBarButtonItems = [button]
    }
    
    @objc func popController() {
        navigationController?.popViewController(animated: true)
    }
    
    func showErrorModal(message: String) {
        let modalError = ModalErrorCustom()
        modalError.setupErrorMenssage(message)
        modalError.showAlert(sender: self)
    }
    
    func postApiCallLoginScreen() {
        NetworkingManager.postLoginScreen(bodyLogin: ["email": emailTextfield.userTextField.text!,
                                                   "password": passwordTextfield.userTextField.text!])
        { loginReturn, error in
            
            if error != nil {
                self.loadingView.dismissLoadingView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showErrorModal(message: K.MessageError.genericErrorMsg)
                }
            } else {
                if let msg = loginReturn?.errors?.first?.msg {
                    self.loadingView.dismissLoadingView()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showErrorModal(message: msg)
                    }
                } else {
                    self.loadingView.dismissLoadingView()
                    guard let token = loginReturn?.data?.accessToken else {return}
                    Auth.shared.accessToken = token
                    self.goToHomePage()
                }
            }
        }
    }
      
    func goToHomePage() {
        let homeScreen = UIStoryboard(name: K.ViewName.homeScreen, bundle: nil)
        let homeVC = homeScreen.instantiateViewController(withIdentifier: K.ViewName.homeScreenId)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
        
    func setupLayout() {
        changeTextFieldLayout()
        loginButton.disableButton()
        setupTextFieldDelegate()
        hidePassword()
        hideKeyboardViewTapped()
    }
    
    func hideKeyboardViewTapped() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
    }
    
    func hidePassword() {
        passwordTextfield.hidePassword()
    }
    
    func setupTextFieldDelegate() {
        emailTextfield.userTextField.delegate = self
        passwordTextfield.userTextField.delegate = self
    }
    
    func changeTextFieldLayout() {
        emailTextfield.setupTextField(.primary)
        passwordTextfield.setupTextField(.primary)
        emailTextfield.userTextField.placeholder = K.Placeholders.email
        passwordTextfield.userTextField.placeholder = K.Placeholders.password
        emailTextfield.userTextField.textContentType = .emailAddress
    }
    
    func validateEmail() {
        if let email = emailTextfield.userTextField.text {
            if let errorMessage = ValidateTextFields.invalidEmail(userEmail: email) {
                userTextValidate.email = false
                emailTextfield.errorLabel.text = errorMessage
                emailTextfield.errorView.isHidden = false
                emailTextfield.setupTextField(.textFieldErrorStatus)
            } else {
                userTextValidate.email = true
                emailTextfield.errorView.isHidden = true
                emailTextfield.setupTextField(.primary)
            }
        }
    }
    
    func validatePassword() {
        if let password = passwordTextfield.userTextField.text {
            if password.count < K.DefaultValues.minimumCharactersPassword {
                userTextValidate.password = false
                passwordTextfield.setupTextField(.primary)
            } else {
                userTextValidate.password = true
                passwordTextfield.setupTextField(.primary)
            }
        }
    }
    
    func shouldValidateReturnLoginButton() {
        if let emailField = emailTextfield.userTextField.text,
            let password = passwordTextfield.userTextField.text {
            if !emailField.isEmpty && password.count >= K.DefaultValues.minimumCharactersPassword {
                loginButton.enableButton(K.Colors.pinkJessie)
            } else {
                loginButton.disableButton()
            }
        }
    }
}

//MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        shouldValidateReturnLoginButton()
        return true
    }
}


