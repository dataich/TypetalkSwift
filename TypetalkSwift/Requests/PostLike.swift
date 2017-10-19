//
//  PostLike.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostLike: Request {
  public let topicId: Int
  public let postId:Int
  
  public typealias Response = PostLikeResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/posts/\(postId)/like"
  }

// sourcery:inline:auto:PostLike.AutoInit
  public init(topicId: Int, postId: Int) {
    self.topicId = topicId
    self.postId = postId
  }
// sourcery:end
}

public struct PostLikeResponse: Codable {
  public let like: Like
  public let post: Post
  public let topic: Topic
  public let directMessage: DirectMessage?

  public struct Post: Codable {
    public let id: Int
    public let topicId: Int
    public let replyTo: Int?
    public let message: String
    public let account: AccountTrait
    public let createdAt: Date
    public let updatedAt: Date
  }
}
