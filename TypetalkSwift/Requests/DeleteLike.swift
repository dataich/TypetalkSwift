//
//  DeleteLike.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct DeleteLike: Request {
  public let topicId: Int
  public let postId:Int
  
  public typealias Response = DeleteLikecResponse
  public var method: HTTPMethod {
    return .delete
  }
  public var path: String {
    return "/topics/\(topicId)/posts/\(postId)/like"
  }

// sourcery:inline:auto:DeleteLike.AutoInit
  public init(topicId: Int, postId: Int) {
    self.topicId = topicId
    self.postId = postId
  }
// sourcery:end
}

public struct DeleteLikecResponse: Codable {
  public let like: Like
}
