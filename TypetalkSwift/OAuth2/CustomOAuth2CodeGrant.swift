//
//  CustomOAuth2CodeGrant.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation
import OAuth2

class CustomOAuth2CodeGrant: OAuth2CodeGrant {
  override func validateRedirectURL(_ redirect: URL) throws -> String {
    var comp = URLComponents(url: redirect, resolvingAgainstBaseURL: true)
    comp?.queryItems?.append(URLQueryItem(name: "state", value: context.state))
    let url = try! comp?.asURL()
    return try super.validateRedirectURL(url!)
  }
}
