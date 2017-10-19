//
//  PostPost.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostPost: Request {
  public let topicId: Int
  public let message: String
  public let replyTo: Int?
  public let fileKeys: [String]?
  public let talkIds: [Int]?
  
  public typealias Response = PostPostResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    
    parameters["message"] = self.message
    parameters["replyTo"] = self.replyTo
    parameters["fileKeys"] = self.fileKeys
    parameters["talkIds"] = self.talkIds
    
    return parameters
  }

// sourcery:inline:auto:PostPost.AutoInit
  public init(topicId: Int, message: String, replyTo: Int?, fileKeys: [String]?, talkIds: [Int]?) {
    self.topicId = topicId
    self.message = message
    self.replyTo = replyTo
    self.fileKeys = fileKeys
    self.talkIds = talkIds
  }
// sourcery:end
}

public typealias PostPostResponse = PostWithInfo

