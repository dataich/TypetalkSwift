//
//  GetTalks.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetTalks: Request {
  public let topicId: Int

  public typealias Response = GetTalksResponse
  public var path: String {
    return "/topics/\(topicId)/talks"
  }

// sourcery:inline:auto:GetTalks.AutoInit
  public init(topicId: Int) {
    self.topicId = topicId
  }
// sourcery:end
}

public struct GetTalksResponse: Codable {
  public let talks: [Talk]
}

