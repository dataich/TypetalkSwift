//
//  Like.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct Like: Codable {
  public let id: Int
  public let postId: Int
  public let topicId: Int
  public let comment: String
  public let account: AccountTrait
  public let createdAt: Date
}
