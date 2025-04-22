//
//  BakingTimer.swift
//  bakemate
//
//  Created by Olivia Kirby on 4/13/25.
//

import SwiftUI

struct BakingTimer: View {
    @State private var timer: Timer? = nil
    @State private var timeRemaining = 1800
    @State private var timerOn = true
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .frame(width:160, height:150)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(style: StrokeStyle(
                                lineWidth: 0.9, dash: [8]))
                            .foregroundColor(Color("grey_line"))
                    )
                VStack {
                    Text("Baking Timer")
                        .font(.system(size:20))
                    Text(timeString(from: timeRemaining))
                        .font(.system(size:40))
                        .padding(-6)
                    HStack {
                        Button {
                            if timer == nil {
                                timerOn = true
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
                                    if (timeRemaining > 0 && timerOn) {
                                        timeRemaining -= 1
                                    }
                                    else {
                                        t.invalidate()
                                        timer = nil
                                    }
                                }
                            }

                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:40, height:20)
                                    .foregroundColor(Color("light_green"))
                                Text("Start")
                                    .foregroundColor(.white)
                                    .font(.system(size:12))
                            }
                        }
                        Button {
                            timerOn = false
                            timer?.invalidate()
                            timer = nil
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius:10)
                                    .frame(width:40, height:20)
                                    .foregroundColor(Color("pink_c"))
                                Text("Stop")
                                    .foregroundColor(.white)
                                    .font(.system(size:12.5))
                            }
                        }
                        Button {
                            timeRemaining = 1800
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.black)
                        }
                    }
                    HStack {
                        Button {
                            if (timerOn == false) {
                                timeRemaining -= 300
                            }
                        } label: {
                            Text("-5")
                                .foregroundColor(.black)
                        }
                        Button {
                            if (timerOn == false) {
                                timeRemaining += 300
                            }
                        } label: {
                            Text("+5")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    BakingTimer()
}
