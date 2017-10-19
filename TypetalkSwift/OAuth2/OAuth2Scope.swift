//
//  OAuth2Scope.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

public enum OAuth2Scope: String {
  case topicRead = "topic.read"
  case topicPost = "topic.post"
  case topicWrite = "topic.write"
  case topicDelete = "topic.delete"
  case my = "my"
  case all = "all"
}
