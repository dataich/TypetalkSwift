//
//  PostSimple.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct PostSimple: Codable {
  public let id: Int
  public let topicId: Int
  public let topic: Topic
  public let replyTo: Int?
  public let message: String
  public let account: AccountTrait
  public let attachments: [AttachmentWithInfo]
  public let links: [Link]
  public let directMessage: DirectMessage?
  public let createdAt: Date
  public let updatedAt: Date
}
