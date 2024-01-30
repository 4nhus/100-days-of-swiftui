//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anh Nguyen on 30/1/2024.
//

import SwiftUI

struct ContentView: View {
    enum Choice: Int {
        case rock, paper, scissors
    }
    
    @State private var computerChoice: Choice =  Choice(rawValue: Int.random(in: 0...2))!
    @State private var playerShouldWin: Bool = Bool.random()
    @State private var score: Int = 0
    @State private var questionsAsked: Int = 0
    @State private var gameOver = false
    
    var computerMove: String {
        switch computerChoice {
        case .rock:
            "🗿"
        case .paper:
            "💵"
        case .scissors:
            "👩‍❤️‍👩"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Score: \(score)")
                Text("Computer plays \(computerMove)")
                Text(playerShouldWin ? "Pick the move that wins:" : "Pick the move that loses")
                HStack {
                    Button("🗿") {
                        makeChoice(.rock)
                    }
                    Button("💵") {
                        makeChoice(.paper)
                    }
                    Button("👩‍❤️‍👩") {
                        makeChoice(.scissors)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.secondary)
                .font(.largeTitle)
            }
            .navigationTitle("RockPaperScissors")
            .alert("Game over", isPresented: $gameOver) {
                Button("Restart") {
                    score = 0
                    questionsAsked = 0
                    newQuestion()
                }
            } message: {
                Text("Your final score was \(score).")
            }
        }
    }
    
    func makeChoice(_ choice: Choice) {
        if playerShouldWin && choice.rawValue == (computerChoice.rawValue + 1) % 3 {
            score += 1
        } else if !playerShouldWin && choice.rawValue == (computerChoice.rawValue + 2 ) % 3 {
            score += 1
        } else {
            score -= 1
        }
        
        questionsAsked += 1
        if questionsAsked == 10 {
            gameOver = true
        } else {
            newQuestion()
        }
    }
    
    func newQuestion() {
        computerChoice = Choice(rawValue: Int.random(in: 0...2))!
        playerShouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
