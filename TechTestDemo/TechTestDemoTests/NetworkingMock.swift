//
//  NetworkingMock.swift
//  TechTestDemoTests
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation
@testable import TechTestDemo

class NetworkingMock: Networking {
    
    static var data: Data?

    func data(from url: URL, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        guard let data = NetworkingMock.data else {
            throw NetworkError.dataNotFound
        }
        return (data, URLResponse())
    }
}
