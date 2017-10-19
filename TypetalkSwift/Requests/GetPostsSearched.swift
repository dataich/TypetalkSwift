//
//  GetPostsSearched.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetPostsSearched: Request {
  public let q: String
  public let topicIds: [Int]?
  public let accountIds: [Int]?
  public let hasAttachments: Bool?
  public let start: Int?
  public let from: String?
  public let to: String?
  
  public typealias Response = GetPostsSearchedResponse
  public var path: String {
    return "/search/posts"
  }
  
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    parameters["q"] = q
    parameters["topicIds"] = self.topicIds
    parameters["accountIds"] = self.accountIds
    parameters["hasAttachments"] = self.hasAttachments
    parameters["start"] = self.start
    parameters["from"] = self.from
    parameters["to"] = self.to
    
    return parameters
  }
  
  // sourcery:inline:auto:GetPostsSearched.AutoInit
  public init(q: String, topicIds: [Int]?, accountIds: [Int]?, hasAttachments: Bool?, start: Int?, from: String?, to: String?) {
    self.q = q
    self.topicIds = topicIds
    self.accountIds = accountIds
    self.hasAttachments = hasAttachments
    self.start = start
    self.from = from
    self.to = to
  }
  // sourcery:end
}

public struct GetPostsSearchedResponse: Codable {
  public let count: Int
  public let posts: [PostSimple]
  public let isLimited: Bool
}
