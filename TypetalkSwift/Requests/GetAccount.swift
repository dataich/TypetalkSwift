//
//  GetAccount.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetAccount: Request {
  public let nameOrEmailAddress: String
  
  public typealias Response = GetAccountResponse
  public var path: String {
    return "/search/accounts"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["nameOrEmailAddress"] = self.nameOrEmailAddress
    
    return parameters
  }

// sourcery:inline:auto:GetAccount.AutoInit
  public init(nameOrEmailAddress: String) {
    self.nameOrEmailAddress = nameOrEmailAddress
  }
// sourcery:end
}

public typealias GetAccountResponse = AccountTrait
