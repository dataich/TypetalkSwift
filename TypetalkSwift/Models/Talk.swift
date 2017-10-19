//
//  Talk.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct Talk: Codable {
  public let id: Int
  public let topicId: Int
  public let name: String
  public let suggestion: String
  public let backlog: Backlog?
  public let createdAt: Date
  public let updatedAt: Date

  public struct Backlog: Codable {
    public let spaceUrl: URL
    public let issueKey: String
  }
}
