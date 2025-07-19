//
//  SpinningView.swift
//  Animated
//
//  Created by Parimal Devi on 19/07/25.
//

import SwiftUI

struct ResetEllipse: View {
    var body: some View {
        Ellipse()
            .frame(width: 200, height: 200)
            .foregroundStyle(.orange)
    }
}

struct SpinningEllipse: View {
    @State private var width: CGFloat = 200
    var body: some View {
        Ellipse()
            .frame(width: width, height: 200)
            .foregroundStyle(.orange)
            .onAppear {
                withAnimation(.easeInOut.repeatForever(autoreverses: true)) {
                    width = 0
                }
            }
    }
}

struct SpinningView: View {
    @State private var isSpinning = false
    var body: some View {
        VStack{
            Spacer()
            ZStack {
                if isSpinning{
                    SpinningEllipse()
                } else {
                    ResetEllipse()
                }
            }
            Spacer()
            PlayResetButton(animating: $isSpinning)
        }
    }
}

#Preview {
    SpinningView()
}
