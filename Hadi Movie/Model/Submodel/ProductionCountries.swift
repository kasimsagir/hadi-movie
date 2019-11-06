//
//  ProductionCountries.swift
//  Hadi Movie
//
//  Created by Kasım on 5.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

struct ProductionCountries : Codable {
    let iso_3166_1 : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case iso_3166_1 = "iso_3166_1"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso_3166_1 = try values.decodeIfPresent(String.self, forKey: .iso_3166_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
