//
//  ActivityIndicatorView.swift
//  NewsFlasher
//
//  Created by Chaitali Lad on 12/07/23.
//

import SwiftUI

struct ActivityIndicatorView: View {

    // Boolean state to control animation
    @State private var isAnimating: Bool = false

    // Size of activity indicator view
    var size: CGFloat = UIScreen.main.bounds.width * 0.18

    var body: some View {
        VStack {
            Spacer()

            GeometryReader { (geometry: GeometryProxy) in
                ForEach(0..<5) { index in
                    Group {
                        Circle()
                            .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                            .scaleEffect(calculateScale(index: index)) // Calculates scale factor based on index and animation state
                            .offset(y: calculateYOffset(geometry)) // Calculates y-offset based on geometry
                    }.frame(width: geometry.size.width, height: geometry.size.height)
                        .background(Color.clear)
                        .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360)) // Rotates the view based on animation state
                        .animation(Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5) // Defines animation timing curve
                            .repeatForever(autoreverses: false), value: isAnimating) // Repeats animation indefinitely
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                self.isAnimating = true // Starts animation when the view appears
            }
            .frame(width: size, height: size)
            .foregroundColor(Color.appThemeColor) // Sets the color of the view

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Calculates scale factor based on index and animation state

    func calculateScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }

    // MARK: - Calculates y-offset based on geometry

    func calculateYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
}

