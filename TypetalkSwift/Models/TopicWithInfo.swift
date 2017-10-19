//
//  TopicWithInfo.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct TopicWithInfo: Codable {
  public let topic: Topic
  public let mySpace: MySpace?
  public let teams: [TeamWithMembers]
  public let groups: [GroupWithInfo]
  public let accounts: [AccountTrait]
  public let invitingAccounts: [InvitingAccount]
  public let invites: [Invite]
  public let accountsForApi: [AccountForTopicApiOnly]
  public let integrations: [TopicServiceIntegrationWithInfo]
  public let remainingInvitations: Int?

  public struct TeamWithMembers: Codable {
    public let team: Team
    public let members: [TeamMember]

    public struct TeamMember: Codable {
      public let account: AccountTrait
      public let role: TeamRole
    }
  }

  public struct Invite: Codable {
    public let id: Int
    public let account: AccountTrait?
    public let mailAddress: String?
    public let status: String
  }

  public struct InvitingAccount: Codable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let suggestion: String
    public let imageUrl: URL
    public let isBot: Bool
    public let spaceRole: SpaceRole
    public let createdAt: Date
    public let updatedAt: Date
  }

  public struct TopicServiceIntegrationWithInfo: Codable {
    public let integration: TopicServiceIntegration
    public let account: AccountForTopicApiOnly
    public let service: ServiceIntegration

    public struct TopicServiceIntegration: Codable {
      public let id: Int
      public let linkUrl: URL?
      public let configurationUrl: URL?
    }

    public struct ServiceIntegration: Codable {
      public let name: String
      public let fullName: String
      public let summary: String
      public let imageUrl: URL
    }
  }
}
