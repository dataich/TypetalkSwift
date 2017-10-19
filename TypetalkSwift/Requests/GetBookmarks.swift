//
//  GetBookmarks.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetBookmarks: Request {
  public typealias Response = GetBookmarksResponse
  public var path: String {
    return "/bookmarks"
  }

// sourcery:inline:auto:GetBookmarks.AutoInit
  public init() {}
// sourcery:end
}

public class GetBookmarksResponse: Codable {
  public let unreads: [Unread]
}
