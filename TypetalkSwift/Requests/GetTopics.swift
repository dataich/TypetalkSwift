//
//  GetTopics.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetTopics: Request {
  public typealias Response = GetTopicsResponse
  public var path: String {
    return "/topics"
  }

// sourcery:inline:auto:GetTopics.AutoInit
  public init() {}
// sourcery:end
}

public struct GetTopicsResponse: Codable {
  public let topics: [TopicWithInfo]

  public struct TopicWithInfo: Codable {
    public let topic: Topic
    public let favorite: Bool
    public let unread: Unread
  }
}
