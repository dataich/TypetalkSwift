//
//  LikedPost.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct LikedPost: Codable {
  public let post: PostSimple
  public let likes: [Like]
  public let directMessage: DirectMessage?
}
