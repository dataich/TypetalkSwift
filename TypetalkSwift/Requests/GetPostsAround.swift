//
//  GetPostsAround.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetPostsAround: Request {
  public let topicId: Int
  public let postId: Int
  
  public typealias Response = GetPostsAroundResponse
  public var path: String {
    return "/topics/\(topicId)/posts/\(postId)/around"
  }

// sourcery:inline:auto:GetPostsAround.AutoInit
  public init(topicId: Int, postId: Int) {
    self.topicId = topicId
    self.postId = postId
  }
// sourcery:end
}

public struct GetPostsAroundResponse: Codable {
  public let mySpace: MySpace?
  public let team: Team?
  public let topic: Topic
  public let directMessage: AccountWithStatus?
  public let posts: [Post]
  public let replies: [Post]
  public let hasPrev: Bool
  public let hasNext: Bool
  public let exceedsAttachmentLimit: Bool
}
