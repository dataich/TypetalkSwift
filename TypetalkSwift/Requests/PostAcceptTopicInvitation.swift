//
//  PostAcceptTopicInvitation.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostAcceptTopicInvitation: Request {
  public let topicId: Int
  public let inviteId: Int

  public typealias Response = PostAcceptTopicInvitationResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/members/invite/\(inviteId)/accept"
  }

// sourcery:inline:auto:PostAcceptTopicInvitation.AutoInit
  public init(topicId: Int, inviteId: Int) {
    self.topicId = topicId
    self.inviteId = inviteId
  }
// sourcery:end
}

public struct PostAcceptTopicInvitationResponse: Codable {
  public let invite: InviteTopic
}
