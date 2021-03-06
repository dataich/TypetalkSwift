//
//  GetTopic.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetTopic: Request {
  public let topicId: Int
  
  public typealias Response = GetTopicResponse
  public var path: String {
    return "/topics/\(topicId)/details"
  }

// sourcery:inline:auto:GetTopic.AutoInit
  public init(topicId: Int) {
    self.topicId = topicId
  }
// sourcery:end
}

public typealias GetTopicResponse = TopicWithInfo
