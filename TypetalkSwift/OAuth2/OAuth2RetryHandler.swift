//
//  OAuth2RetryHandler.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation
import OAuth2
import Alamofire

class OAuth2RetryHandler: RequestRetrier, RequestAdapter {
  
  let loader: OAuth2DataLoader
  
  init(oauth2: OAuth2) {
    loader = OAuth2DataLoader(oauth2: oauth2)
  }
  
  public func should(_ manager: SessionManager, retry request: Alamofire.Request, with error: Error, completion: @escaping RequestRetryCompletion) {
    if let response = request.task?.response as? HTTPURLResponse, 401 == response.statusCode, let req = request.request {
      var dataRequest = OAuth2DataRequest(request: req, callback: { _ in })
      dataRequest.context = completion
      loader.enqueue(request: dataRequest)
      loader.attemptToAuthorize() { authParams, error in
        self.loader.dequeueAndApply() { req in
          if let comp = req.context as? RequestRetryCompletion {
            comp(nil != authParams, 0.0)
          }
        }
      }
    } else {
      completion(false, 0.0)
    }
  }
  
  public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
    guard nil != loader.oauth2.accessToken else {
      return urlRequest
    }
    return try urlRequest.signed(with: loader.oauth2)
  }
}

