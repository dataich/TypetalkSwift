//
//  InviteTeam.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct InviteTeam: Codable {
  public let id: Int
  public let team: Team
  public let sender: AccountTrait
  public let account: AccountTrait?
  public let role: TeamRole
  public let message: String
  public let createdAt: Date
  public let updatedAt: Date
}
