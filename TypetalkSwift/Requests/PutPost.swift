//
//  PutPost.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PutPost: Request {
  public let topicId: Int
  public let postId: Int
  public let message: String
  
  public typealias Response = PutPostResponse
  public var method: HTTPMethod {
    return .put
  }
  public var path: String {
    return "/topics/\(topicId)/posts/\(postId)"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["message"] = self.message
    
    return parameters
  }

// sourcery:inline:auto:PutPost.AutoInit
  public init(topicId: Int, postId: Int, message: String) {
    self.topicId = topicId
    self.postId = postId
    self.message = message
  }
// sourcery:end
}

public struct PutPostResponse: Codable {
  public let topic: TopicTimestamp
  public let post: Post
  public let mentions: [AccountTrait]
  public let directMessage: DirectMessage?
}
