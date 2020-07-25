//
//  Petition.swift
//  Project 7
//
//  Created by Vyacheslav Pronin on 21/07/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import Foundation


struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
