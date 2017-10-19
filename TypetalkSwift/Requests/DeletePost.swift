//
//  DeletePost.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct DeletePost: Request {
  public let topicId: Int
  public let postId:Int
  
  public typealias Response = DeletePostResponse
  public var method: HTTPMethod {
    return .delete
  }
  public var path: String {
    return "/topics/\(topicId)/posts/\(postId)"
  }

// sourcery:inline:auto:DeletePost.AutoInit
  public init(topicId: Int, postId: Int) {
    self.topicId = topicId
    self.postId = postId
  }
// sourcery:end
}

public typealias DeletePostResponse = Post
