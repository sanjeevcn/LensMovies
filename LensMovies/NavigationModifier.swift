//
//  NavigationModifier.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import SwiftUI

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier(HiddenNavigationBar())
    }
    
    func appNavigationBarStyle() -> some View {
        modifier(UnHideNavigationBar())
    }
}

struct UnHideNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct CustomNavigationTitle: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle).bold()
            Spacer()
        }.frame(height: 100)//.padding()
    }
}
