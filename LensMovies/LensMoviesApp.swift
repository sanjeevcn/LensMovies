//
//  LensMoviesApp.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import SwiftUI

@main
struct LensMoviesApp: App {
    @ObservedObject var dataModel: PersistenceContainer = .shared
    @ObservedObject var viewModel: LensMovieViewModel = .shared
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                    .environmentObject(viewModel)
                    .environment(\.managedObjectContext, dataModel.context)
                    .modifier(AlertViewModifier())
                    .navigationTitle(Text(Constants.appName))
            }.edgesIgnoringSafeArea(.all)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                debugPrint("App going active")
            case .inactive:
                debugPrint("App going inactive")
            case .background:
                debugPrint("App going background")
                dataModel.saveContext()
            default:
                debugPrint("Unknown scenePhase")
            }
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        dataModel.saveContext()
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


