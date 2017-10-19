//
//  PostDeclineTeamInvitation.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostDeclineTeamInvitation: Request {
  public let teamId: Int
  public let inviteId: Int
  
  public typealias Response = PostDeclineTeamInvitationResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/teams/\(teamId)/members/invite/\(inviteId)/decline"
  }

// sourcery:inline:auto:PostDeclineTeamInvitation.AutoInit
  public init(teamId: Int, inviteId: Int) {
    self.teamId = teamId
    self.inviteId = inviteId
  }
// sourcery:end
}

public typealias PostDeclineTeamInvitationResponse = InviteTeam
