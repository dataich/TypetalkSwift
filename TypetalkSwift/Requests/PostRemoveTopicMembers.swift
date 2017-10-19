//
//  PostRemoveTopicMembers.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostRemoveTopicMembers: Request {
  public let topicId: Int
  public let removeInviteIds:[Int]?
  public let removeMemberIds:[Int]?
  
  public typealias Response = PostRemoveTopicMembersResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/members/remove"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["removeInviteIds"] = self.removeInviteIds
    parameters["removeMemberIds"] = self.removeMemberIds
    
    return parameters
  }

// sourcery:inline:auto:PostRemoveTopicMembers.AutoInit
  public init(topicId: Int, removeInviteIds: [Int]?, removeMemberIds: [Int]?) {
    self.topicId = topicId
    self.removeInviteIds = removeInviteIds
    self.removeMemberIds = removeMemberIds
  }
// sourcery:end
}

public typealias PostRemoveTopicMembersResponse = TopicWithInfo
