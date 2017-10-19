//
//  PostDeclineTopicInvitation.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostDeclineTopicInvitation: Request {
  public let topicId: Int
  public let inviteId: Int
  
  public typealias Response = PostDeclineTopicInvitationResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/members/invite/\(inviteId)/decline"
  }

// sourcery:inline:auto:PostDeclineTopicInvitation.AutoInit
  public init(topicId: Int, inviteId: Int) {
    self.topicId = topicId
    self.inviteId = inviteId
  }
// sourcery:end
}

public struct PostDeclineTopicInvitationResponse: Codable {
  public let invite: InviteTopic
}
