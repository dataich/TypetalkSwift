//
//  Result.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

public enum Result<T: Codable> {
  case success(T)
  case failure(Error)
}
