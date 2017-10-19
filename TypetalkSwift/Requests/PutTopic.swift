//
//  PutTopic.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PutTopic: Request {
  public let topicId: Int
  public let name: String
  public let description: String?
  public let teamId: Int?
  
  public typealias Response = PutTopicResponse
  public var method: HTTPMethod {
    return .put
  }
  public var path: String {
    return "/topics/\(topicId)"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["name"] = self.name
    parameters["description"] = self.description
    parameters["teamId"] = self.teamId
    
    return parameters
  }

// sourcery:inline:auto:PutTopic.AutoInit
  public init(topicId: Int, name: String, description: String?, teamId: Int?) {
    self.topicId = topicId
    self.name = name
    self.description = description
    self.teamId = teamId
  }
// sourcery:end
}

public typealias PutTopicResponse = TopicWithInfo
