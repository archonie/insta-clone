//
//  Models.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 19.11.2024.
//

import Foundation


enum Gender {
    case male, female, other
}


struct User {
    let username: String
    let name: (first: String, last: String)
    let bio: String
    let birthDate: Date
    let profilePhoto: URL
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}


///Represents a userpost
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [User]
    let owner: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

