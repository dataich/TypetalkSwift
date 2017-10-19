//
//  BadRequestResponse.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

public struct BadRequestResponse: Codable {
  public let errors: [Error]
  
  public struct Error: Codable {
    public let field: String
    public let name: String
    public let message: String
  }
}
