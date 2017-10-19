//
//  GetLikesReceived.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetLikesReceived: Request {
  public let from: Int?

  public typealias Response = GetLikesReceivedResponse
  public var path: String {
    return "/likes/receive"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    parameters["from"] = self.from
    return parameters
  }

// sourcery:inline:auto:GetLikesReceived.AutoInit
  public init(from: Int?) {
    self.from = from
  }
// sourcery:end
}

public typealias GetLikesReceivedResponse = LikeActivity
