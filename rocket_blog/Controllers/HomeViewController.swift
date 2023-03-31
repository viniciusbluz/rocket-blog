//
//  HomeViewController.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var segmentedControlCustom: SegmentedControlCustom!
    @IBOutlet weak var forYouTabView: UIView!
    @IBOutlet weak var peopleTabView: UIView!
    @IBOutlet weak var tabBarButton: UIButton!
    @IBOutlet weak var addNewPostLabel: UILabel!
    
    let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        getApiCallHomeScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupLayout() {
        peopleTabView.isHidden = true
        userAvatar.layer.cornerRadius = userAvatar.layer.bounds.width / 2
        tabBarButton.layer.masksToBounds = true
        tabBarButton.layer.cornerRadius = tabBarButton.layer.bounds.width / 2
        customDesignForSegment()
    }
    
    func customDesignForSegment() {
        self.segmentedControlCustom.frame = CGRect(x: segmentedControlCustom.frame.minX, y: segmentedControlCustom.frame.minY, width: segmentedControlCustom.frame.width, height: 60)
        segmentedControlCustom.highlightSelectedSegment()
    }
    
    @IBAction private func navigationTabTapped(_ sender: SegmentedControlCustom) {
        segmentedControlCustom.underlinePosition()
        if sender.selectedSegmentIndex == 0 {

            forYouTabView.isHidden = false
            peopleTabView.isHidden = true
        } else {
            forYouTabView.isHidden = true
            peopleTabView.isHidden = false
        }
    }
    
    func showErrorModal(message: String) {
        let modalError = ModalErrorCustom()
        modalError.setupErrorMenssage(message)
        modalError.showAlert(sender: self)
    }

    func getApiCallHomeScreen() {
        NetworkingManager.getHomeScreen { userInfoResponse, error in
            if error != nil {
                VerifyRequestEnded.headerRequest = true
                VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.showErrorModal(message: K.MessageError.genericErrorMsg)
                }
            } else {
                if let msg = userInfoResponse?.errors?.first?.msg {
                    VerifyRequestEnded.headerRequest = true
                    VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.showErrorModal(message: msg)
                    }
                } else {
                    VerifyRequestEnded.headerRequest = true
                    VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                    if let userName = userInfoResponse?.data?.name {
                        self.userNameLabel.text = "\(K.GeneralMessages.messageGreeting) \(self.getFirstName(userName))"
                    }
                    if let avatarImage = userInfoResponse?.data?.avatar?.imageFromBase64 {
                        self.userAvatar.image = avatarImage
                    }
                }
            }
        }
    }
    
    func getFirstName(_ fullName: String) -> String {
        let userNameSplited = fullName.components(separatedBy: " ")
        guard let firstName = userNameSplited.first else {return "first name nil"}
        return firstName
    }
}

