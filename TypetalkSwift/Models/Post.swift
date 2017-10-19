//
//  Post.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct Post: Codable {
  public let id: Int
  public let topicId: Int
  public let replyTo: Int?
  public let message: String
  public let account: AccountTrait
  public let mention: Mention?
  public let attachments: [AttachmentWithInfo]
  public let likes: [Like]
  public let talks: [Talk]
  public let links: [Link]
  public let createdAt: Date
  public let updatedAt: Date

  public struct Mention: Codable {
    public let id: Int
    public let readAt: Date
  }
}
