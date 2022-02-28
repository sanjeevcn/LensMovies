//
//  ButtonStyleModifier.swift
//  LensMovies
//
//  Created by Sanjeev on 28/02/22.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    let width: CGFloat
    let color: Color
    
    init(_ width: CGFloat = 300, color: Color = .accentColor) {
        self.width = width
        self.color = color
    }
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .font(.title3)
                .foregroundColor(.white)
            Spacer()
        }.padding()
            .frame(width: width, height: 50, alignment: .center)
            .background(color.cornerRadius(8))
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
    }
}
