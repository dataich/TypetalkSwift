//
//  GetAccountProfile.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetAccountProfile: Request {
  public let accountName: String
  
  public typealias Response = GetAccountProfileResponse
  public var path: String {
    return "/accounts/profile/\(accountName)"
  }

// sourcery:inline:auto:GetAccountProfile.AutoInit
  public init(accountName: String) {
    self.accountName = accountName
  }
// sourcery:end
}

public struct GetAccountProfileResponse: Codable {
  public let account: AccountProfile
  public let status: OnlineStatus

  public struct AccountProfile: Codable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let suggestion: String
    public let mailAddress: String
    public let imageUrl: URL
    public let createdAt: Date
    public let updatedAt: Date
    public let imageUpdatedAt: Date
  }
}
