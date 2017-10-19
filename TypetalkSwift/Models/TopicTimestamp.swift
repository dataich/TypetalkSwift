//
//  TopicTimestamp.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct TopicTimestamp: Codable {
  public let id: Int
  public let name: String
  public let isDirectMessage: Bool
  public let lastPostedAt: Date?
  public let createdAt: Date
  public let updatedAt: Date
}
