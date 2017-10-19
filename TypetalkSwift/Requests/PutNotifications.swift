//
//  PutNotifications.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PutNotifications: Request {
  public typealias Response = PutNotificationsResponse
  public var method: HTTPMethod {
    return .put
  }
  public var path: String {
    return "/notifications"
  }

// sourcery:inline:auto:PutNotifications.AutoInit
  public init() {}
// sourcery:end
}

public struct PutNotificationsResponse: Codable {
  public let access: NotificationAccess
}

