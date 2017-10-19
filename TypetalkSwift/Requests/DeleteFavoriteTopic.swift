//
//  DeleteFavoriteTopic.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct DeleteFavoriteTopic: Request {
  public let topicId: Int
  
  public typealias Response = DeleteFavoriteTopicResponse
  public var method: HTTPMethod {
    return .delete
  }
  public var path: String {
    return "/topics/\(topicId)/favorite"
  }

// sourcery:inline:auto:DeleteFavoriteTopic.AutoInit
  public init(topicId: Int) {
    self.topicId = topicId
  }
// sourcery:end
}

public typealias DeleteFavoriteTopicResponse = TopicWithFavorite
