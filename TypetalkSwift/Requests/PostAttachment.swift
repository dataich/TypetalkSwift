//
//  PostAttachment.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct PostAttachment: Request {
  public let topicId: Int
  public let data: Data
  public let fileName: String

  public typealias Response = PostAttachmentResponse
  public var method: HTTPMethod {
    return .post
  }
  public var path: String {
    return "/topics/\(topicId)/attachments"
  }
  public var bodyParameter: BodyParameter? {
    return BodyParameter(data: self.data, withName: "file", fileName: self.fileName, mimeType: "")
  }

// sourcery:inline:auto:PostAttachment.AutoInit
  public init(topicId: Int, data: Data, fileName: String) {
    self.topicId = topicId
    self.data = data
    self.fileName = fileName
  }
// sourcery:end
}

public typealias PostAttachmentResponse = Attachment
