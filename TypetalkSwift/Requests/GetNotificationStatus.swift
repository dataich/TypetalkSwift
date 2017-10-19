//
//  GetNotificationStatus.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetNotificationStatus: Request {
  public typealias Response = GetNotificationStatusResponse
  public var path: String {
    return "/notifications/status"
  }

// sourcery:inline:auto:GetNotificationStatus.AutoInit
  public init() {}
// sourcery:end
}

public struct GetNotificationStatusResponse: Codable {
  public let mention: Mention
  public let access: NotificationAccess
  public let invite: Invite
  public let like: LikeReceive
  public let directMessage: DirectMessage
  public let doNotDisturb: DoNotDisturb

  public struct Mention: Codable {
    public let unread: Int
  }
  public struct Invite: Codable {
    public let team: Team
    public let topic: Topic

    public struct Team: Codable {
      public let pending: Int
    }
    public struct Topic: Codable {
      public let pending: Int
    }
  }
  public struct DirectMessage: Codable {
    public let unreadTopics: Int
  }
  public struct DoNotDisturb: Codable {
    public let isSuppressed: Bool
    public let manual: Manual
    public let scheduled: Scheduled

    public struct Manual: Codable {
      public let remainingTimeInMinutes: Int?
    }

    public struct Scheduled: Codable {
      public let enabled: Bool
      public let start: String
      public let end: String
    }
  }
}
