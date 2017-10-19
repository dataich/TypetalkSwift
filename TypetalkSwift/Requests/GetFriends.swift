//
//  GetFriends.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetFriends: Request {
  public let q :String
  public let offset : Int?
  public let count : Int?

  public typealias Response = GetFriendsResponse
  public var path: String {
    return "/search/friends"
  }
  public var version: Int {
    return 2
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["q"] = self.q
    parameters["offset"] = self.offset
    parameters["count"] = self.count
    
    return parameters
  }

// sourcery:inline:auto:GetFriends.AutoInit
  public init(q: String, offset: Int?, count: Int?) {
    self.q = q
    self.offset = offset
    self.count = count
  }
// sourcery:end
}

public struct GetFriendsResponse: Codable {
  public let accounts: [AccountWithStatus]
  public let count: Int
}
