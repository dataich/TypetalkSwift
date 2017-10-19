//
//  PostInviteTopicMembers.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostInviteTopicMembers: Request {
  public let topicId: Int
  public let inviteMembers:[String]?
  public let inviteMessage:String?
  
  public typealias Response = PostInviteTopicMembersResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/members/invite"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["inviteMembers"] = self.inviteMembers
    parameters["inviteMessage"] = self.inviteMessage
    
    return parameters
  }

// sourcery:inline:auto:PostInviteTopicMembers.AutoInit
  public init(topicId: Int, inviteMembers: [String]?, inviteMessage: String?) {
    self.topicId = topicId
    self.inviteMembers = inviteMembers
    self.inviteMessage = inviteMessage
  }
// sourcery:end
}

public typealias PostInviteTopicMembersResponse = TopicWithInfo
