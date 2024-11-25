//
//  ViewController.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 10.11.2024.
//

import FirebaseAuth
import UIKit

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        table.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        table.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        table.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return table
    }()
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createMockModels()
    }
    
    private func createMockModels() {
        let user = User(username: "@joe", name: (first: "Joe", last: "Smith"), bio: "The name is joe", birthDate: Date(), profilePhoto: URL(string: "https://www.google.com")!, gender: .male, counts: UserCount(followers: 10, following: 10, posts: 2), joinDate: Date())
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: "", likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)", username: user.username, text: "This is the best post I've ever seen.", createdDate: Date(), likes: []))
        }
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(
                header: PostRenderViewModel(renderType: .header(provider: user)),
                post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                actions: PostRenderViewModel(renderType: .actions(provider: "Like, Comment, Share")),
                comments: PostRenderViewModel(renderType: .comments(comments: comments))
            )
            feedRenderModels.append(viewModel)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func handleNotAuthenticated() {
        //Check auth status
        if Auth.auth().currentUser == nil {
            // Show log in controller
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            
        }
    }

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? (x/4) : ((x-(x%4))/4)
            model = feedRenderModels[position]
        }
        
        let subSection = x%4
        if subSection == 0 {
            //header
            return 1
        } else if subSection == 1 {
            // post
            return 1
        } else if subSection == 2 {
            //actions
            return 1
        } else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            @unknown default:
                fatalError("Invalid Case")
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? (x/4) : ((x-(x%4))/4)
            model = feedRenderModels[position]
        }
        
        let subSection = x%4
        if subSection == 0 {
            //header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.delegate = self
                cell.configure(with: user)
                return cell
            @unknown default:
                fatalError("Invalid")
            }
        } else if subSection == 1 {
            // post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            @unknown default:
                fatalError("Invalid")
            }
        } else if subSection == 2 {
            //actions
            let actionsModel = model.actions
            switch actionsModel.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            @unknown default:
                fatalError("Invalid")
            }
        } else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            @unknown default:
                fatalError("Invalid")
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section%4
        
        if subSection == 0 {
            //header
            return 70
        } else if subSection == 1 {
            // post
            return tableView.width
        } else if subSection == 2 {
            //actions
            return 60
        } else if subSection == 3 {
            // comments
            return 50
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section%4
        
        return subSection == 3 ? 70 : 0
    }
    
    func reportPost(){
        
    }
}

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        
        present(actionSheet, animated: true)
    }
}

extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
    
    
}
    
