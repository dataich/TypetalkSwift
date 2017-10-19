//
//  Client.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire
import OAuth2

public class Client {
  
  static let shared: Client = Client()
  static let ErrorDomain = "TypetalkSwift.err"
  var oauth2: OAuth2!
  var manager: SessionManager!
  let decoder = JSONDecoder()
  static var baseUrl: String = "https://typetalk.com"
  
  private init() {
  }
  
  public class func setAPISettings(
    baseUrl: String? = nil,
    clientId: String,
    clientSecret: String,
    scopes: [OAuth2Scope],
    redirectUri: String,
    authorizeContext: Any) {
    
    if let baseUrl = baseUrl {
      Client.baseUrl = baseUrl
    }
    
    let settings = [
      "client_id": clientId,
      "client_secret": clientSecret,
      "authorize_uri": "\(Client.baseUrl)/oauth2/authorize",
      "token_uri": "\(Client.baseUrl)/oauth2/access_token",
      "scope": scopes.map{$0.rawValue}.joined(separator: ","),
      "redirect_uris": [redirectUri],
      "keychain": true,
      "verbose": true
      ] as OAuth2JSON
    
    let oauth2 = CustomOAuth2CodeGrant(settings: settings)
    oauth2.authConfig.authorizeEmbedded = true
    oauth2.authConfig.authorizeContext = authorizeContext as AnyObject
    oauth2.logger = OAuth2DebugLogger(.trace)
    
    shared.oauth2 = oauth2
    
    let manager = SessionManager()
    let retrier = OAuth2RetryHandler(oauth2: oauth2)
    manager.adapter = retrier
    manager.retrier = retrier
    shared.manager = manager
    
    shared.decoder.dateDecodingStrategy = .iso8601
  }
  
  private func responseDecodableObject<T: Request>(_ request:T, dataRequest: DataRequest, completionHandler:@escaping ((Result<T.Response>) -> Void)) -> Void {
    let statusCode = 200..<300
    dataRequest
      .validate(statusCode: statusCode)
      .responseDecodableObject(decoder: decoder) { (response: DataResponse<T.Response>) in
        let result: Result<T.Response>

        if let value = response.value {
          result = Result.success(value)
        } else {
          result = Result.failure(response.error ?? APIError.unknown)
        }
        
        completionHandler(result)
    }
  }
  
  public class func send<T: Request>(_ request:T, completionHandler:@escaping ((Result<T.Response>) -> Void)) -> Void {
    shared.oauth2.authorize { (authParameters, error) in
      if let _ = authParameters {
        guard let urlRequest = try? request.asURLRequest(Client.baseUrl) else { return }

        if let bodyParameter = request.bodyParameter {
          shared.manager.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(bodyParameter.data, withName: bodyParameter.withName, fileName: bodyParameter.fileName, mimeType: bodyParameter.mimeType)
          }, with: urlRequest, encodingCompletion: { (encodingResult) in
            switch encodingResult {
            case .success(let dataRequest, _, _):
              shared.responseDecodableObject(request, dataRequest: dataRequest, completionHandler: completionHandler)
            case .failure(let error):
              print(error)
            }
          })
        } else {
          shared.responseDecodableObject(request, dataRequest: shared.manager.request(urlRequest), completionHandler: completionHandler)
        }
      } else {
        print("Authorization was canceled or went wrong: \(error.debugDescription)")   // error will not be nil
      }
    }
  }
  
  public class func handleRedirectURL(url: URL) throws -> Void {
    try shared.oauth2.handleRedirectURL(url)
  }
}
