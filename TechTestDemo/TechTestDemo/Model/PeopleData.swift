//
//  PeopleData.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation

struct PeopleData: Decodable, Identifiable {
    var createdAt: String?
    var firstName: String
    var avatar: String?
    var lastName: String?
    var email: String?
    var jobTitle: String?
    var favouriteColor: String?
    var id: String?
}

typealias People = [PeopleData]
