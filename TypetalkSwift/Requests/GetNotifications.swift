//
//  GetNotifications.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetNotifications: Request {
  public typealias Response = GetNotificationsResponse
  public var path: String {
    return "/notifications"
  }

// sourcery:inline:auto:GetNotifications.AutoInit
  public init() {}
// sourcery:end
}

public struct GetNotificationsResponse: Codable {
  public let mentions: [MentionWithPost]
  public let invites: Invites

  public struct Invites: Codable {
    public let teams: [InviteTeam]
    public let topics: [InviteTopic]
  }
}
