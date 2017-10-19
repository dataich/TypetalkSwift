//
//  PutMentions.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PutMentions: Request {
  public let mentionId: Int
  
  public typealias Response = PutMentionsResponse
  public var method: HTTPMethod {
    return .put
  }
  public var path: String {
    return "/mentions/\(mentionId)"
  }

// sourcery:inline:auto:PutMentions.AutoInit
  public init(mentionId: Int) {
    self.mentionId = mentionId
  }
// sourcery:end
}

public struct PutMentionsResponse: Codable {
  public let mention: MentionWithPost
}
