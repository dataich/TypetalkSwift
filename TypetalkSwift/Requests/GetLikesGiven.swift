//
//  GetLikesGiven.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetLikesGiven: Request {
  public let from: Int?

  public typealias Response = GetLikesGivenResponse
  public var path: String {
    return "/likes/give"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    parameters["from"] = self.from
    return parameters
  }

// sourcery:inline:auto:GetLikesGiven.AutoInit
  public init(from: Int?) {
    self.from = from
  }
// sourcery:end
}

public struct GetLikesGivenResponse: Codable {
  public let likedPosts: [LikedPost]

  public struct LikedPost: Codable {
    public let post: PostSimple
    public let myLike: MyLike
    public let directMessage: DirectMessage?

    public struct MyLike: Codable {
      public let id: Int
      public let comment: String
      public let createdAt: Date
    }
  }
}
