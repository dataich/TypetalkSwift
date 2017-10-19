//
//  GetSpaces.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

// sourcery: AutoInit
public struct GetSpaces: Request {
  public typealias Response = GetSpacesResponse
  public var path: String {
    return "/spaces"
  }

// sourcery:inline:auto:GetSpaces.AutoInit
  public init() {}
// sourcery:end
}

public struct GetSpacesResponse: Codable {
  public let mySpaces: [MySpace]
}
