//
//  HeartPulse.swift
//  Animated
//
//  Created by Parimal Devi on 19/07/25.
//

import SwiftUI

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY ))
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.height/4),
                      control1:CGPoint(x: rect.midX, y: rect.height*3/4),
                      control2: CGPoint(x: rect.minX, y: rect.midY))
        
        path.addArc(center: CGPoint( x: rect.width/4,y: rect.height/4),
                    radius: (rect.width/4),
                    startAngle: Angle(radians: Double.pi),
                    endAngle: Angle(radians: 0),
                    clockwise: false)
        path.addArc(center: CGPoint( x: rect.width * 3/4,y: rect.height/4),
                    radius: (rect.width/4),
                    startAngle: Angle(radians: Double.pi),
                    endAngle: Angle(radians: 0),
                    clockwise: false)
        
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.height),
                      control1: CGPoint(x: rect.width, y: rect.midY),
                      control2: CGPoint(x: rect.midX, y: rect.height*3/4))
        
        return path
    }
}

struct ResetHeart: View {
    var body: some View {
        Heart()
            .frame(width: 150, height: 150)
            .foregroundStyle(.pink)
            .shadow(radius: 10)
            .frame(width: 300, height: 300)
    }
}

struct PulsingHeart: View {
    
    @State private var heartPulse: CGFloat = 1
    var body: some View {
        Heart()
            .frame(width: 150, height: 150)
            .foregroundStyle(.pink)
            .scaleEffect(heartPulse)
            .shadow( radius: 10)
            .onAppear{
                withAnimation(.easeInOut.repeatForever(autoreverses: true).speed(0.5)) {
                    heartPulse = 1.25 * heartPulse
                }
            }
    }
}

struct HeartPulse: View {
    @State private var pulsing = true
    var body: some View {
        VStack {
            Spacer()
            ZStack{
                if pulsing {
                    PulsingHeart()
                } else {
                    ResetHeart()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    HeartPulse()
}
