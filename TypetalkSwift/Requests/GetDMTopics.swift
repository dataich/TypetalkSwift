//
//  GetDMTopics.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetDMTopics: Request {
  public typealias Response = GetDMTopicsResponse
  public var path: String {
    return "/messages"
  }

// sourcery:inline:auto:GetDMTopics.AutoInit
  public init() {}
// sourcery:end
}

public struct GetDMTopicsResponse: Codable {
  public let topics: [TopicWithInfo]

  public struct TopicWithInfo: Codable {
    public let topic: Topic
    public let unread: Unread
    public let directMessage: AccountWithStatus
  }
}
