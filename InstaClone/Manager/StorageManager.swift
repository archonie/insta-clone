//
//  StorageManager.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 12.11.2024.
//


import FirebaseStorage

public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    
    //MARK: - Public
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>)-> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        }
    }
    
}

public enum UserPostType {
    case photo, video
}


public struct UserPost {
    let postType: UserPostType
}
