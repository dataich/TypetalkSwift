//
//  TopicWithFavorite.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation

public struct TopicWithFavorite: Codable {
  public let topic: Topic
  public let favorite: Bool
}
