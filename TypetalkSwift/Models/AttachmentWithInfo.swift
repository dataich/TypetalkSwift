//
//  AttachmentWithInfo.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct AttachmentWithInfo: Codable {
  public let attachment: Attachment
  public let webUrl: URL
  public let apiUrl: URL
  public let thumbnails: [Thumbnail]?

  public struct Thumbnail: Codable {
    public let type: String
    public let fileSize: Int
    public let width: Int
    public let height: Int
  }
}
