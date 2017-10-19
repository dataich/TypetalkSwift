//
//  Link.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct Link: Codable {
  public let id: Int
  public let url: URL
  public let contentType: String?
  public let title: String?
  public let description: String?
  public let imageUrl: URL?
  public let createdAt: Date
  public let updatedAt: Date
}
