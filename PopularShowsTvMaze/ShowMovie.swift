//
//  ShowMovie.swift
//  PopularShowsTvMaze
//
//  Created by Abdallah on 12/23/21.
//

import Foundation

// MARK: - Show
struct ShowMovie: Codable {
    let id: Int
    let url: String
    let name: String
    let type: TypeEnum
    let language: Language
    let genres: [String]
    let status: Status
    let runtime: Int?
    let averageRuntime: Int
    let premiered, ended: String
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network, webChannel: Network?
//    let dvdCountry: JSONNull?
    let externals: Externals
    let image: Image?
    let summary: String
    let updated: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, externals, image, summary, updated
        case links = "_links"
    }
}

enum Language: String, Codable {
    case english = "English"
    case japanese = "Japanese"
}


enum Status: String, Codable {
    case ended = "Ended"
}

enum TypeEnum: String, Codable {
    case animation = "Animation"
    case documentary = "Documentary"
    case scripted = "Scripted"
}
