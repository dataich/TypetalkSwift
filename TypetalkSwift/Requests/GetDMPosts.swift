//
//  GetDMPosts.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetDMPosts: Request {
  public let accountName: String
  public let from: Int?
  public let direction: Direction?
  
  public typealias Response = GetDMPostsResponse
  public var path: String {
    return "/messages/@\(accountName)"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    if let from = from { parameters["from"] = from }
    if let direction = direction { parameters["direction"] = direction.rawValue }
    return parameters
  }

// sourcery:inline:auto:GetDMPosts.AutoInit
  public init(accountName: String, from: Int?, direction: Direction?) {
    self.accountName = accountName
    self.from = from
    self.direction = direction
  }
// sourcery:end
}

public struct GetDMPostsResponse: Codable {
  public let topic: Topic
  public let directMessage: AccountWithStatus?
  public let bookmark: Bookmark?
  public let posts: [Post]
  public let hasNext: Bool
}
