//
//  GetTopicMembersStatuses.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetTopicMembersStatuses: Request {
  public let topicId: Int

  public typealias Response = GetTopicMembersStatusesResponse
  public var path: String {
    return "/topics/\(topicId)/members/status"
  }

// sourcery:inline:auto:GetTopicMembersStatuses.AutoInit
  public init(topicId: Int) {
    self.topicId = topicId
  }
// sourcery:end
}

public struct GetTopicMembersStatusesResponse: Codable {
  public let accounts: [AccountStatus]
  public let pendings: [Pending]

  public struct AccountStatus: Codable {
    public let account: AccountTrait
    public let online: Bool
  }

  public struct Pending: Codable {
    public let account: AccountTrait?
    public let mailAddress: String?
  }
}
