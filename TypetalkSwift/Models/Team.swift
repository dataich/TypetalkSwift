//
//  Team.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct Team: Codable {
  public let id: Int
  public let name: String
  public let imageUrl: URL
  public let createdAt: Date
  public let updatedAt: Date
}
