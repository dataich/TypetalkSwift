//
//  APIError.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

public enum APIError: Error {
  case badRequest(response: BadRequestResponse)
  case unknown
}
