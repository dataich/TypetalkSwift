//
//  PostAcceptTeamInvitation.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostAcceptTeamInvitation: Request {
  public let teamId: Int
  public let inviteId: Int
  
  public typealias Response = PostAcceptTeamInvitationResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/teams/\(teamId)/members/invite/\(inviteId)/accept"
  }

// sourcery:inline:auto:PostAcceptTeamInvitation.AutoInit
  public init(teamId: Int, inviteId: Int) {
    self.teamId = teamId
    self.inviteId = inviteId
  }
// sourcery:end
}

public struct PostAcceptTeamInvitationResponse: Codable {
  public let topics: [Topic]
  public let invite: InviteTeam
}
