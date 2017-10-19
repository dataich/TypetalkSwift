//
//  GetMentions.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetMentions: Request {
  public let from: Int?
  public let unread: Bool?
  
  public typealias Response = GetMentionsResponse
  public var path: String {
    return "/mentions"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["from"] = self.from
    parameters["unread"] = self.unread
    
    return parameters
  }

// sourcery:inline:auto:GetMentions.AutoInit
  public init(from: Int?, unread: Bool?) {
    self.from = from
    self.unread = unread
  }
// sourcery:end
}

public struct GetMentionsResponse: Codable {
  public let mentions: [MentionWithPost]
}
