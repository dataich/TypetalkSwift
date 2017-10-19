//
//  InviteTopic.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct InviteTopic: Codable {
  public let id: Int
  public let topic: Topic
  public let sender: AccountTrait
  public let account: AccountTrait
  public let message: String
  public let createdAt: Date
  public let updatedAt: Date
}
