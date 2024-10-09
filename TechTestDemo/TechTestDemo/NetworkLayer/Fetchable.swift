//
//  Fetchable.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation

// MARK: -  Protocol for GET People List.

protocol Fetchable {
  
  func get(url: URL) async throws -> Data
}
