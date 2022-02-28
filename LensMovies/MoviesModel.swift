//
//  MoviesModel.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import Foundation

struct MoviesResponseModel: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieModel: Codable, Identifiable {
    let adult: Bool
    let backdropPath, posterPath, releaseDate: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String
    let popularity: Double
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieModel {
    func backdropImageUrl() -> URL? {
        //Replace w500 -> original
        if let backdrop = backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdrop)") {
            return url
        } else {
            return nil
        }
    }
    
    func posterImageUrl() -> URL? {
        //Replace w500 -> original
        if let poster = posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)") {
            return url
        } else {
            return nil
        }
    }
}
