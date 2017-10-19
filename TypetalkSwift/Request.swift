//
//  Request.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Alamofire

public protocol Request {
  associatedtype Response: Codable
  var method: HTTPMethod { get }
  var path: String { get }
  var version: Int { get }
  var parameters: Parameters? { get }
  var bodyParameter: BodyParameter? { get }
  func asURLRequest(_ baseURL: String) throws -> URLRequest
}

extension Request {
  public var version: Int {
    return 1
  }
  
  public var method: HTTPMethod {
    return .get
  }
  
  public var parameters: Parameters? {
    return nil
  }
  
  public var bodyParameter: BodyParameter? {
    return nil
  }
  
  public func asURLRequest(_ baseURL: String) throws -> URLRequest {
    let url = URL(string: "\(baseURL)/api/v\(version)")
    let urlRequest = try URLRequest(url: url!.appendingPathComponent(path), method: method)
    return try NoBracketsURLEncoding().encode(urlRequest, with: parameters)
  }
}

public struct NoBracketsURLEncoding: ParameterEncoding {
  public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var request = try URLEncoding().encode(urlRequest, with: parameters)
    request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
    return request
  }
}

public struct BodyParameter {
  public let data: Data
  public let withName: String
  public let fileName: String
  public let mimeType: String
}
