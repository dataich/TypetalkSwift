//
//  PostWithInfo.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct PostWithInfo: Codable {
  public let topic: TopicTimestamp
  public let post: Post
  public let mentions: [AccountTrait]
  public let exceedsAttachmentLimit: Bool
  public let directMessage: DirectMessage?
}
