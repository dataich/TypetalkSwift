//
//  PostFavoriteTopic.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostFavoriteTopic: Request {
  public let topicId: Int
  
  public typealias Response = PostFavoriteTopicResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/favorite"
  }

// sourcery:inline:auto:PostFavoriteTopic.AutoInit
  public init(topicId: Int) {
    self.topicId = topicId
  }
// sourcery:end
}

public typealias PostFavoriteTopicResponse = TopicWithFavorite
