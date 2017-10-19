//
//  GetPostsInTalk.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetPostsInTalk: Request {
  public let topicId: Int
  public let talkId: Int
  public let from: Int?
  public let direction: Direction?

  public typealias Response = GetPostsInTalkResponse
  public var path: String {
    return "/topics/\(topicId)/talks/\(talkId)/posts"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    parameters["from"] = from
    parameters["direction"] = direction

    return parameters
  }

// sourcery:inline:auto:GetPostsInTalk.AutoInit
  public init(topicId: Int, talkId: Int, from: Int?, direction: Direction?) {
    self.topicId = topicId
    self.talkId = talkId
    self.from = from
    self.direction = direction
  }
// sourcery:end
}

public struct GetPostsInTalkResponse: Codable {
  public let mySpace: MySpace?
  public let topic: Topic
  public let directMessage: DirectMessage?
  public let talk: Talk
  public let posts: [Post]
  public let hasNext: Bool
}
