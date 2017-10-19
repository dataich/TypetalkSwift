//
//  Attachment.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct Attachment: Codable {
  public let contentType: String
  public let fileKey: String
  public let fileName: String
  public let fileSize: Int
}
