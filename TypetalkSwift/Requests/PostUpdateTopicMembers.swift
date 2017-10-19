//
//  PostUpdateTopicMembers.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostUpdateTopicMembers: Request {
  public let topicId: Int
  public let addAccountIds:[Int]?
  public let addGroupIds:[Int]?
  public let removeAccountIds:[Int]?
  public let removeGroupIds:[Int]?
  
  public typealias Response = PostUpdateTopicMembersResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/members/update"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["addAccountIds"] = self.addAccountIds
    parameters["addGroupIds"] = self.addGroupIds
    parameters["removeAccountIds"] = self.removeAccountIds
    parameters["removeGroupIds"] = self.removeGroupIds
    
    return parameters
  }

// sourcery:inline:auto:PostUpdateTopicMembers.AutoInit
  public init(topicId: Int, addAccountIds: [Int]?, addGroupIds: [Int]?, removeAccountIds: [Int]?, removeGroupIds: [Int]?) {
    self.topicId = topicId
    self.addAccountIds = addAccountIds
    self.addGroupIds = addGroupIds
    self.removeAccountIds = removeAccountIds
    self.removeGroupIds = removeGroupIds
  }
// sourcery:end
}

public typealias PostUpdateTopicMembersResponse = TopicWithInfo
