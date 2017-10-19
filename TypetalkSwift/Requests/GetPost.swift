//
//  GetPost.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetPost: Request {
  public let topicId: Int
  public let postId: Int
  
  public typealias Response = GetPostResponse
  public var path: String {
    return "/topics/\(topicId)/posts/\(postId)"
  }

// sourcery:inline:auto:GetPost.AutoInit
  public init(topicId: Int, postId: Int) {
    self.topicId = topicId
    self.postId = postId
  }
// sourcery:end
}

public struct GetPostResponse: Codable {
  public let mySpace: MySpace?
  public let team: Team?
  public let topic: Topic
  public let post: Post
  public let replies: [Post]
  public let exceedsAttachmentLimit: Bool
}
