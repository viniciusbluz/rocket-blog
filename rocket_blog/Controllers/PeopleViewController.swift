//
//  PeopleViewController.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class PeopleViewController: UIViewController {
    let loadingView = LoadingView()
    var peopleCards: PeopleCardsResponse?
    
    private let peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleCollectionView.frame = view.bounds
        setupForYouCollection()
        getApiCallPeopleCards()
    }
    
    func setupForYouCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.backgroundColor = .none
        peopleCollectionView.setCollectionViewLayout(layout, animated: false)
        peopleCollectionView.register(PeopleCollectionViewCell.self, forCellWithReuseIdentifier: PeopleCollectionViewCell.identifier)
        peopleCollectionView.frame.size.height = 250.0
        peopleCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(peopleCollectionView)
    }
    
    func showErrorModal(message: String) {
        let modalError = ModalErrorCustom()
        modalError.setupErrorMenssage(message)
        modalError.showAlert(sender: self)
    }
    
    func getApiCallPeopleCards() {
        self.loadingView.showLoadingView(sender: self)
        NetworkingManager.getPeopleCards { peopleCardsReturn, error in
            if error != nil {
                VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.showErrorModal(message: K.MessageError.genericErrorMsg)
                }
            } else {
                if let userDataPost = peopleCardsReturn?.errors?.first?.msg {
                    VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.showErrorModal(message: userDataPost)
                    }
                } else {
                    if let peopleCardsData = peopleCardsReturn{
                        self.peopleCards = peopleCardsData
                        self.peopleCollectionView.reloadData()
                        VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                    }
                }
            }
        }
    }
}

extension PeopleViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleCards?.data.users.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCollectionViewCell.identifier, for: indexPath) as? PeopleCollectionViewCell else {return UICollectionViewCell()}
        guard let peopleCardData = peopleCards else {return cell}
        cell.configCell(peopleCards: peopleCardData, index: indexPath.row)
        cell.setupShadowCell(cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 215)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
}

