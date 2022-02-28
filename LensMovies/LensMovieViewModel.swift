//
//  LensMovieViewModel.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import Foundation

enum ActiveAlert { case custom(_ message: String) }

@MainActor
class LensMovieViewModel: ObservableObject {
    
    static let shared = LensMovieViewModel()
    
    @Published var dataManager: PersistenceContainer
    @Published var activeAlert: ActiveAlert?
    @Published var isLoading: Bool
    @Published var errorMessage: Error?
    
    @Published var moviesList: [MovieModel]
    @Published var pageNo: Int
    
    @Published var searchText: String
    
    init() {
        self.isLoading = false
        self.errorMessage = nil
        
        self.dataManager = .shared
        self.moviesList = []
        self.pageNo = 1 //This is needs to be updated
        self.searchText = ""
    }
}

extension LensMovieViewModel: ServiceHandler {
    
    func searchMovie(_ name: String = "Almost Friends") async {
        guard !name.isEmpty else {
            Task { self.activeAlert = .custom("Please enter movie name!") }
            return
        }
        
        Task { self.isLoading = true }
        defer { Task { self.isLoading = false } }
        
        do {
            let moviesResponse: MoviesResponseModel = try await serve(endpoint: .searchMovie(name, pageNo))
            
            DispatchQueue.main.async {
                self.moviesList = moviesResponse.results
            }
            
        } catch (let err as CustomError) {
            Task {
                self.activeAlert = .custom(err.localizedDescription)
            }
        } catch (let err) {
            Task {
                self.activeAlert = .custom(err.localizedDescription)
            }
        }
    }
}
