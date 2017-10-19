//
//  Unread.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct Unread: Codable {
  public let count: Int
  public let postId: Int
  public let topicId: Int
  public let isOverCountLimit: Bool
}
