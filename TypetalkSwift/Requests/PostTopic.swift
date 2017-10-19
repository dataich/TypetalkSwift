//
//  PostTopic.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostTopic: Request {
  public let name: String
  public let spaceKey: String?
  public let addAccountIds: [Int]?
  public let addGroupIds: [Int]?
  
  public typealias Response = PostTopicResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["name"] = self.name
    parameters["spaceKey"] = self.spaceKey
    parameters["addAccountIds"] = self.addAccountIds
    parameters["addGroupIds"] = self.addGroupIds
    
    return parameters
  }

// sourcery:inline:auto:PostTopic.AutoInit
  public init(name: String, spaceKey: String?, addAccountIds: [Int]?, addGroupIds: [Int]?) {
    self.name = name
    self.spaceKey = spaceKey
    self.addAccountIds = addAccountIds
    self.addGroupIds = addGroupIds
  }
// sourcery:end
}

public typealias PostTopicResponse = TopicWithInfo
