//
//  ModalErrorCustom.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//
import UIKit

class ModalErrorCustom: UIViewController {
    var msgErrorApi: String = ""

    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        contentView.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
        configView()
        setupAction()
        self.errorMessage.text = msgErrorApi
    }
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageModal: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "imageModalError")
        return image
    }()
    
    private let errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "System", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    @objc private let cancelButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entendi", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: K.Colors.redError)
        button.layer.cornerRadius = 12
        return button
    }()
    
    func setupErrorMenssage(_ errorMenssage: String?){
        msgErrorApi = errorMenssage ?? ""
    }
    
    func configView() {
        self.view.backgroundColor = .clear
        self.backgroundView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backgroundView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 12
    }
    
    func showAlert(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.4, delay: 0.1) {
            self.backgroundView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func dismissAlert() {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut) {
            self.backgroundView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    func setupAction() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
 
    @objc func cancelButtonTapped() {
        dismissAlert()
    }
    
    func setupHierarchy() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(contentView)
        contentView.addSubview(imageModal)
        contentView.addSubview(errorMessage)
        contentView.addSubview(cancelButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 218),
            
            imageModal.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageModal.heightAnchor.constraint(equalToConstant: 60),
            imageModal.widthAnchor.constraint(equalToConstant: 60),
            imageModal.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            
            errorMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            errorMessage.topAnchor.constraint(equalTo: imageModal.bottomAnchor, constant: 12),
            errorMessage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            errorMessage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            cancelButton.topAnchor.constraint(equalTo: errorMessage.bottomAnchor, constant: 26),
            cancelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 160),
            cancelButton.heightAnchor.constraint(equalToConstant: 38),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34)
        ])
    }
}

