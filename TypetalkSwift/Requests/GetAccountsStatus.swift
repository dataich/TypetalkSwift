//
//  GetAccountsStatus.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetAccountsStatus: Request {
  public let accountIds: [Int]
  
  public typealias Response = GetAccountsStatusResponse
  public var path: String {
    return "/accounts/status"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["accountIds"] = self.accountIds
    
    return parameters
  }

// sourcery:inline:auto:GetAccountsStatus.AutoInit
  public init(accountIds: [Int]) {
    self.accountIds = accountIds
  }
// sourcery:end
}

public struct GetAccountsStatusResponse: Codable {
  public let accounts: [AccountWithStatus]
}
