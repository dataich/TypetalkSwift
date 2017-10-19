//
//  PutBookmarks.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PutBookmarks: Request {
  public let topicId: Int
  public let postId: Int?
  
  public typealias Response = PutBookmarksResponse
  public var method: HTTPMethod {
    return .put
  }
  public var path: String {
    return "/bookmarks"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["topicId"] = self.topicId
    parameters["postId"] = self.postId
    
    return parameters
  }

// sourcery:inline:auto:PutBookmarks.AutoInit
  public init(topicId: Int, postId: Int?) {
    self.topicId = topicId
    self.postId = postId
  }
// sourcery:end
}

public struct PutBookmarksResponse: Codable {
  public let unread: Unread
}
