//
//  GetProfile.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetProfile: Request {
  public typealias Response = GetProfileResponse
  public var path: String {
    return "/profile"
  }

// sourcery:inline:auto:GetProfile.AutoInit
  public init() {}
// sourcery:end
}

public struct GetProfileResponse: Codable {
  public let account: Account

  public struct Account: Codable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let suggestion: String
    public let imageUrl: URL
    public let isBot: Bool
    public let lang: String
    public let timezoneId: String
    public let createdAt: Date
    public let updatedAt: Date
  }
}
