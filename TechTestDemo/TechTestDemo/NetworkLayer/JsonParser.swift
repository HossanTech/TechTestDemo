//
//  JsonParser.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation

protocol JsonParser {
  func parse<T: Decodable>(data: Data, type:T.Type)throws -> T
}

// MARK: - Todo Parsing the json.
extension JsonParser {
  
  func parse<T: Decodable>(data: Data, type:T.Type)throws -> T {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
      return try decoder.decode(T.self, from: data )
    } catch {
      throw NetworkError.parsingError
    }
  }
}
