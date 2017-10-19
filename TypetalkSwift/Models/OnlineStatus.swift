//
//  OnlineStatus.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct OnlineStatus: Codable {
  public let presence : Presence
  public let web: [String:String]?
  public let mobile: [String:String]?
  
  public enum Presence: String, Codable {
    case active, away
  }
}
