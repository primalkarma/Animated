//
//  RollinRainbowView.swift
//  Animated
//
//  Created by Parimal Devi on 19/07/25.
//

import SwiftUI

struct PlayResetButton: View {
    @Binding var animating: Bool // Binds to the animation state in the parent view
    var resetOnly: Bool = false // If true, acts as a dedicated reset button
    var resetAction: (() -> Void)? // Optional closure for reset action

    var body: some View {
        Button {
            if resetOnly {
                resetAction?() // Call the reset action if provided
                animating = false // Set animating to false after reset
            } else {
                animating.toggle() // Toggle animation state for play/reset mode
            }
        } label: {
            Text(resetOnly ? "Reset" : (animating ? "Reset" : "Play")) // Dynamic button text
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .background(resetOnly ? Color.red : (animating ? Color.red : Color.green)) // Dynamic background color
                .clipShape(Capsule()) // Makes the button rounded
        }
        .padding(.bottom) // Adds space below the button
    }
}

struct RollinRainbowView: View {
    @State private var isAnimating = false
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 10)
    @State private var colors: [Color] = [.pink, .mint, .orange, .teal, .yellow, .cyan, .purple, .blue]
    @State private var scaleFactor : CGFloat = 3

    let springAnimation = Animation.spring(response: 0.4, dampingFraction: 0.75, blendDuration: 0.9)

    let numCircles = 100


    var body: some View {
        VStack {
            Text("Tap on the dots to make them roll!")
                .font(.title3)
                .padding(.vertical, 30)

            Spacer()

            LazyVGrid(columns: gridColumns) {
                ForEach(0..<numCircles, id: \.self) { index in
                    Circle()
                        .foregroundStyle(colors[index % colors.count]) // Use foregroundStyle for color
                        .scaleEffect(scaleFactor) // Apply the initial scale factor
                        .animation(springAnimation.delay((Double(index).truncatingRemainder(dividingBy: 10) / 20)).repeatCount(2, autoreverses: true), value: scaleFactor)
                        .onTapGesture {
                                isAnimating = true // Set animating to true (conceptual, indicates activity)
                                scaleFactor = (Double(index + 1) / 4) // Change scaleFactor to trigger animation
                            }
                }
            }

            Spacer()
            PlayResetButton(animating: $isAnimating, resetOnly: true, resetAction: {
                self.scaleFactor = 3 // Resets all circles to their original size
            })
        }
        
        .navigationTitle("Rollin' Rainbow")
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    RollinRainbowView()
}
