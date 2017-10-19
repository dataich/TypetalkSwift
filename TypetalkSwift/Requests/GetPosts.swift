//
//  GetPosts.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetPosts: Request {
  public let topicId: Int
  public let from: Int?
  public let direction: Direction?
  
  public typealias Response = GetPostsResponse
  public var path: String {
    return "/topics/\(topicId)"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    if let from = from { parameters["from"] = from }
    if let direction = direction { parameters["direction"] = direction.rawValue }
    return parameters
  }

// sourcery:inline:auto:GetPosts.AutoInit
  public init(topicId: Int, from: Int?, direction: Direction?) {
    self.topicId = topicId
    self.from = from
    self.direction = direction
  }
// sourcery:end
}

public struct GetPostsResponse: Codable {
  public let mySpace: MySpace?
  public let team: Team?
  public let topic: Topic
  public let bookmark: Bookmark?
  public let posts: [Post]
  public let hasNext: Bool
  public let exceedsAttachmentLimit: Bool
  public let onboarding: Onboarding?

  public struct Onboarding: Codable {
    public let status: Status
    public let inviteTopicId: Int?

    public enum Status: String, Codable {
      case pending, done
    }
  }
}
