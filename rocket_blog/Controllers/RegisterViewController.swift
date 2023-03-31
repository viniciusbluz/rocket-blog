//
//  RegisterViewController.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class RegisterViewController: UIViewController {
    var loadingView = LoadingView()
    var isExpand: Bool = false
    var accountManager = NetworkingManager()
    var userTextValidate = UserTextValidate(name: false, email: false, password: false, confirmPassword: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGeneralLayout()
        view.backgroundColor = .white
    }
    
    func setupGeneralLayout() {
        setupViewHierarchy()
        setupConstraints()
        setupActions()
        setupNavigationController()
        textFieldCollectionInDelegate()
        registerButton.disableButton()
        notificationObserverForKeyboard()
        hideKeyboardViewTapped()
    }
    
    func notificationObserverForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardApear() {
        if !isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 210)
            isExpand = true
        }
    }
    
    @objc private func keyboardDisapear() {
        if isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 210)
            isExpand = false
        }
    }
    
    func hideKeyboardViewTapped() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
    }
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.isDirectionalLockEnabled = true
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let registerLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: K.ProjectImages.logoRegister)
        return image
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: K.Fonts.montserratBold, size: 30)
        label.text = K.GeneralMessages.subscribeMessage
        return label
    }()
    
    private let stackViewTextFields: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()
   
    private let nameTextField: TextFieldCustom = {
        let tf = TextFieldCustom()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.userTextField.textContentType = .name
        tf.userTextField.placeholder = K.Placeholders.name
        tf.image = UIImage(systemName: K.ProjectImages.personImage)
        tf.tintColor = UIColor.white
        return tf
    }()
    
    private let emailTextField: TextFieldCustom = {
        let tf = TextFieldCustom()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.userTextField.textContentType = .emailAddress
        tf.userTextField.placeholder = K.Placeholders.email
        tf.image = UIImage(named: K.ProjectImages.envelopImage)
        return tf
    }()

    private let passwordTextField: TextFieldCustom = {
        let tf = TextFieldCustom()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.hidePassword()
        tf.userTextField.placeholder = K.Placeholders.password
        tf.image = UIImage(named: K.ProjectImages.padlockImage)
        return tf
    }()

    private let confirmPasswordTextField: TextFieldCustom = {
        let tf = TextFieldCustom()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.hidePassword()
        tf.userTextField.placeholder = K.Placeholders.confirmPassword
        tf.image = UIImage(named: K.ProjectImages.padlockImage)
        return tf
    }()
    
    private let registerButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.styleButton()
        button.setTitle(K.GeneralMessages.subscribeMessage, for: .normal)
        return button
    }()
    
    private let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.GeneralMessages.isAlreadyRegsiter
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: K.Colors.pinkJessie)
        button.setTitle(K.GeneralMessages.loginTitleButton, for: .normal)
        return button
    }()
    
    private func setupViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(registerLogo)
        contentView.addSubview(headerLabel)
        contentView.addSubview(stackViewTextFields)
        stackViewTextFields.addArrangedSubview(nameTextField)
        stackViewTextFields.addArrangedSubview(emailTextField)
        stackViewTextFields.addArrangedSubview(passwordTextField)
        stackViewTextFields.addArrangedSubview(confirmPasswordTextField)
        contentView.addSubview(registerButton)
        contentView.addSubview(secondStackView)
        secondStackView.addArrangedSubview(footerLabel)
        secondStackView.addArrangedSubview(loginButton)
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            registerLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            registerLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            registerLogo.heightAnchor.constraint(equalToConstant: 135),
            registerLogo.widthAnchor.constraint(equalToConstant: 126),
            
            headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: registerLogo.bottomAnchor, constant: 20),
            headerLabel.bottomAnchor.constraint(equalTo: stackViewTextFields.topAnchor, constant: -20),
            
            stackViewTextFields.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackViewTextFields.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -55),
            stackViewTextFields.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            stackViewTextFields.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            
            nameTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            emailTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            passwordTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            confirmPasswordTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -55),
            registerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            registerButton.bottomAnchor.constraint(equalTo: secondStackView.topAnchor, constant: -50),
            
            secondStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            secondStackView.heightAnchor.constraint(equalToConstant: 44),
            secondStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupNavigationController() {
        let button = UIBarButtonItem(image: UIImage(named: K.ProjectImages.arrowBack), style: .plain,target: self, action: #selector(popController))
        button.tintColor = .black
        navigationItem.leftBarButtonItems = [button]
    }
    
    @objc private func popController() {
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldCollectionInDelegate() {
        nameTextField.userTextField.delegate = self
        emailTextField.userTextField.delegate = self
        passwordTextField.userTextField.delegate = self
        confirmPasswordTextField.userTextField.delegate = self
    }
    
    @objc private func registerButtonTapped() {
        validateUserName()
        validateEmail()
        validatePassword()
        checkSecondPassword()
        
        if userTextValidate.isReadyToRegister() {
            loadingView.showLoadingView(sender: self)
            postApiCallRegisterScreen()
        }
    }
    
    func showErrorModal(message: String) {
        let modalError = ModalErrorCustom()
        modalError.setupErrorMenssage(message)
        modalError.showAlert(sender: self)
    }
    
    func postApiCallRegisterScreen() {
        NetworkingManager.postRegisterScreen(bodyRegister: ["name": nameTextField.userTextField.text!,
                                                            "email": emailTextField.userTextField.text!,
                                                            "password": passwordTextField.userTextField.text!,
                                                            "confirmPassword" : confirmPasswordTextField.userTextField.text!])
        { registerReturn, error in
            
            if error != nil {
                self.loadingView.dismissLoadingView()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showErrorModal(message: K.MessageError.genericErrorMsg)
                }
            } else {
                if let msg = registerReturn?.errors?.first?.msg {
                    self.loadingView.dismissLoadingView()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showErrorModal(message: msg)
                    }
                } else {
                    self.loadingView.dismissLoadingView()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func validateUserName() {
        if let name = nameTextField.userTextField.text {
            
            if let errorMessage = ValidateTextFields.invalidName(userName: name) {
                userTextValidate.name = false
                nameTextField.errorLabel.text = errorMessage
                nameTextField.errorView.isHidden = false
                nameTextField.setupTextField(.textFieldErrorStatus)
            } else {
                userTextValidate.name = true
                nameTextField.errorView.isHidden = true
                nameTextField.setupTextField(.secondary)
            }
        }
    }
    
    func validateEmail() {
        if let email = emailTextField.userTextField.text {
            
            if let errorMessage = ValidateTextFields.invalidEmail(userEmail: email) {
                userTextValidate.email = false
                emailTextField.errorLabel.text = errorMessage
                emailTextField.errorView.isHidden = false
                emailTextField.setupTextField(.textFieldErrorStatus)
            } else {
                userTextValidate.email = true
                emailTextField.errorView.isHidden = true
                emailTextField.setupTextField(.secondary)
            }
        }
    }
    
    func validatePassword() {
        if let password = passwordTextField.userTextField.text {
            
            if let errorMessage = ValidateTextFields.invalidPassword(userPassword: password) {
                userTextValidate.password = false
                passwordTextField.errorLabel.text = errorMessage
                passwordTextField.errorView.isHidden = false
                passwordTextField.setupTextField(.textFieldErrorStatus)
            } else {
                userTextValidate.password = true
                passwordTextField.errorView.isHidden = true
                passwordTextField.setupTextField(.secondary)
            }
        }
    }
    
    func checkSecondPassword() {
        if let password = confirmPasswordTextField.userTextField.text {
            
            if let errorMessage = checkIfIsEqual(userPassword: password) {
                userTextValidate.confirmPassword = false
                confirmPasswordTextField.errorLabel.text = errorMessage
                confirmPasswordTextField.errorView.isHidden = false
                confirmPasswordTextField.setupTextField(.textFieldErrorStatus)
            } else {
                userTextValidate.confirmPassword = true
                confirmPasswordTextField.errorView.isHidden = true
                confirmPasswordTextField.setupTextField(.secondary)
            }
        }
    }
    
    func checkIfIsEqual(userPassword: String) -> String? {
        let passwordText = passwordTextField.userTextField.text
        let confirmPasswordText = confirmPasswordTextField.userTextField.text

        if passwordText != confirmPasswordText {
            return K.MessageError.confirmPasswordError
        }
        return nil
    }
    
    func shouldValidateReturnRegisterButton() {
        let textFieldsList: [TextFieldCustom] = [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
        for field in textFieldsList {
            if let userField = field.userTextField.text {
                if !userField.isEmpty {
                    registerButton.enableButton(K.Colors.blueJames)
                } else {
                    registerButton.disableButton()
                }
            }
        }
    }
}

//MARK: UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        shouldValidateReturnRegisterButton()
        return true
    }
}
