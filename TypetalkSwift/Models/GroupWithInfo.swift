//
//  GroupWithInfo.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct GroupWithInfo: Codable {
  public let group: Group
  public let memberCount: Int

  public struct Group: Codable {
    public let id: Int
    public let key: String
    public let name: String
    public let suggestion: String
    public let imageUrl: URL
    public let createdAt: Date
    public let updatedAt: Date
  }
}
