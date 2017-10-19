//
//  DataRequest+CodableSerializer.swift
//  TypetalkSwift
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
  @discardableResult
  public func responseDecodableObject<T: Decodable>(queue: DispatchQueue? = nil, decoder: JSONDecoder = JSONDecoder(), completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
    return response(queue: queue, responseSerializer: DataRequest.Serializer(decoder), completionHandler: completionHandler)
  }
  
  private static func Serializer<T: Decodable>(_ decoder: JSONDecoder) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, response, data, error in
      if let error = error {
        if let data = data, response?.statusCode == 400, let response = try? decoder.decode(BadRequestResponse.self, from: data) {
          return .failure(APIError.badRequest(response: response))
        }

        return .failure(error)
      }
      return DataRequest.decodeToObject(decoder: decoder, response: response, data: data)
    }
  }
  
  private static func decodeToObject<T: Decodable>(decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Alamofire.Result<T> {
    let result = Alamofire.Request.serializeResponseData(response: response, data: data, error: nil)
    
    switch result {
    case .success(let data):
      do {
        let object = try decoder.decode(T.self, from: data)
        return .success(object)
      }
      catch {
        return .failure(error)
      }
    case .failure(let error): return .failure(error)
    }
  }
}
