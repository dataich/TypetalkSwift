//
//  PostMigrateToDMTopic.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostMigrateToDMTopic: Request {
  public let accountName: String
  public let topicId: Int
  
  public typealias Response = PostMigrateToDMTopicResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/messages/@\(accountName)/migrate"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    parameters["topicId"] = topicId
    return parameters
  }

// sourcery:inline:auto:PostMigrateToDMTopic.AutoInit
  public init(accountName: String, topicId: Int) {
    self.accountName = accountName
    self.topicId = topicId
  }
// sourcery:end
}

public typealias PostMigrateToDMTopicResponse = Topic
