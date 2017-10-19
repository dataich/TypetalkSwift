//
//  MentionWithPost.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct MentionWithPost: Codable {
  public let id: Int
  public let readAt: Date?
  public let post: PostSimple
}
