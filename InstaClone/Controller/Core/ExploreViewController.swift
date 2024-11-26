//
//  ExploreViewController.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 10.11.2024.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()
    
    private var tabbedSearchCollectionView: UICollectionView?
    
    private var collectionView: UICollectionView?
    
    private var models = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar

        configureSearchBar()
        configureExploreCollection()
        fetchNotifications()
        configureDimmedView()
        configureTabbedSearch()
        
        }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }
    
    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width/3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else { return }
        view.addSubview(tabbedSearchCollectionView)
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        tabbedSearchCollectionView.backgroundColor = .yellow
    }
    
    private func configureDimmedView() {
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dimmedView.addGestureRecognizer(gesture)

    }
    
    private func configureSearchBar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func configureExploreCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func query(_ text: String){
        // Perform search
    }
    
    @objc private func didCancelSearch() {
        searchBar.resignFirstResponder()
        
        navigationItem.rightBarButtonItem = nil
        tabbedSearchCollectionView?.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.dimmedView.alpha = 0
            }
        }) { done in
            if done {
                self.dimmedView.isHidden = false
            }
        }
    }
    
    
    
    private func fetchNotifications() {
        
        for x in 0...100 {
            let user = User(username: "@joe", name: (first: "Joe", last: "Smith"), bio: "The name is joe", birthDate: Date(), profilePhoto: URL(string: "https://www.google.com")!, gender: .male, counts: UserCount(followers: 10, following: 10, posts: 2), joinDate: Date())
            let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: "", likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
            //let model = UserNotification(type: x%2 == 0 ? .like(post: post) : .follow(state: .notFollowing), text: "Hello World", user: user )
            models.append(post)
        }
        
    
    }
    

}

extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == tabbedSearchCollectionView{
            //change search context
            return
        }
        
        let vc = PostViewController(model: models[indexPath.row])
        vc.title = models[indexPath.row].postType.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ExploreViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
        
        dimmedView.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.dimmedView.alpha = 0.4
        }) { done in
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
    }
    
}
