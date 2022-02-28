//
//  ContentView.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: LensMovieViewModel
    
    var body: some View {
        VStack {
            CustomSearchBar(text: $viewModel.searchText) {
                Task {
                    await viewModel.searchMovie(viewModel.searchText)
                }
            }
            
            List(viewModel.moviesList, id: \.id) { item in
                NavigationLink(destination: MovieDetailView(model: item)
                                .environmentObject(viewModel)) {
                    MovieCardView(model: item)
                        .padding()
                        .listRowSeparator(.hidden)
                }
            }.listStyle(.plain)
//                .searchable(text: $viewModel.searchText, prompt: "Start searching..")
        }
    }
}

struct MovieCardView: View {
    let model: MovieModel
    
    var body: some View {
        HStack {
            if let imageUrl = model.posterImageUrl() {
                CustomAsyncImage(imageUrl, size: 70)
                    .padding(.trailing)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(model.originalTitle)
                    .font(.headline)
                
                if let overview = model.overview, !overview.isEmpty {
                    Text("Overview: \(overview)")
                        .font(.footnote)
                        .frame(height: 100)
                }
                
                Text("Released: \(model.releaseDate ?? "")")
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

struct CustomAsyncImage: View {
    let imageUrl: URL
    var size: CGFloat
    let text: String?
    
    init(_ imageUrl: URL, size: CGFloat, text: String? = nil) {
        self.imageUrl = imageUrl
        self.size = size
        self.text = text
    }
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
                .frame(idealHeight: size)
        } placeholder: {
            ZStack {
                Color.accentColor.opacity(0.1)
                    .cornerRadius(8)
                ProgressView().scaleEffect(1.0, anchor: .center)
                if let placeholderText = text {
                    Text(placeholderText)
                        .foregroundColor(.accentColor.opacity(0.5))
                        .offset(x: 0, y: 50)
                }
            }.frame(width: size, height: size)
        }
        .frame(idealHeight: size)
    }
}


struct CustomSearchBar: UIViewRepresentable {

    @Binding var text: String
    var onSearchButtonClicked: (() -> Void)? = nil

    class Coordinator: NSObject, UISearchBarDelegate {

        let control: CustomSearchBar

        init(_ control: CustomSearchBar) {
            self.control = control
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            control.text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            control.onSearchButtonClicked?()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<CustomSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CustomSearchBar>) {
        uiView.text = text
    }

}
