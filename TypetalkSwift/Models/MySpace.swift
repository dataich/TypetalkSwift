//
//  MySpace.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct MySpace: Codable {
  public let space: Space
  public let myRole: SpaceRole?
  public let isPaymentAdmin: Bool?
  public let invitableRoles: [SpaceRole]?
  public let myPlan: MyPlan

  public struct Space: Codable {
    public let key: String
    public let name: String
    public let enabled: Bool
    public let imageUrl: URL
  }

  public struct MyPlan: Codable {
    public let plan: Plan
    public let enabled: Bool
    public let trial: Trial?
    public let numberOfUsers: Int
    public let totalAttachmentSize: Int
    public let createdAt: Date
    public let updatedAt: Date

    public struct Trial: Codable {
      public let endDate: Date
      public let daysLeft: Int
    }

    public struct Plan: Codable {
      public let key: String
      public let name: String
      public let limitNumberOfUsers: Int
      public let limitTotalAttachmentSize: Int
    }
  }
}
