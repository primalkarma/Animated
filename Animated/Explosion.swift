//
//  Explosion.swift
//  Animated
//
//  Created by Parimal Devi on 19/07/25.
//

import SwiftUI


struct Explosion: View {
    @State private var isExploded = false
    var body: some View {
        VStack{
            Spacer()
            ZStack {
                ForEach(0..<150) { _ in
                    Rectangle()
                        .rotation(Angle(degrees: Double.random(in: 0..<360)))
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.indigo)
                        .offset(x: isExploded ? (Double.random(in:-1...1)*500) : 0, y: isExploded ? (Double.random(in: -1...1) * 500) : 0)
                        .opacity(isExploded ? 0 : 1)
                        .animation(.easeInOut.speed(0.3), value: isExploded)
                        .padding()
                }
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(.indigo)
                    .opacity(isExploded ? 0 : 1)
                    .animation(.easeInOut.speed(0.6), value: isExploded)
                    .padding()
            }
            Spacer()
        }
    }
}

#Preview {
    Explosion()
}
