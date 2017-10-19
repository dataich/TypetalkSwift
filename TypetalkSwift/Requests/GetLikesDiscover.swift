//
//  GetLikesDiscover.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetLikesDiscover: Request {
  public let from: Int?

  public typealias Response = GetLikesDiscoverResponse
  public var path: String {
    return "/likes/discover"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    parameters["from"] = self.from
    return parameters
  }

// sourcery:inline:auto:GetLikesDiscover.AutoInit
  public init(from: Int?) {
    self.from = from
  }
// sourcery:end
}

public typealias GetLikesDiscoverResponse = LikeActivity


