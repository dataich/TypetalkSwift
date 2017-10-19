//
//  LikeReceive.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct LikeReceive: Codable {
  public let receive: Receive
  
  public struct Receive: Codable {
    public let hasUnread: Bool
    public let readLikeId: Int?
  }
}
