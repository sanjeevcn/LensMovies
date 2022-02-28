//
//  MovieDetailView.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject var dataModel: DataModel = .shared
    @EnvironmentObject var viewModel: LensMovieViewModel
    
    let model: MovieModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CustomAsyncImage((model.backdropImageUrl() ?? model.posterImageUrl())!, size: 300, text: "Somedays it just loads faster..")
                    .frame(maxHeight: 300)
                    .padding(.horizontal)
                    .tag("top")
                
                Text(model.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(maxHeight: 100)
                
                HStack(spacing: 10) {
                    Spacer()
                    Text("Released: \(model.releaseDate ?? "")")
                    Text("Rating: \(model.voteAverage.description)")
                    Spacer()
                }.font(.subheadline)
                
                HStack(spacing: 10) {
                    Spacer()
                    Text("Original Title: \(model.originalTitle)")
                    if let lang = model.originalLanguage {
                        Text("Language: \(lang)")
                    }
                    Spacer()
                }.font(.subheadline)
                
                Label("\(dataModel.checkIfItemExist(model.id.description) ? "Added" : "Add") to favorite", systemImage: dataModel.checkIfItemExist(model.id.description) ? "star.fill" : "star")
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .onTapGesture {
                        Task {
                            if dataModel.checkIfItemExist(model.id.description) {
                                dataModel.deleteItem(model.id.description)
                            } else {
                                dataModel.saveToFavorite(model)
                                viewModel.activeAlert = .custom("Added to favorite!")
                            }
                        }
                    }
                
                VStack(alignment: .leading) {
                    if let overview = model.overview, !overview.isEmpty {
                        Text("Overview: \(overview)")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .frame(minHeight: 100)
                    }
                }
                Spacer()
                
            }.padding()
        }
    }
}

