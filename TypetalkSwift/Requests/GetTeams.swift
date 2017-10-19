//
//  GetTeams.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetTeams: Request {
  public typealias Response = GetTeamsResponse
  public var path: String {
    return "/teams"
  }

// sourcery:inline:auto:GetTeams.AutoInit
  public init() {}
// sourcery:end
}

public struct GetTeamsResponse: Codable {
  public let teams: [TeamWithInfo]

  public struct TeamWithInfo: Codable {
    public let team: Team
    public let memberCount: Int
  }
}
