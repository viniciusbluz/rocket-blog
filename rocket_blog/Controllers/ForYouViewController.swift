//
//  ForYouViewController.swift
//  rocket_blog
//
//  Created by Vinicius da Luz on 30/03/23.
//

import UIKit

class ForYouViewController: UIViewController {
    @IBOutlet weak var forYouCollectionView: UICollectionView!
    let loadingView = LoadingView()
    var featuredPost: FeaturedPostsResponse?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForYouCollection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getApiCallForYouPosts()
    }
    
    func setupForYouCollection() {
        forYouCollectionView.delegate = self
        forYouCollectionView.dataSource = self
        forYouCollectionView.register(UINib(nibName: K.ViewName.forYouXibName, bundle: nil), forCellWithReuseIdentifier: K.ViewName.forYouIdCell)
    }
    
    func showErrorModal(message: String) {
        let modalError = ModalErrorCustom()
        modalError.setupErrorMenssage(message)
        modalError.showAlert(sender: self)
    }
    
     func getApiCallForYouPosts() {
        self.loadingView.showLoadingView(sender: self)
        NetworkingManager.getUsersPosts { userPostsReturn, error in
            if error != nil {
                VerifyRequestEnded.forYouRequest = true
                VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.showErrorModal(message: K.MessageError.genericErrorMsg)
                }
            } else {
                if let userDataPost = userPostsReturn?.errors?.first?.msg {
                    VerifyRequestEnded.forYouRequest = true
                    VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.showErrorModal(message: userDataPost)
                    }
                } else {
                    if let userDataPost = userPostsReturn{
                        self.featuredPost = userDataPost
                        self.forYouCollectionView.reloadData()
                        VerifyRequestEnded.forYouRequest = true
                        VerifyRequestEnded.dismissLoader(loader: self.loadingView)
                    }
                }
            }
        }
    }
}

// MARK: UICollectionViewDelegate
extension ForYouViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailPostScreen = UIStoryboard(name: K.ViewName.detailPostScreen, bundle: nil)
        let detailPostVC = detailPostScreen.instantiateViewController(withIdentifier: K.ViewName.detailPostId)
        self.navigationController?.pushViewController(detailPostVC, animated: true)
    }
}

//MARK: UICollectionViewDataSource
extension ForYouViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredPost?.data?.featuredPosts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ViewName.forYouIdCell, for: indexPath) as? ForYouCollectionCell else {return UICollectionViewCell()}
        guard let featuredData = featuredPost else {return cell}
        cell.setupLayoutCell(featuredPosts: featuredData, index: indexPath.row)
        return cell
    }
}

