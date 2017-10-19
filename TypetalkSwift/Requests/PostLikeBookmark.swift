//
//  PostLikeBookmark.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostLikeBookmark: Request {
  public let likeId: Int

  public typealias Response = PostLikeBookmarkResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/likes/receive/bookmark/save"
  }
  public var parameters: Parameters? {
    var parameters: Parameters = [:]
    parameters["likeId"] = self.likeId
    return parameters
  }

// sourcery:inline:auto:PostLikeBookmark.AutoInit
  public init(likeId: Int) {
    self.likeId = likeId
  }
// sourcery:end
}

public struct PostLikeBookmarkResponse: Codable {
  public let like: LikeReceive
}
