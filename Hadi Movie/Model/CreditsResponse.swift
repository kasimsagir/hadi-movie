//
//  CreditsResponse.swift
//  Hadi Movie
//
//  Created by Kasım on 5.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import Foundation

class CreditsResponse : Codable {
    let id : Int?
    let cast : [Cast]?
    let crew : [Crew]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cast = try values.decodeIfPresent([Cast].self, forKey: .cast)
        crew = try values.decodeIfPresent([Crew].self, forKey: .crew)
    }
    
}
