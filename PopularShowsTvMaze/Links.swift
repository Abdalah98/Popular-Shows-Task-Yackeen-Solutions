//
//  Links.swift
//  PopularShowsTvMaze
//
//  Created by Abdallah on 12/23/21.
//

import Foundation
// MARK: - Links
struct Links: Codable {
    let linksSelf, previousepisode: Previousepisode

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode
    }
}
