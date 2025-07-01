//
//  GeometryView.swift
//  An example of how to use GeometryReader to layout orientation.
//
//  Created by Lionel Ng on 1/7/25.
//

import SwiftUI

struct GeometryView: View {
    // Track orientation
    @State private var isLandscape: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if isLandscape {
                    // Landscape layout
                    HStack {
                        blueCircle
                            .frame(width: geometry.size.width / 2)
                            .padding()
                        VStack {
                            Spacer()
                            HStack(spacing: 120) {
                                buttonsRow
                            }
                            .frame(width: geometry.size.width / 3)
                        }
                        .padding(.bottom, 32)
                    }
                } else {
                    // Portrait layout
                    blueCircle
                    HStack(spacing: geometry.size.width / 2) {
                        buttonsRow
                    }
                }
            }
            .frame(width: geometry.size.width)
            .onAppear {
                isLandscape = geometry.size.width > geometry.size.height
            }
            .onChange(of: geometry.size) { _, newSize in
                isLandscape = newSize.width > newSize.height
            }
        }
    }
    
    private var blueCircle: some View {
        // Since this is wrapped in a container, @ViewBuilder is not needed
        ZStack {
            Circle()
                .fill(Color.blue)
            Rectangle()
                .frame(width: 165, height: 4)
                .offset(x: 70)
                .rotationEffect(.degrees(-45))
            Circle()
                .frame(width: 10, height: 10)
        }
        .frame(width: 375, height: 375)
    }
    
    @ViewBuilder
    private var buttonsRow: some View {
        // USE @ViewBuilder when there is no container
        Image(systemName: "xmark.circle.fill")
            .resizable()
            .frame(width: 72, height: 72)
            .foregroundColor(.gray)
        Image(systemName: "play.circle.fill")
            .resizable()
            .frame(width: 72, height: 72)
            .foregroundColor(.green)
    }
}

#Preview {
    GeometryView()
}
