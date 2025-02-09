//
//  CountdownView.swift
//  DeepDishLie
//
//  Created by Morten Bjerg Gregersen on 09/02/2025.
//

import SwiftUI

struct CountdownView: View {
    let eventDate: Date
    @State private var count = 0
    @State private var timeRemaining: String?
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    FlickeringPizzaView(repeating: true)
                    if let timeRemaining {
                        Text("The conference will start in:")
                            .font(.title)
                        Text(timeRemaining)
                            .font(.largeTitle)
                            .monospacedDigit()
                            .contentTransition(.numericText(countsDown: true))
                            .animation(.default, value: timeRemaining)
                            .padding(.top, 16)
                    } else {
                        Text("The conference has started!")
                            .font(.largeTitle)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear(perform: updateCountdown)
            .onReceive(timer) { _ in updateCountdown() }
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .background(Color.splashBackground)
        }
    }

    private func updateCountdown() {
        let now = Date()
        let remaining = eventDate.timeIntervalSince(now)

        if remaining > 0 {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = remaining > 86_400 ? [.day, .hour, .minute, .second] : [.hour, .minute, .second]
            formatter.unitsStyle = .brief

            timeRemaining = formatter.string(from: remaining) ?? "Calculating..."

        } else {
            timeRemaining = nil
        }
    }
}

#Preview {
    CountdownView(eventDate: Date().addingTimeInterval(84.4 * 86_400))
}
